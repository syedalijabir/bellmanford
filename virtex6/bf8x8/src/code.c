//
// Owner: Ali Jabir
// Email: syedalijabir@gmail.com
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#include <stdio.h>
#include "platform.h"
#include "xparameters.h"
#include "bf_8x8.h"
#include "xio.h"
#include "xuartlite_l.h"
#include "math.h"

Xuint32 core  = XPAR_BF_8X8_0_BASEADDR;
Xuint32 reg0  = BF_8X8_SLV_REG0_OFFSET;
Xuint32 reg1  = BF_8X8_SLV_REG1_OFFSET;
Xuint32 reg2  = BF_8X8_SLV_REG2_OFFSET; // read only
Xuint32 reg3  = BF_8X8_SLV_REG3_OFFSET;
Xuint32 reg4  = BF_8X8_SLV_REG4_OFFSET; // read only
Xuint32 reg5  = BF_8X8_SLV_REG5_OFFSET; // read only
Xuint32 reg6  = BF_8X8_SLV_REG6_OFFSET;
Xuint32 reg7  = BF_8X8_SLV_REG7_OFFSET;
Xuint32 reg8  = BF_8X8_SLV_REG8_OFFSET;
Xuint32 reg9  = BF_8X8_SLV_REG9_OFFSET;
Xuint32 *leds = XPAR_LEDS_8BITS_BASEADDR;
Xuint32 uart  = XPAR_RS232_UART_1_BASEADDR;

const int n_brams = 8; // 8x8
const int depth   = 8;

u8 bram[8][8] ={{0,   0,  0,   0,   0,   0,   0,  0}, //{145,   79,  175,   38,   27,   21,   46,  140}
			      { 21,  199,  140,   13,   71,  255,   21,   78},
				  {  10,  113,  232,  145,  113,  252,    5,   15},
				  {177,  169,  112,  131,   70,  178,  194,  170},
				  { 187,   42,   55,    8,   53,   97,   33,   31},
				  {238,   39,   67,  153,  250,  183,  240,  242},
				  { 94,   14,   45,   56,  214,  189,  208,  148},
				  {0,  0,  0,  0,  0,  0,  0,  0}}; // {202,  166,  232,  112,  221,  232,  147,  130}

unsigned char result[8][8];
unsigned char rec[8][8];
unsigned int prevdist[8][8];

