/*****************************************************************************
* Filename:          E:\postgrad\SEECS\Thesis\ShortestPath\Virtex6\Tasks\serial_bf16x16\Design/drivers/bf_16x16_v1_00_a/src/bf_16x16.h
* Version:           1.00.a
* Description:       bf_16x16 Driver Header File
* Date:              Sun Jun 23 20:20:19 2013 (by Create and Import Peripheral Wizard)
*****************************************************************************/

#ifndef BF_16X16_H
#define BF_16X16_H

/***************************** Include Files *******************************/

#include "xbasic_types.h"
#include "xstatus.h"
#include "xil_io.h"

/************************** Constant Definitions ***************************/


/**
 * User Logic Slave Space Offsets
 * -- SLV_REG0 : user logic slave module register 0
 * -- SLV_REG1 : user logic slave module register 1
 * -- SLV_REG2 : user logic slave module register 2
 * -- SLV_REG3 : user logic slave module register 3
 * -- SLV_REG4 : user logic slave module register 4
 * -- SLV_REG5 : user logic slave module register 5
 * -- SLV_REG6 : user logic slave module register 6
 * -- SLV_REG7 : user logic slave module register 7
 * -- SLV_REG8 : user logic slave module register 8
 * -- SLV_REG9 : user logic slave module register 9
 */
#define BF_16X16_USER_NUM_REG 10
#define BF_16X16_USER_SLV_SPACE_OFFSET (0x00000000)
#define BF_16X16_SLV_REG0_OFFSET (BF_16X16_USER_SLV_SPACE_OFFSET + 0x00000000)
#define BF_16X16_SLV_REG1_OFFSET (BF_16X16_USER_SLV_SPACE_OFFSET + 0x00000004)
#define BF_16X16_SLV_REG2_OFFSET (BF_16X16_USER_SLV_SPACE_OFFSET + 0x00000008)
#define BF_16X16_SLV_REG3_OFFSET (BF_16X16_USER_SLV_SPACE_OFFSET + 0x0000000C)
#define BF_16X16_SLV_REG4_OFFSET (BF_16X16_USER_SLV_SPACE_OFFSET + 0x00000010)
#define BF_16X16_SLV_REG5_OFFSET (BF_16X16_USER_SLV_SPACE_OFFSET + 0x00000014)
#define BF_16X16_SLV_REG6_OFFSET (BF_16X16_USER_SLV_SPACE_OFFSET + 0x00000018)
#define BF_16X16_SLV_REG7_OFFSET (BF_16X16_USER_SLV_SPACE_OFFSET + 0x0000001C)
#define BF_16X16_SLV_REG8_OFFSET (BF_16X16_USER_SLV_SPACE_OFFSET + 0x00000020)
#define BF_16X16_SLV_REG9_OFFSET (BF_16X16_USER_SLV_SPACE_OFFSET + 0x00000024)

/**************************** Type Definitions *****************************/


/***************** Macros (Inline Functions) Definitions *******************/

/**
 *
 * Write a value to a BF_16X16 register. A 32 bit write is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is written.
 *
 * @param   BaseAddress is the base address of the BF_16X16 device.
 * @param   RegOffset is the register offset from the base to write to.
 * @param   Data is the data written to the register.
 *
 * @return  None.
 *
 * @note
 * C-style signature:
 * 	void BF_16X16_mWriteReg(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Data)
 *
 */
#define BF_16X16_mWriteReg(BaseAddress, RegOffset, Data) \
 	Xil_Out32((BaseAddress) + (RegOffset), (Xuint32)(Data))

