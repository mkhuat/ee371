#include <stdio.h>

void part1();
void part2();

// Learning the C Language
int main(int argc, char* argv[]) {
	part1();
	part2();
} 


// Part 1: Getting to Know Pointers
void part1() {
	printf("\nPart 1: Getting to Know Pointers\n");

	// Declaring two variables for each type: int, float, char
	int int_x = 1;
	int int_y = 2;

	float float_x = 0.1;
	float float_y = 0.2;
	
	char char_x = 'a';
	char char_y = 'b';

	// Declaring one pointer for each type: int, float, char
	int* int_ptr;
	float* float_ptr;
	char* char_ptr;

	// Assigning the address of the int vars to the pointer to int
	int_ptr = &int_x;
	printf("\tInteger value at address %p: %d\n", int_ptr, *int_ptr);

	int_ptr = &int_y;
	printf("\tInteger value at address %p: %d\n", int_ptr, *int_ptr);

	// Assigning the address of the float vars to the pointer to float
	float_ptr = &float_x;
	printf("\tFloat value at address %p: %f\n", float_ptr, *float_ptr);

	float_ptr = &float_y;
	printf("\tFloat value at address %p: %f\n", float_ptr, *float_ptr);

	// Assigning the address of the char vars to the pointer to char
	char_ptr = &char_x;
	printf("\tChar value at address %p: %c\n", char_ptr, *char_ptr);

	char_ptr = &char_y;
	printf("\tChar value at address %p: %c\n", char_ptr, *char_ptr);
}


// Part 2: Working with Pointer Variables
void part2() {
	printf("\nPart 2: Working with Pointer Variables\n");

	// Declaring given integer variables
	int A = 22;
	int B = 17;
	int C = 6;
	int D = 4;
	int E = 9;

	// Declaring the result
	int result;

	// Declaring pointers to each integer
	int* A_ptr = &A; 
	int* B_ptr = &B;
	int* C_ptr = &C;
	int* D_ptr = &D;
	int* E_ptr = &E;

	// Perform given computation using only pointers
	result = ((*A_ptr - *B_ptr) * (*C_ptr + *D_ptr)) / (*E_ptr);
	printf("\tComputing ((A – B)*(C+D))/E with pointers...\n");
	printf("\tValue of result: %d\n\n", result);
}