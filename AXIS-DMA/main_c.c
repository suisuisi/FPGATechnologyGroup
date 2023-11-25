#include <stdio.h>
#include "xaxidma.h"
#include "platform.h"
#include "xil_printf.h"
#include "xparameters.h"
#include "dma_controller.h"

XAxiDma AxiDma; //DMA device instance definition

int main(){
    init_platform();

    print("Hello World\n\r");

    XAxiDma_Config *CfgPtr; //DMA configuration pointer

	int Status, Index;
	u8 *TxBufferPtr;
	u8 *RxBufferPtr;
	u8 Value;

	TxBufferPtr = (u8 *)TX_BUFFER_BASE;
	RxBufferPtr = (u8 *)RX_BUFFER_BASE;

	// Initialize memory to all zeros
	for(Index = 0; Index < MAX_PKT_LEN; Index ++){
		TxBufferPtr[Index] = 0x00;
		RxBufferPtr[Index] = 0x00;
	}

	// Initialize the XAxiDma device
	CfgPtr = XAxiDma_LookupConfig(DMA_DEV_ID);
	if (!CfgPtr) {
		xil_printf("No config found for %d\r\n", DMA_DEV_ID);
		return XST_FAILURE;
	}

	Status = XAxiDma_CfgInitialize(&AxiDma, CfgPtr);
	if (Status != XST_SUCCESS) {
		xil_printf("Initialization failed %d\r\n", Status);
		return XST_FAILURE;
	}

	if(XAxiDma_HasSg(&AxiDma)){
		xil_printf("Device configured as SG mode \r\n");
		return XST_FAILURE;
	}

	XAxiDma_IntrDisable(&AxiDma, XAXIDMA_IRQ_ALL_MASK, XAXIDMA_DEVICE_TO_DMA);
	XAxiDma_IntrDisable(&AxiDma, XAXIDMA_IRQ_ALL_MASK, XAXIDMA_DMA_TO_DEVICE);

	Value = 0x00;

	for(Index = 0; Index < MAX_PKT_LEN; Index ++){
		TxBufferPtr[Index] = Value;

		Value = (Value + 1) & 0xFF;
	}

	Xil_DCacheFlushRange((UINTPTR)TxBufferPtr, MAX_PKT_LEN);
	Xil_DCacheFlushRange((UINTPTR)RxBufferPtr, MAX_PKT_LEN);

	XAxiDma_Reset(&AxiDma);

	// Setup & kick off S2MM channel first	
	Status = XAxiDma_S2MMtransfer(&AxiDma,(UINTPTR) RxBufferPtr, MAX_PKT_LEN);

	if (Status != XST_SUCCESS){
		xil_printf("XAXIDMA_DEVICE_TO_DMA transfer failed...\r\n");
		return XST_FAILURE;
	}

	Status = XAxiDma_MM2Stransfer(&AxiDma,(UINTPTR) TxBufferPtr, MAX_PKT_LEN);

	if (Status != XST_SUCCESS){
		xil_printf("XAXIDMA_DMA_TO_DEVICE transfer failed...\r\n");
		return XST_FAILURE;
	}

	while(XAxiDma_Busy(&AxiDma,XAXIDMA_DEVICE_TO_DMA) || XAxiDma_Busy(&AxiDma,XAXIDMA_DMA_TO_DEVICE)){
		if (XAxiDma_Busy(&AxiDma,XAXIDMA_DEVICE_TO_DMA) == TRUE){
			xil_printf("S2MM channel is busy...\r\n");
		}

		if (XAxiDma_Busy(&AxiDma,XAXIDMA_DMA_TO_DEVICE)){
			xil_printf("MM2S channel is busy...\r\n");
		}
	}

	for(Index = 0; Index < MAX_PKT_LEN; Index++) {
		xil_printf("Received data packet %d: %x/%x\r\n", Index, (unsigned int)RxBufferPtr[Index], (unsigned int)TxBufferPtr[Index]);
	}

	XAxiDma_Reset(&AxiDma);

    cleanup_platform();
    return 0;
}
