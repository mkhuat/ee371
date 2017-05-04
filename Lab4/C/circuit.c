#include <stdio.h>
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

int main(int argc, char* argv[]) {
	part1();
	part2();
} 