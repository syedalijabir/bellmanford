/*
 * Copyright (c) 2009 Xilinx, Inc.  All rights reserved.
 *
 * Xilinx, Inc.
 * XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A
 * COURTESY TO YOU.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS
 * ONE POSSIBLE   IMPLEMENTATION OF THIS FEATURE, APPLICATION OR
 * STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION
 * IS FREE FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE
 * FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.
 * XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO
 * THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO
 * ANY WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE
 * FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.
 *
 */

/*
 * helloworld.c: simple test application
 */

#include <stdio.h>
#include "platform.h"
#include "xio.h"
#include "xgpio.h"
#include "xuartlite.h"
#include "xuartlite_l.h"
#include "xparameters.h"
#include "xstatus.h"
#include "bf_16X16.h"

Xuint32 ddr   = 0xBF000000;
Xuint32 deci  = 0xBF004000;
Xuint32 lpf   = 0xBF004100;
Xuint32 uart  = XPAR_RS232_UART_1_BASEADDR;
Xuint32 *leds = XPAR_LEDS_8BITS_BASEADDR;
Xuint32 core  = XPAR_BF_16X16_0_BASEADDR;
Xuint32 reg0  = BF_16X16_SLV_REG0_OFFSET;
Xuint32 reg1  = BF_16X16_SLV_REG1_OFFSET;
Xuint32 reg2  = BF_16X16_SLV_REG2_OFFSET; // read only
Xuint32 reg3  = BF_16X16_SLV_REG3_OFFSET;
Xuint32 reg4  = BF_16X16_SLV_REG4_OFFSET; // read only
Xuint32 reg5  = BF_16X16_SLV_REG5_OFFSET; // read only
Xuint32 reg6  = BF_16X16_SLV_REG6_OFFSET;
Xuint32 reg7  = BF_16X16_SLV_REG7_OFFSET;
Xuint32 reg8  = BF_16X16_SLV_REG8_OFFSET;
Xuint32 reg9  = BF_16X16_SLV_REG9_OFFSET;

const int n_brams = 16; // 16X16
const int depth   = 16;
const int r  = 128,c  = 128, total  = 16384;
const int dr = 16, dc = 16,  dtotal = 256;
u8 rx,tx;

u8 bram[16][16];
u8 result[16][16];
u8 rec[16][16];
u16 prevdist[16][16];

//u8 bram[16][16] ={{0,   0,  0,   0,   0,   0,   0,  0}, //{145,   79,  175,   38,   27,   21,   46,  140}
//			  { 21,  199,  140,   13,   71,  255,   21,   78},
//			  {  10,  113,  232,  145,  113,  252,    5,   15},
//			  {177,  169,  112,  131,   70,  178,  194,  170},
//			  { 187,   42,   55,    8,   53,   97,   33,   31},
//			  {238,   39,   67,  153,  250,  183,  240,  242},
//			  { 94,   14,   45,   56,  214,  189,  208,  148},
//			  {0,  0,  0,  0,  0,  0,  0,  0}}; // {202,  166,  232,  112,  221,  232,  147,  130}

XUartLite uart_dce;
void Uart_Init(void)
{
	XUartLite_Initialize(&uart_dce, XPAR_RS232_UART_1_DEVICE_ID);
}

void reg_check()
{
	Xuint32 lays;
	Xuint32 dahi = 0xFFFFFFFF;
	// Reg0
	BF_16X16_mWriteReg(core,reg0,dahi);
	lays = BF_16X16_mReadReg(core,reg0);
	if (lays == dahi)
		xil_printf("REG0 Reporting : Good\r\n");
	else
		xil_printf("REG0 Party Pooper\r\n");
	// Reg1
	BF_16X16_mWriteReg(core,reg1,dahi);
	lays = BF_16X16_mReadReg(core,reg1);
	if (lays == dahi)
		xil_printf("REG1 Reporting : Good\r\n");
	else
		xil_printf("REG1 Party Pooper\r\n");
	// Reg3
	BF_16X16_mWriteReg(core,reg3,dahi);
	lays = BF_16X16_mReadReg(core,reg3);
	if (lays == dahi)
		xil_printf("REG3 Reporting : Good\r\n");
	else
		xil_printf("REG3 Party Pooper\r\n");
	// Reg6
	BF_16X16_mWriteReg(core,reg6,dahi);
	lays = BF_16X16_mReadReg(core,reg6);
	if (lays == dahi)
		xil_printf("REG6 Reporting : Good\r\n");
	else
		xil_printf("REG6 Party Pooper\r\n");
	// Reg7
	BF_16X16_mWriteReg(core,reg7,dahi);
	lays = BF_16X16_mReadReg(core,reg7);
	if (lays == dahi)
		xil_printf("REG7 Reporting : Good\r\n");
	else
		xil_printf("REG7 Party Pooper\r\n");
	// Reg8
	BF_16X16_mWriteReg(core,reg8,dahi);
	lays = BF_16X16_mReadReg(core,reg8);
	if (lays == dahi)
		xil_printf("REG8 Reporting : Good\r\n");
	else
		xil_printf("REG8 Party Pooper\r\n");
	// Reg9
	BF_16X16_mWriteReg(core,reg9,dahi);
	lays = BF_16X16_mReadReg(core,reg9);
	if (lays == dahi)
		xil_printf("REG9 Reporting : Good\r\n");
	else
		xil_printf("REG9 Party Pooper\r\n");
}

