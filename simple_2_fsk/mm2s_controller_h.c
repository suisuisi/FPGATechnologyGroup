#ifndef SRC_MM2S_CONTROLLER_H_
#define SRC_MM2S_CONTROLLER_H_

#define DMA_DEV_ID		    XPAR_AXIDMA_0_DEVICE_ID
#define DMA_BASEADDR        XPAR_AXIDMA_0_BASEADDR
#define DDR_BASE_ADDR		XPAR_PS7_DDR_0_S_AXI_BASEADDR
#define MEM_BASE_ADDR		(DDR_BASE_ADDR + 0x1000000)
#define TX_BUFFER_BASE		(MEM_BASE_ADDR + 0x00100000)
#define RX_BUFFER_BASE		(MEM_BASE_ADDR + 0x00300000)
#define RX_BUFFER_HIGH		(MEM_BASE_ADDR + 0x004FFFFF)
#define V_BUFFER_BASE       (MEM_BASE_ADDR + 0x00500000)

// 0x400/1024 bytes=256 DMA cycles
// 0x80/128 bytes=32 DMA cycles
// 0x20/32 bytes=8 DMA cycles
// 0x08/8 bytes=2 DMA cycles
// 0x04/4 bytes=1 DMA cycles

#define MAX_PKT_LEN		    0x04
#define MIN_PKT_LEN		    0x01
#define NUM_TRANSFERS	    1

u32 XAxiDma_MM2Stransfer(XAxiDma *InstancePtr, UINTPTR BuffAddr, u32 Length);

#endif /* SRC_MM2S_CONTROLLER_H_ */