void reg_check()
{
	Xuint32 lays;
	Xuint32 dahi = 0xFFFFFFFF;
	// Reg0
	BF_8X8_mWriteReg(core,reg0,dahi);
	lays = BF_8X8_mReadReg(core,reg0);
	if (lays == dahi)
		xil_printf("REG0 Reporting : Good\r\n");
	else
		xil_printf("REG0 Party Pooper\r\n");
	// Reg1
	BF_8X8_mWriteReg(core,reg1,dahi);
	lays = BF_8X8_mReadReg(core,reg1);
	if (lays == dahi)
		xil_printf("REG1 Reporting : Good\r\n");
	else
		xil_printf("REG1 Party Pooper\r\n");
	// Reg3
	BF_8X8_mWriteReg(core,reg3,dahi);
	lays = BF_8X8_mReadReg(core,reg3);
	if (lays == dahi)
		xil_printf("REG3 Reporting : Good\r\n");
	else
		xil_printf("REG3 Party Pooper\r\n");
	// Reg6
	BF_8X8_mWriteReg(core,reg6,dahi);
	lays = BF_8X8_mReadReg(core,reg6);
	if (lays == dahi)
		xil_printf("REG6 Reporting : Good\r\n");
	else
		xil_printf("REG6 Party Pooper\r\n");
	// Reg7
	BF_8X8_mWriteReg(core,reg7,dahi);
	lays = BF_8X8_mReadReg(core,reg7);
	if (lays == dahi)
		xil_printf("REG7 Reporting : Good\r\n");
	else
		xil_printf("REG7 Party Pooper\r\n");
	// Reg8
	BF_8X8_mWriteReg(core,reg8,dahi);
	lays = BF_8X8_mReadReg(core,reg8);
	if (lays == dahi)
		xil_printf("REG8 Reporting : Good\r\n");
	else
		xil_printf("REG8 Party Pooper\r\n");
	// Reg9
	BF_8X8_mWriteReg(core,reg9,dahi);
	lays = BF_8X8_mReadReg(core,reg9);
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
			BF_8X8_mWriteReg(core,reg1,inst);
			data = 6;						// 1st  3bits for direction, kept 6
			data = (data<<8) | bram[i][j]; 	// Next 8bits for pixel value
			if (i==0 && j==0)
				data = (data<<21);			 	// Last 21bits for initial infinite cost , first pixel cost =0
			else
				data = (data<<21) | 1048576; 	// Last 21bits for initial infinite cost 0x100000
			BF_8X8_mWriteReg(core,reg0,data);
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
			BF_8X8_mWriteReg(core,reg1,inst);
			data = 6;						// 1st  3bits for direction
			data = (data<<8) | bram[i][j]; 	// Next 8bits for pixel value
			if (i==0 && j==0)
				data = (data<<21);			 	// Last 21bits for initial infinite cost , first pixel cost =0
			else
				data = (data<<21) | 1048576; 	// Last 21bits for initial infinite cost 0x100000
			out  = BF_8X8_mReadReg(core,reg2);
			if (data == out)
				xil_printf("Correct Read\r\n");
			else
				xil_printf("Ghalat Read\r\n");
		}
		for(d=0;d<999999;d++);
	}
}

void print(char *str);

int main()
{
    init_platform();
    print("Testing Bellman Ford 8x8\n\r");
    Xuint32 inst,data,out;
	int i,j=0,k,d,iter_no,ra,wa;
	char done = 0,state;
	unsigned ch;
	while(5)	// Bellman Core Loop
	{
		reg_check();
		inst = 0;
		BF_8X8_mWriteReg(core,reg3,inst); // Reset = 0
		BRAM_WRITE_N_CHECK();
		while(1);
		inst = 1;
		BF_8X8_mWriteReg(core,reg3,inst); // Manually reset the core
		xil_printf("Sending Start Signal to BF Core\r\n");
		inst = 2;						// 2'b10 -- 1 start 0 write on port B
		inst = (inst<<30);
		BF_8X8_mWriteReg(core,reg3,0); 	// Disable reset signal to the core
		BF_8X8_mWriteReg(core,reg1,inst);
		/*xil_printf("Start Signal sent\r\nWaiting for Core to Stop...\r\n");
		done = 0;
		while(done == 0)
		{
			out     = BF_8X8_mReadReg(core,reg4);
			//data    = BF_8X8_mReadReg(core,reg5);
			done    = out;
			if (done == 1)
			{
				inst = 0;							// 2'b00 -- 0 start 0 write on port B

*/
			for(d=0;d<5600;d++);
			out     = BF_8X8_mReadReg(core,reg4);
			BF_8X8_mWriteReg(core,reg1,0);	// stop BF Core
			//}
			done    = out;
			iter_no = (out>>8);
			ra = data & 0x000003FF;
			wa = (data & 0x000FFB00)>>10;
			state = (data & 0x00300000)>>20;
			xil_printf("Iteration Number : %d\tDone : %d\r\n",iter_no,done);
			xil_printf("RA : %d\tWA : %d\tState : %d\r\n",ra,wa,state);
		//}
		*(leds) = 0xFF;
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
				BF_8X8_mWriteReg(core,reg1,inst);
				out = BF_8X8_mReadReg(core,reg2);
				result[i][j]   = (out>>29);
				prevdist[i][j] = out & 0x001FFFFF;
			}
			//for(d=0;d<9999999;d++);
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
		while(1);
	}
    cleanup_platform();
    return 0;
}
