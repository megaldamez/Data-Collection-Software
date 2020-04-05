#include "extcode.h"
#ifdef __cplusplus
extern "C" {
#endif

int32_t __cdecl ApintUsb(uint32_t ProductNumber, uint32_t ChannelNumber, 
	char Function[], double In1, double In2, double In3, double In4, double In5, 
	double In6, int16_t *Out1, int16_t *Out2, int16_t *Out3, int16_t *Out4, 
	int16_t *Out5, int16_t *Out6, uint16_t Array[], int32_t *len);

long __cdecl LVDLLStatus(char *errStr, int errStrLen, void *module);

#ifdef __cplusplus
} // extern "C"
#endif

