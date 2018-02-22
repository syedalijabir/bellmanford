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
#include "xio.h"
#include "xgpio.h"
#include "xuartlite.h"
#include "xuartlite_l.h"
#include "xparameters.h"
#include "xstatus.h"
#include "XtmrCtr_l.h"
#include "XtmrCtr.h"

Xuint32 ddr   = 0xBF000000;
Xuint32 deci  = 0xBF400000;
Xuint32 lpf   = 0xBF410000;
Xuint32 uart  = XPAR_RS232_UART_1_BASEADDR;
Xuint32 *leds = XPAR_LEDS_8BITS_BASEADDR;
Xuint32 timer = XPAR_TMRCTR_0_BASEADDR;
const int r  = 64,c  = 64, total  = 4096;
const int dr = 8, dc = 8,  dtotal = 64;

XUartLite uart_dce;
XTmrCtr mytimer;
u64 ts,tf,tc1=0,tc2;
u8 rx,tx;
u8 result[8][8];
u32 dist[8][8];
u8 pred[8][8];
u8 img[8][8];
u8 wa[8][1];
u8 wb[8][1];
u32 da[8][1];
u32 db[8][1];
u8 pa[8][1];
u8 pb[8][1];
u32 res[8][4];

// Matlab function column pair
void columnpair(int n)
{
	int i,k;
	u32 t1,t2;
	// function res = columnpair(wa,wb, da,db,pa,pb)
	for (i=0;i<dr;i++)
	{
		wa[i][0] = img[i][n];
	}
	for (i=0;i<dr;i++)
	{
		wb[i][0] = img[i][n+1];
	}
	for (i=0;i<dr;i++)
	{
		da[i][0] = dist[i][n];
	}
	for (i=0;i<dr;i++)
	{
		db[i][0] = dist[i][n+1];
	}
	for (i=0;i<dr;i++)
	{
		pa[i][0] = pred[i][n];
	}
	for (i=0;i<dr;i++)
	{
		pb[i][0] = pred[i][n+1];
	}

	for (k=0;k<dr-1;k=k+2)
	{
		//---------------------------------------
		// for vertical edges
		t1 = da[k][0];
		if(   da[k][0]> da[k+1][0]+wa[k][0])
		{
			pa[k][0] = 6; // down
			da[k][0]   = da[k+1][0]+wa[k][0];
		}
		if( da[k+1][0]> t1 +  wa[k+1][0])
		{
			pa[k+1][0] = 2; // up
			da[k+1][0] = t1 +  wa[k+1][0];
		}
		//----------
        t2 = db[k][0];
        if(   db[k][0]> db[k+1][0]+wb[k][0])
        {
        	pb[k][0] =6; // down
            db[k][0]   =  db[k+1][0]+wb[k][0];
        }
        if( db[k+1][0]> t2 +  wb[k+1][0])
        {
        	pb[k+1][0]=2; // up
            db[k+1][0] = t2 +  wb[k+1][0];
        }
        // for horizontal edges                             a(1) b(1)
	//                                                  a(2) b(2)
	//-----------------------------------------------------------
		t1= da[k][0];
		if(da[k][0]  >  db[k][0]+wa[k][0])
		{
			pa[k][0] = 0; // right
			da[k][0] = db[k][0]+wa[k][0];
		}
		if(db[k][0]  >  t1   +wb[k][0])
		{
			pb[k][0] = 4; // left
			db[k][0] = t1   +wb[k][0];
		}
		//-------
		t2= da[k+1][0];
		if( da[k+1][0]>  db[k+1][0]+wa[k+1][0] )
		{
			pa[k+1][0]= 0; // right
			da[k+1][0] = db[k+1][0]+wa[k+1][0] ;
		}
		if( db[k+1][0]>  t2     +wb[k+1][0] )
		{
			pb[k+1][0]= 4; // left
			db[k+1][0] = t2     +wb[k+1][0];
		}

		//-------------------------------------------------------------
		// for diagonal edges

		t1 = da[k][0];
		if(da[k][0]>  wa[k][0] + db[k+1][0] )
		{
			pa[k][0] = 7; // right down
			da[k][0]   = wa[k][0] + db[k+1][0];
		}
		if(db[k+1][0]>wb[k+1][0]+ t1)
		{
			pb[k+1][0] = 3; // left up
			db[k+1][0] = wb[k+1][0]+ t1;
		}
        //----------
        t2 = db[k][0];
        if(db[k][0]>  wb[k][0] + da[k+1][0] )
        {
        	pb[k][0] = 5 ; // left down
            db[k][0]   = wb[k][0] + da[k+1][0];
        }
        if(da[k+1][0]> wa[k+1][0] + t2 )
        {
        	pa[k+1][0] = 1 ; // right up
            da[k+1][0] = wa[k+1][0] + t2 ;
        }
	}

	for (k=1;k<dr-1;k=k+2)
	{
		//---------------------------------------
		// for vertical edges
		t1 = da[k][0];
		if(   da[k][0]> da[k+1][0]+wa[k][0])
		{
			pa[k][0] = 6; // down
			da[k][0]   = da[k+1][0]+wa[k][0];
		}
		if( da[k+1][0]> t1 +  wa[k+1][0])
		{
			pa[k+1][0] = 2; // up
			da[k+1][0] = t1 +  wa[k+1][0];
		}
		//----------
        t2 = db[k][0];
        if(   db[k][0]> db[k+1][0]+wb[k][0])
        {
        	pb[k][0] =6; // down
            db[k][0]   =  db[k+1][0]+wb[k][0];
        }
        if( db[k+1][0]> t2 +  wb[k+1][0])
        {
        	pb[k+1][0]=2; // up
            db[k+1][0] = t2 +  wb[k+1][0];
        }
        // for horizontal edges                             a(1) b(1)
	//                                                  a(2) b(2)
	//-----------------------------------------------------------
		t1= da[k][0];
		if(da[k][0]  >  db[k][0]+wa[k][0])
		{
			pa[k][0] = 0; // right
			da[k][0] = db[k][0]+wa[k][0];
		}
		if(db[k][0]  >  t1   +wb[k][0])
		{
			pb[k][0] = 4; // left
			db[k][0] = t1   +wb[k][0];
		}
		//-------
		t2= da[k+1][0];
		if( da[k+1][0]>  db[k+1][0]+wa[k+1][0] )
		{
			pa[k+1][0]= 0; // right
			da[k+1][0] = db[k+1][0]+wa[k+1][0] ;
		}
		if( db[k+1][0]>  t2     +wb[k+1][0] )
		{
			pb[k+1][0]= 4; // left
			db[k+1][0] = t2     +wb[k+1][0];
		}

		//-------------------------------------------------------------
		// for diagonal edges

		t1 = da[k][0];
		if(da[k][0]>  wa[k][0] + db[k+1][0] )
		{
			pa[k][0] = 7; // right down
			da[k][0]   = wa[k][0] + db[k+1][0];
		}
		if(db[k+1][0]>wb[k+1][0]+ t1)
		{
			pb[k+1][0] = 3; // left up
			db[k+1][0] = wb[k+1][0]+ t1;
		}
        //----------
        t2 = db[k][0];
        if(db[k][0]>  wb[k][0] + da[k+1][0] )
        {
        	pb[k][0] = 5 ; // left down
            db[k][0]   = wb[k][0] + da[k+1][0];
        }
        if(da[k+1][0]> wa[k+1][0] + t2 )
        {
        	pa[k+1][0] = 1 ; // right up
            da[k+1][0] = wa[k+1][0] + t2 ;
        }
	}

	for (i=0;i<dr;i++)
	{
		res[i][0] = da[i][0];
		res[i][1] = db[i][0];
		res[i][2] = pa[i][0];
		res[i][3] = pb[i][0];
	}

}
void print(char *str);

