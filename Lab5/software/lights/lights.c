#define switches (volatile char *) 0x9010
#define leds (char *) 0x9000
void main()
{
	while (1)
		*leds = *switches;
}