void BRAM_WRITE_N_CHECK()
{
	Xuint32 inst,data,out;
	int i,j=0,d;
	xil_printf("Writing Values to BRAMs core\r\n");
	for(i=0;i<n_brams;i++)
	{
		xil_printf("Writing to BRAM_%x\r\n",i);
		for(j=0;j<depth;j++)
		{
			inst = 1;				// 2'b01 -- 0 start 1 write on port B
			inst = (inst<<10) | i;  // BRAM number
			inst = (inst<<10) | j;	// BRAM address port B
			inst = (inst<<10);		// BRAM address port A :unused in writing:
			BF_16X16_mWriteReg(core,reg1,inst);
			data = 6;						// 1st  3bits for direction, kept 6
			data = (data<<8) | bram[i][j]; 	// Next 8bits for pixel value
			if (i==0 && j==0)
				data = (data<<21);			 	// Last 21bits for initial infinite cost , first pixel cost =0
			else
				data = (data<<21) | 1048576; 	// Last 21bits for initial infinite cost 0x100000
			BF_16X16_mWriteReg(core,reg0,data);
			xil_printf("ADDR = %x\tDATA = %d\r\n",j,bram[i][j]);
		}
		for(d=0;d<999999;d++);
	}
	for(i=0;i<n_brams;i++)
	{
		xil_printf("Reading Back from BRAM_%x\r\n",i);
		for(j=0;j<depth;j++)
		{
			inst = 0;				// 2'b00 -- 0 start 0 write on port B
			inst = (inst<<10) | i;  // BRAM number
			inst = (inst<<10);		// BRAM address port B :unused in reading:
			inst = (inst<<10) | j;	// BRAM address port A
			BF_16X16_mWriteReg(core,reg1,inst);
			data = 6;						// 1st  3bits for direction
			data = (data<<8) | bram[i][j]; 	// Next 8bits for pixel value
			if (i==0 && j==0)
				data = (data<<21);			 	// Last 21bits for initial infinite cost , first pixel cost =0
			else
				data = (data<<21) | 1048576; 	// Last 21bits for initial infinite cost 0x100000
			out  = BF_16X16_mReadReg(core,reg2);
			if (data == out)
				xil_printf("Correct Read\r\n");
			else
				xil_printf("Ghalat Read\r\n");
		}
		for(d=0;d<999999;d++);
	}
}

void print(char *str);

void shortest_path(void)
{
	Xuint32 inst,data,out;
	int i,j=0,d,iter_no,ra,wa;
	char done = 0,state;
	*(leds)=0xFF;
	reg_check();
	inst = 0;
	BF_16X16_mWriteReg(core,reg3,inst); // Reset = 0
	BRAM_WRITE_N_CHECK();
	inst = 1;
	BF_16X16_mWriteReg(core,reg3,inst); // Manually reset the core
	xil_printf("Sending Start Signal to BF Core\r\n");
	inst = 2;						// 2'b10 -- 1 start 0 write on port B
	inst = (inst<<30);
	BF_16X16_mWriteReg(core,reg3,0); 	// Disable reset signal to the core
	BF_16X16_mWriteReg(core,reg1,inst);
	/*xil_printf("Start Signal sent\r\nWaiting for Core to Stop...\r\n");
	done = 0;
	while(done == 0)
	{
		out     = BF_16X16_mReadReg(core,reg4);
		//data    = BF_16X16_mReadReg(core,reg5);
		done    = out;
		if (done == 1)
		{
			inst = 0;							// 2'b00 -- 0 start 0 write on port B

*/
		for(d=0;d<5850;d++);// 5600,5850
		out = BF_16X16_mReadReg(core,reg4);
		BF_16X16_mWriteReg(core,reg1,0);	// stop BF Core
		done    = out;
		iter_no = (out>>8);
		ra = data & 0x000003FF;
		wa = (data & 0x000FFB00)>>10;
		state = (data & 0x00300000)>>20;
		xil_printf("Iteration Number : %d\tDone : %d\r\n",iter_no,done);
		xil_printf("RA : %d\tWA : %d\tState : %d\r\n",ra,wa,state);
	//}
	//*(leds) = 0xFF;
	xil_printf("Reading Values Back from BRAM core\r\n");
	for(i=0;i<n_brams;i++)
	{
		xil_printf("Reading from BRAM_%x\r\n",i);
		for(j=0;j<depth;j++)
		{
			inst = 0;				// 2'b00 -- 0 start 0 write on port B
			inst = (inst<<10) | i;  // BRAM number
			inst = (inst<<10);		// BRAM address port B :unused in reading:
			inst = (inst<<10) | j;	// BRAM address port A
			BF_16X16_mWriteReg(core,reg1,inst);
			out = BF_16X16_mReadReg(core,reg2);
			result[i][j]   = (out>>29);
			prevdist[i][j] = out & 0x001FFFFF;
		}
		//for(d=0;d<999999;d++);
	}
	xil_printf("RESULT:\r\n");
	for(i=0;i<n_brams;i++)
	{
		for(j=0;j<depth;j++)
		{
			xil_printf("%d\t",result[i][j]);
		}
		xil_printf("\r\n");
	}
	xil_printf("Prevdist:\r\n");
	for(i=0;i<n_brams;i++)
	{
		for(j=0;j<depth;j++)
		{
			xil_printf("%d\t",prevdist[i][j]);
		}
		xil_printf("\r\n");
	}
}

