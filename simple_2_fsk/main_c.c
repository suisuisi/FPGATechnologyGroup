#include <math.h>
#include <stdio.h>
#include "sleep.h"
#include "xtime_l.h"
#include "xaxidma.h"
#include "platform.h"
#include "xil_printf.h"
#include "xparameters.h"
#include "mm2s_controller.h"

XAxiDma AxiDma;


int main()
{
    init_platform();

    XAxiDma_Config *CfgPtr; //DMA configuration pointer
	int Status, Index;
	u8 *TxBufferPtr;

	print("Hello World!\n\r");

	TxBufferPtr = (u8 *)TX_BUFFER_BASE;

	// Initialize memory to all zeros
	for(Index = 0; Index < MAX_PKT_LEN; Index ++){
		TxBufferPtr[Index] = 0x00;
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

	XAxiDma_IntrDisable(&AxiDma, XAXIDMA_IRQ_ALL_MASK, XAXIDMA_DMA_TO_DEVICE);

	TxBufferPtr[0] = 0xef;
	TxBufferPtr[1] = 0xbe;
	TxBufferPtr[2] = 0xad;
	TxBufferPtr[3] = 0xde;

	Xil_DCacheFlushRange((UINTPTR)TxBufferPtr, MAX_PKT_LEN);
	XAxiDma_Reset(&AxiDma);

	Status = XAxiDma_MM2Stransfer(&AxiDma,(UINTPTR) TxBufferPtr, MAX_PKT_LEN);
	if (Status != XST_SUCCESS){
		xil_printf("XAXIDMA_DMA_TO_DEVICE transfer failed...\r\n");
		return XST_FAILURE;
	}


    cleanup_platform();
    return 0;
}

