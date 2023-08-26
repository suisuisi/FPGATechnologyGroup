#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "xgpio.h"
#include "xaxidma.h"
#include "xstatus.h"
#include "xil_printf.h"
#include "xil_assert.h"
#include "xparameters.h"
#include "mm2s_controller.h"

u32 XAxiDma_MM2Stransfer(XAxiDma *InstancePtr, UINTPTR BuffAddr, u32 Length){

	u32 WordBits;

	// Check scatter gather is not enabled
	if (XAxiDma_HasSg(InstancePtr)){
		xil_printf("Scatter gather is not supported\r\n");
		return XST_FAILURE;
	}

	// Check that the AXI DMA controller has the MM2S port (read channel) enabled in the HW design
	if (!InstancePtr->HasMm2S) {
		xil_printf("MM2S channel is not enabled.\r\n");
		return XST_FAILURE;
	}

	// Check that the requested transfer length is at least 1, but not
	// greater than the max length the DMA's configuration can transfer
	if ((Length < 1) || (Length > InstancePtr->TxBdRing.MaxTransferLen)){
		xil_printf("Invalid MM2S transfer length: %d\r\n", Length);
		return XST_FAILURE;
	}

	// If the engine is doing transfer, cannot submit
	if (!(XAxiDma_ReadReg(InstancePtr->TxBdRing.ChanBase, XAXIDMA_SR_OFFSET) & XAXIDMA_HALTED_MASK)){
		if (XAxiDma_Busy(InstancePtr,XAXIDMA_DMA_TO_DEVICE)){
			xil_printf("MM2S engine is busy\r\n");
			return XST_FAILURE;
		}
	}

	if (!InstancePtr->MicroDmaMode){
		WordBits = (u32)((InstancePtr->TxBdRing.DataWidth) - 1);
	} else {
		WordBits = XAXIDMA_MICROMODE_MIN_BUF_ALIGN;
	}

	if ((BuffAddr & WordBits)){
		if (!InstancePtr->TxBdRing.HasDRE){
			xil_printf("Unaligned transfer without DRE %x\r\n",(unsigned int)BuffAddr);
			return XST_FAILURE;
		}
	}

	// set the run bit
	XAxiDma_WriteReg(InstancePtr->TxBdRing.ChanBase,
			         XAXIDMA_CR_OFFSET,
					 XAxiDma_ReadReg(InstancePtr->TxBdRing.ChanBase,XAXIDMA_CR_OFFSET)| XAXIDMA_CR_RUNSTOP_MASK);

	XAxiDma_WriteReg(InstancePtr->TxBdRing.ChanBase, XAXIDMA_SRCADDR_OFFSET, LOWER_32_BITS(BuffAddr));

	if (InstancePtr->AddrWidth > 32){
		XAxiDma_WriteReg(InstancePtr->TxBdRing.ChanBase, XAXIDMA_SRCADDR_MSB_OFFSET, UPPER_32_BITS(BuffAddr));
	}

	// Writing length in bytes to the buffer transfer length register starts the transfer
	XAxiDma_WriteReg(InstancePtr->TxBdRing.ChanBase, XAXIDMA_BUFFLEN_OFFSET, Length);

	return XST_SUCCESS;
}