void serial_pyramid(void)
{
	int i,j,k,l,sum;
	u8 mask[3][3];
    // Receive Image
    for(j=0,i=0;i<r;)
	{
		if(XUartLite_Recv(&uart_dce,(&(rx)),1))
		{
			XIo_Out8(ddr+i+j,rx);
			j = j + c;
		}
		if(j == total)
		{
			j = 0;
			i++;
		}
	}

	// Decimate
	k=0;
	l=0;
	for(i=0,j=0;i<total;)
	{
		rx = XIo_In8((Xuint32)(ddr+i+j));
		XIo_Out8((Xuint32)(deci+k+l),rx);
		j = j + 8;
		k++;
		if(j==c)
		{
			j=0;
			l=l+dr;
			k=0;
			i=i+8*c;
		}
	}

	// Low Pass Filtering + Related Stuff
	// Make first and last row as zero
	for (i=0,j=(dr-1)*dc;i<dc;i++)
	{
		XIo_Out8(deci+i,0x00);
		XIo_Out8(lpf+i,0x00);
		XIo_Out8(deci+j,0x00);
		XIo_Out8(lpf+j,0x00);
		j++;
	}
	// First Column and the Last column remain the same *partial overlap*
	for(i=0;i<dtotal;i=i+dc)
	{
		rx = XIo_In8(deci+i);
		XIo_Out8(lpf+i,rx);
	}
	for(j=dc-1;j<dtotal;j=j+dc)
	{
		rx = XIo_In8(deci+j);
		XIo_Out8(lpf+j,rx);
	}
	// Apply Low Pass Filter 3x3
	for(i=0,j=0;i<dtotal-dr-dr;)
	{
		mask[0][0] = XIo_In8(deci+i+j);
		mask[0][1] = XIo_In8(deci+i+j+1);
		mask[0][2] = XIo_In8(deci+i+j+2);
		mask[1][0] = XIo_In8(deci+i+dc+j);
		mask[1][1] = XIo_In8(deci+i+dc+j+1);
		mask[1][2] = XIo_In8(deci+i+dc+j+2);
		mask[2][0] = XIo_In8(deci+i+dc+dc+j);
		mask[2][1] = XIo_In8(deci+i+dc+dc+j+1);
		mask[2][2] = XIo_In8(deci+i+dc+dc+j+2);
		sum = mask[0][0]+mask[0][1]+mask[0][2]+
			  mask[1][0]+mask[1][1]+mask[1][2]+
			  mask[2][0]+mask[2][1]+mask[2][2];
		tx = (u8)(sum/9);
		XIo_Out8(lpf+i+j+dc+1,tx);
		j++;
		if(j==dc-2)
		{
			j=0;
			i=i+dr;
		}
	}

	// Filling Temporary 2D Image
	k=0;
	l=0;
	for (i=0,j=0;i<dtotal;)
	{
		bram[k][l] = XIo_In8(lpf+i+j);
		j=j+dc;
		k++;
		if (j==dtotal)
		{
			k=0;
			j=0;
			i++;
			l++;
		}
	}
}

int main()
{
    init_platform();
    Uart_Init();
    int i,j;

    // Receive Data From Matlab + Pyramid
    serial_pyramid();
//
//    for(i=0;i<256;i++)
//	{
//		*(leds)=i;
//		for (j=0;j<999999;j++);
//	}

	// Run Core
	shortest_path();

	// Transmit Image
	/*for (i=0,j=0;i<dtotal;)
	{
		tx = XIo_In8(lpf+i+j);
		XUartLite_SendByte(uart,tx);
		j=j+dc;
		if (j==dtotal)
		{
			j=0;
			i++;
		}
	}*/
	// Transmit bram[8][8]
	/*for (i=0;i<n_brams;i++)
	{
		for(j=0;j<depth;j++)
		{
			XUartLite_SendByte(uart,bram[j][i]);
		}
	}*/
	while(1)
    {
		for(i=0;i<256;i++)
		{
			*(leds)=i;
			for (j=0;j<99999;j++);
		}
    }
    cleanup_platform();

    return 0;
}
