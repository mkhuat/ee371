#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*
Write a program that prompts for a temperature value, the scale, Celsius, Fahrenheit, or
Kelvin and the scale to which that temperature is to be converted. Display the result in
the requested scale. Think about an informative way to print the answer.
2. When designing high-speed circuits, it is often very important to know the delay from the
point where the signal enters the path until it leaves.
*/
double conv(double temp_value, char* src_scale, char* dst_scale);
int validate_format_char(char format);

int main(int argc, char* argv[]) {
	if (argc != 4) {
		printf("Error: Expected 4 arguments, but found %d \n", argc - 1);
		printf("Usage: ./thermo temp_value src_scale dst_scale \n");
		exit(1);
	}

	double temp_value;
    char src_scale[strlen(argv[2]) + 1], dst_scale[strlen(argv[3]) + 1];
	if (!sscanf(argv[1], "%lf", &temp_value) ||
			!sscanf(argv[2], "%s", src_scale) ||
			!sscanf(argv[3], "%s", dst_scale)) {
		printf("Error: Failed to scan arguments \n");
		exit(1);
	}

    printf("Conversion from %s to %s:\n%f %s is %f %s \n",
            src_scale,
            dst_scale,
            temp_value,
            src_scale,
            conv(temp_value, src_scale, dst_scale),
            dst_scale);
}

int validate_format_char(char format) {
    switch (format) {
        case 'c':
        case 'f':
        case 'k':
            return 1;
        default:
            return 0;
    }
}

double conv(double temp_value, char* src_scale, char* dst_scale) {
    char src_first_ch = tolower(*src_scale);
    char dst_first_ch = tolower(*dst_scale);

    // Validation
    if (!validate_format_char(src_first_ch) || !validate_format_char(dst_first_ch)) {
        printf("Error: Failed to provide proper scale arguments.\n");
        printf("Usage: Scale arguments must each be one of: Celsius, Fahrenheit, or Kelvin. ");
        exit(1);
    }

    // Computation
    double c;
    if (src_first_ch == dst_first_ch) {
        return temp_value;
    } else {
        switch (src_first_ch) {
            case 'c':
                return dst_first_ch == 'f' ? (temp_value * (9.0 / 5.0)) + 32 : temp_value + 273.15;
                break;
            case 'f':
                c = (temp_value - 32) * (5.0 / 9.0);
                return dst_first_ch == 'c' ? c : c - 273.15;
                break;
            case 'k':
                c = c + 273.15;
                return dst_first_ch == 'c' ? c : (temp_value * (9.0 / 5.0)) + 32;
                break;
        }
    }
}

