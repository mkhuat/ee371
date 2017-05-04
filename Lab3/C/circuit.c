#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <string.h>

/*
The delay of a signal propagating along a printed circuit board trace is 180 picoseconds
(10-12 seconds) per inch. The delay through a logic device is approximately 5
nanoseconds (10-9 seconds). Assume that the logic devices are placed on the circuit
board with a printed circuit board trace of 0.1 inches connecting the output of one device
to the input of the next.

Write a program that prompts the user for the number of logic devices in a signal path
and displays the total delay along the path. Think about an informative way to print the
answer.
*/

// Maximum buffer size for user input
#define BUF_MAX 100

void prompt();

int main(int argc, char* argv[]) {

    printf("Circuit Board Propogation Delay Calculator\n");
    printf("\nContext:\n");
    printf("\t- Propogation delay rate: 180 ps/in of trace\n");
    printf("\t- Delay through a logic device: 5 ns\n");
    printf("\t- Length of trace between logic devices: 0.1 in\n\n");

	prompt();

	char* end, buf[BUF_MAX];
	long n;

	// Continue prompting until valid input is entered
	while (fgets(buf, sizeof(buf), stdin)) {

		// Convert input to a long int
		n = strtol(buf, &end, 10);

		// Validate input
		if (*end == '\n' && end == buf) {
			prompt();
		} else if (n > INT_MAX) {
		
			printf("\tNumber entered too large. Please enter an integer less than 2,147,483,647.\n\n");
			prompt();
		} else if (n < 0) {
		
			printf("\tNegative number entered. Please enter a postive number.\n\n");
			prompt();
		} else {
			break;
		}

	}
	
	// Calculate propagation delay
	long delay = (n == 0 ? 0 : 18 * (n - 1) + 5000 * n);

	// Print results
	printf("\n-----------------------------------\n");
	printf("Number of logic devices: %ld\n", n);
	printf("Total delay: %ld ps = %f ns\n\n", delay, delay / 1000.0);

} 

void prompt() {
	printf("Enter number logic devices in path: ");
}