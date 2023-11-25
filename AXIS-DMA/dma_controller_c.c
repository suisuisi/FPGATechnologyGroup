#include "xaxidma.h"
#include "xil_printf.h"
#include "dma_controller.h"

int RingIndex;

u32 XAxiDma_MM2Stransfer(XAxiDma *InstancePtr, UINTPTR BuffAddr, u32 Length){

	u32 WordBits;

	// Check scatter gather is not enabled
	if (XAxiDma_HasSg(InstancePtr)){
		xil_printf("Scatter gather is not supported\r\n");

		return XST_FAILURE;
	}

	if ((Length < 1) || (Length > InstancePtr->TxBdRing.MaxTransferLen)){
		xil_printf("Invalid transfer length.\r\n");
		return XST_FAILURE;
	}

	if (!InstancePtr->HasMm2S) {
		xil_printf("MM2S channel is not supported.\r\n");

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

	XAxiDma_WriteReg(InstancePtr->TxBdRing.ChanBase, XAXIDMA_SRCADDR_OFFSET, LOWER_32_BITS(BuffAddr));

	if (InstancePtr->AddrWidth > 32){
		XAxiDma_WriteReg(InstancePtr->TxBdRing.ChanBase, XAXIDMA_SRCADDR_MSB_OFFSET, UPPER_32_BITS(BuffAddr));
	}

	XAxiDma_WriteReg(InstancePtr->TxBdRing.ChanBase, XAXIDMA_CR_OFFSET, XAxiDma_ReadReg(InstancePtr->TxBdRing.ChanBase,XAXIDMA_CR_OFFSET)| XAXIDMA_CR_RUNSTOP_MASK);

	// Writing length in bytes to the buffer transfer length register starts the transfer
	XAxiDma_WriteReg(InstancePtr->TxBdRing.ChanBase, XAXIDMA_BUFFLEN_OFFSET, Length);

	return XST_SUCCESS;
}

u32 XAxiDma_MM2StransferCnfg(XAxiDma *InstancePtr, UINTPTR BuffAddr){

	u32 WordBits;

	// Check scatter gather is not enabled
	if (XAxiDma_HasSg(InstancePtr)){
		xil_printf("Scatter gather is not supported\r\n");

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

	XAxiDma_WriteReg(InstancePtr->TxBdRing.ChanBase, XAXIDMA_SRCADDR_OFFSET, LOWER_32_BITS(BuffAddr));

	if (InstancePtr->AddrWidth > 32){
		XAxiDma_WriteReg(InstancePtr->TxBdRing.ChanBase, XAXIDMA_SRCADDR_MSB_OFFSET, UPPER_32_BITS(BuffAddr));
	}

	XAxiDma_WriteReg(InstancePtr->TxBdRing.ChanBase, XAXIDMA_CR_OFFSET, XAxiDma_ReadReg(InstancePtr->TxBdRing.ChanBase,XAXIDMA_CR_OFFSET)| XAXIDMA_CR_RUNSTOP_MASK);

	return XST_SUCCESS;
}

void XAxiDma_MM2StransferRun(XAxiDma *InstancePtr, u32 Length){

	// Writing length in bytes to the buffer transfer length register starts the transfer
	XAxiDma_WriteReg(InstancePtr->TxBdRing.ChanBase, XAXIDMA_BUFFLEN_OFFSET, Length);

	while(XAxiDma_Busy(InstancePtr,XAXIDMA_DMA_TO_DEVICE)){
		// wait
	}

}

u32 XAxiDma_S2MMtransfer(XAxiDma *InstancePtr, UINTPTR BuffAddr, u32 Length){

	u32 WordBits;
	RingIndex = 0;

	// Check scatter gather is not enabled
	if (XAxiDma_HasSg(InstancePtr)){
		xil_printf("Scatter gather is not supported\r\n");

		return XST_FAILURE;
	}

	if ((Length < 1) || (Length > InstancePtr->RxBdRing[RingIndex].MaxTransferLen)){
		xil_printf("Invalid transfer length.\r\n");
		return XST_FAILURE;
	}

	if (!InstancePtr->HasS2Mm){
		xil_printf("S2MM channel is not supported\r\n");

		return XST_FAILURE;
	}

	// If the engine is doing transfer, cannot submit
	if (!(XAxiDma_ReadReg(InstancePtr->RxBdRing[RingIndex].ChanBase, XAXIDMA_SR_OFFSET) & XAXIDMA_HALTED_MASK)){
		if (XAxiDma_Busy(InstancePtr,XAXIDMA_DEVICE_TO_DMA)){
			xil_printf("S2MM engine is busy\r\n");
			return XST_FAILURE;
		}
	}

	if (!InstancePtr->MicroDmaMode){
		WordBits = (u32)((InstancePtr->RxBdRing[RingIndex].DataWidth) - 1);
	} else {
		WordBits = XAXIDMA_MICROMODE_MIN_BUF_ALIGN;
	}

	if ((BuffAddr & WordBits)){
		if (!InstancePtr->RxBdRing[RingIndex].HasDRE){
			xil_printf("Unaligned transfer without DRE %x\r\n", (unsigned int)BuffAddr);
			return XST_FAILURE;
		}
	}

	XAxiDma_WriteReg(InstancePtr->RxBdRing[RingIndex].ChanBase, XAXIDMA_DESTADDR_OFFSET, LOWER_32_BITS(BuffAddr));

	if (InstancePtr->AddrWidth > 32){
		XAxiDma_WriteReg(InstancePtr->RxBdRing[RingIndex].ChanBase, XAXIDMA_DESTADDR_MSB_OFFSET, UPPER_32_BITS(BuffAddr));
	}

	XAxiDma_WriteReg(InstancePtr->RxBdRing[RingIndex].ChanBase, XAXIDMA_CR_OFFSET, XAxiDma_ReadReg(InstancePtr->RxBdRing[RingIndex].ChanBase, XAXIDMA_CR_OFFSET)| XAXIDMA_CR_RUNSTOP_MASK);

	// Writing length in bytes to the buffer transfer length register starts the transfer
	XAxiDma_WriteReg(InstancePtr->RxBdRing[RingIndex].ChanBase, XAXIDMA_BUFFLEN_OFFSET, Length);

	return XST_SUCCESS;
}

u32 XAxiDma_S2MMtransferCnfg(XAxiDma *InstancePtr, UINTPTR BuffAddr){

	u32 WordBits;
	RingIndex = 0;

	// Check scatter gather is not enabled
	if (XAxiDma_HasSg(InstancePtr)){
		xil_printf("Scatter gather is not supported\r\n");

		return XST_FAILURE;
	}

	// If the engine is doing transfer, cannot submit
	if (!(XAxiDma_ReadReg(InstancePtr->RxBdRing[RingIndex].ChanBase, XAXIDMA_SR_OFFSET) & XAXIDMA_HALTED_MASK)){
		if (XAxiDma_Busy(InstancePtr,XAXIDMA_DEVICE_TO_DMA)){
			xil_printf("S2MM engine is busy\r\n");
			return XST_FAILURE;
		}
	}

	if (!InstancePtr->MicroDmaMode){
		WordBits = (u32)((InstancePtr->RxBdRing[RingIndex].DataWidth) - 1);
	} else {
		WordBits = XAXIDMA_MICROMODE_MIN_BUF_ALIGN;
	}

	if ((BuffAddr & WordBits)){
		if (!InstancePtr->RxBdRing[RingIndex].HasDRE){
			xil_printf("Unaligned transfer without DRE %x\r\n", (unsigned int)BuffAddr);
			return XST_FAILURE;
		}
	}

	XAxiDma_WriteReg(InstancePtr->RxBdRing[RingIndex].ChanBase, XAXIDMA_DESTADDR_OFFSET, LOWER_32_BITS(BuffAddr));

	if (InstancePtr->AddrWidth > 32){
		XAxiDma_WriteReg(InstancePtr->RxBdRing[RingIndex].ChanBase, XAXIDMA_DESTADDR_MSB_OFFSET, UPPER_32_BITS(BuffAddr));
	}

	XAxiDma_WriteReg(InstancePtr->RxBdRing[RingIndex].ChanBase, XAXIDMA_CR_OFFSET, XAxiDma_ReadReg(InstancePtr->RxBdRing[RingIndex].ChanBase, XAXIDMA_CR_OFFSET)| XAXIDMA_CR_RUNSTOP_MASK);

	return XST_SUCCESS;
}

void XAxiDma_S2MMtransferRun(XAxiDma *InstancePtr, u32 Length){

	// Writing length in bytes to the buffer transfer length register starts the transfer
	XAxiDma_WriteReg(InstancePtr->RxBdRing[RingIndex].ChanBase, XAXIDMA_BUFFLEN_OFFSET, Length);

	while(XAxiDma_Busy(InstancePtr,XAXIDMA_DEVICE_TO_DMA)){
		// wait
	}
}
