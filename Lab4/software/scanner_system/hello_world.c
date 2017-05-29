/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */

#include "sys/alt_stdio.h"

#define switches (volatile char *) 0x9010
#define leds (char *) 0x9000


int main() {

	/* Prompting */
	alt_putstr("Hello from Nios II!\n");
	alt_putstr("\n Enter a 'g' to start switches > \n");

	/* Give input a dummy value */
	char in = 'x';

	/* Wait until we receive a g before proceeding */
	while (in != 'g') {
		in = alt_getchar();
	}

	/* Assign leds via switches, indefinitelys. */
	while (1) {
		*leds = *switches;
	}

  return 0;
}