/**
 *
 * Read a value from a BF_16X16 register. A 32 bit read is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is read from the register. The most significant data
 * will be read as 0.
 *
 * @param   BaseAddress is the base address of the BF_16X16 device.
 * @param   RegOffset is the register offset from the base to write to.
 *
 * @return  Data is the data from the register.
 *
 * @note
 * C-style signature:
 * 	Xuint32 BF_16X16_mReadReg(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define BF_16X16_mReadReg(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (RegOffset))


/**
 *
 * Write/Read 32 bit value to/from BF_16X16 user logic slave registers.
 *
 * @param   BaseAddress is the base address of the BF_16X16 device.
 * @param   RegOffset is the offset from the slave register to write to or read from.
 * @param   Value is the data written to the register.
 *
 * @return  Data is the data from the user logic slave register.
 *
 * @note
 * C-style signature:
 * 	void BF_16X16_mWriteSlaveRegn(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Value)
 * 	Xuint32 BF_16X16_mReadSlaveRegn(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define BF_16X16_mWriteSlaveReg0(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (BF_16X16_SLV_REG0_OFFSET) + (RegOffset), (Xuint32)(Value))
#define BF_16X16_mWriteSlaveReg1(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (BF_16X16_SLV_REG1_OFFSET) + (RegOffset), (Xuint32)(Value))
#define BF_16X16_mWriteSlaveReg2(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (BF_16X16_SLV_REG2_OFFSET) + (RegOffset), (Xuint32)(Value))
#define BF_16X16_mWriteSlaveReg3(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (BF_16X16_SLV_REG3_OFFSET) + (RegOffset), (Xuint32)(Value))
#define BF_16X16_mWriteSlaveReg4(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (BF_16X16_SLV_REG4_OFFSET) + (RegOffset), (Xuint32)(Value))
#define BF_16X16_mWriteSlaveReg5(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (BF_16X16_SLV_REG5_OFFSET) + (RegOffset), (Xuint32)(Value))
#define BF_16X16_mWriteSlaveReg6(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (BF_16X16_SLV_REG6_OFFSET) + (RegOffset), (Xuint32)(Value))
#define BF_16X16_mWriteSlaveReg7(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (BF_16X16_SLV_REG7_OFFSET) + (RegOffset), (Xuint32)(Value))
#define BF_16X16_mWriteSlaveReg8(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (BF_16X16_SLV_REG8_OFFSET) + (RegOffset), (Xuint32)(Value))
#define BF_16X16_mWriteSlaveReg9(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (BF_16X16_SLV_REG9_OFFSET) + (RegOffset), (Xuint32)(Value))

#define BF_16X16_mReadSlaveReg0(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (BF_16X16_SLV_REG0_OFFSET) + (RegOffset))
#define BF_16X16_mReadSlaveReg1(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (BF_16X16_SLV_REG1_OFFSET) + (RegOffset))
#define BF_16X16_mReadSlaveReg2(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (BF_16X16_SLV_REG2_OFFSET) + (RegOffset))
#define BF_16X16_mReadSlaveReg3(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (BF_16X16_SLV_REG3_OFFSET) + (RegOffset))
#define BF_16X16_mReadSlaveReg4(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (BF_16X16_SLV_REG4_OFFSET) + (RegOffset))
#define BF_16X16_mReadSlaveReg5(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (BF_16X16_SLV_REG5_OFFSET) + (RegOffset))
#define BF_16X16_mReadSlaveReg6(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (BF_16X16_SLV_REG6_OFFSET) + (RegOffset))
#define BF_16X16_mReadSlaveReg7(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (BF_16X16_SLV_REG7_OFFSET) + (RegOffset))
#define BF_16X16_mReadSlaveReg8(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (BF_16X16_SLV_REG8_OFFSET) + (RegOffset))
#define BF_16X16_mReadSlaveReg9(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (BF_16X16_SLV_REG9_OFFSET) + (RegOffset))

/************************** Function Prototypes ****************************/


/**
 *
 * Run a self-test on the driver/device. Note this may be a destructive test if
 * resets of the device are performed.
 *
 * If the hardware system is not built correctly, this function may never
 * return to the caller.
 *
 * @param   baseaddr_p is the base address of the BF_16X16 instance to be worked on.
 *
 * @return
 *
 *    - XST_SUCCESS   if all self-test code passed
 *    - XST_FAILURE   if any self-test code failed
 *
 * @note    Caching must be turned off for this function to work.
 * @note    Self test may fail if data memory and device are not on the same bus.
 *
 */
XStatus BF_16X16_SelfTest(void * baseaddr_p);
/**
*  Defines the number of registers available for read and write*/
#define TEST_AXI_LITE_USER_NUM_REG 10


#endif /** BF_16X16_H */