void serial_pyramid(void)
{
	int i,j,k,l,sum;
	u8 mask[3][3];
    	// Receive Image
   	for(j=0,i=0;i<dr;)
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

    // Start Timer
    XTmrCtr_Start(&mytimer, 0);
    // Start Counting
    ts = XTmrCtr_GetValue(&mytimer, 0);
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

	tf = XTmrCtr_GetValue(&mytimer, 0);
	XTmrCtr_Stop(&mytimer, 0);
	tc1 = tc1 + (tf-ts);

	// Filling Temporary 2D Image
	k=0;
	l=0;
	for (i=0,j=0;i<dtotal;)
	{
		img[k][l] = XIo_In8(lpf+i+j);
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

void Uart_Init(void)
{
	XUartLite_Initialize(&uart_dce, XPAR_RS232_UART_1_DEVICE_ID);
}

int main()
{
    init_platform();

    print("Software Bellman Ford Shortest Path\r\n");
    int i,j,l;
    Uart_Init();
    XTmrCtr_Initialize(&mytimer, XPAR_TMRCTR_0_DEVICE_ID);

    serial_pyramid();
    XTmrCtr_Start(&mytimer, 0);
    ts = XTmrCtr_GetValue(&mytimer, 0);

    for (i=0; i<dr; i++)
    {
    	for (j=0;j<dc;j++)
    	{
    		dist[i][j] = 1048576;
    	}
    }
    for (i=0; i<dr; i++)
	{
		for (j=0;j<dc;j++)
		{
			pred[i][j] = 6;
		}
	}
    // initialize
    dist[0][0] = 0;

	tf = XTmrCtr_GetValue(&mytimer, 0);
	XTmrCtr_Stop(&mytimer, 0);
	tc1 = tc1 + (tf-ts);
    for (i=0; i<1500;i++)
    {
        XTmrCtr_Start(&mytimer, 0);
    	ts = XTmrCtr_GetValue(&mytimer, 0);
    	for (j=0;j<dc-1;j++)
    	{
    		columnpair(j);
    		for(l=0;l<dr;l++)
    		{
    			dist[l][j]   = res[l][0];
    			dist[l][j+1] = res[l][1];
    			pred[l][j]   = res[l][2];
    			pred[l][j+1] = res[l][3];
    		}
		}
    	tf = XTmrCtr_GetValue(&mytimer, 0);
    	XTmrCtr_Stop(&mytimer, 0);
    	tc1 = tc1 + (tf-ts);
    }
// Calculate Execution Time
//      tf   = XTmrCtr_GetValue(&mytimer, 0);
//	tc = tf - ts;
//	xil_printf("Start = %d\r\nEnd = %d\r\nExecution Cycles = %d\r\n",ts,tf,tc);
	xil_printf("RESULT:\r\n");
	for(i=0;i<dr;i++)
	{
		for(j=0;j<dc;j++)
		{
			xil_printf("%d\t",pred[i][j]);
		}
		xil_printf("\r\n");
	}
	xil_printf("Prevdist:\r\n");
	for(i=0;i<dr;i++)
	{
		for(j=0;j<dc;j++)
		{
			xil_printf("%d\t",dist[i][j]);
		}
		xil_printf("\r\n");
	}
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
