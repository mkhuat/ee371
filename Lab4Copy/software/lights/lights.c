#define sent_char (volatile char *) 0x9020
#define transmit_enable (volatile char *) 0x9010
#define received_char (volatile char *) 0x9030
#define load (volatile char *) 0x9000
#define parallel_out (volatile char *) 0x9040
#define parallel_in (volatile char *) 0x9050
#define leds (char *) 0x9060
#define switches (volatile char *) 0x9070


void main()
{
	while (1)
		*leds = *switches;
}
