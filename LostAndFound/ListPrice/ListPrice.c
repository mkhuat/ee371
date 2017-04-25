#include <stdio.h>
#include <math.h>

// calc_mark_up accepts price and mark_up, returning marked_up price
double calc_mark_up(double price, double mark_up)
{
	return price + price * (mark_up/100);
}

// calc_discount accepts price and discount, returning discounted price
double calc_discount(double price, double discount)
{
	return price - price * (discount/100);
}

// calc_tax accepts price and tax, returning post-tax price
double calc_tax(double price, double tax)
{
	return price + price * (tax/100);
}

// validate_input accepts manufacturer_cost, mark_up, discount, and sales_tax and validates
// these arguments as valid within the constraints of a car cost computation.
int validate_input(double manufacturer_cost, double mark_up, double discount, double sales_tax)
{
	if (manufacturer_cost < 0)
	{
		printf("Manufacturer cost must be at least $0, but found $%.2f \n", manufacturer_cost);
		return 0;
	}
	if (mark_up < 0)
	{
		printf("Markup must be at least 0%%, but found %.2f%% \n", mark_up);
		return 0;
	}
	if (discount < 0 || discount > 100)
	{
		printf("Cars must be discounted between 0%% and 100%%, but found %.2f%% \n", discount);
		return 0;
	}
	if (sales_tax < 0)
	{
		printf("Sales tax must be at least 0%%, but found %.2f%% \n", sales_tax);
		return 0;
	}
	if (isinf(manufacturer_cost) || isinf(mark_up) || isinf(discount) || isinf(sales_tax))
	{
		printf("An input value is too large \n");
		return 0;
	}
	return 1;
}

int main(int argc, char** argv)
{
	if (argc != 5) {
		printf("Error: Expected 4 arguments, but found %d \n", argc - 1);
		printf("Usage: ./listPrice manufacturer_cost mark_up discount sales_tax \n");
		return 1;
	}

	double manufacturer_cost, mark_up, sales_tax, discount;
	if (!sscanf(argv[1], "%lf", &manufacturer_cost) ||
			!sscanf(argv[2], "%lf", &mark_up) ||
			!sscanf(argv[3], "%lf", &discount) ||
			!sscanf(argv[4], "%lf", &sales_tax)) {
		printf("Error: Failed to scan arguments \n");
		return 1;
	}

	if (!validate_input(manufacturer_cost, mark_up, discount, sales_tax))
	{
		printf("Error: Invalid input\n");
		return 1;
	}

	double pre_tax = calc_discount(calc_mark_up(manufacturer_cost, mark_up), discount);
	double final_cost = calc_tax(pre_tax, sales_tax);

	if (isnan(final_cost) || isinf(final_cost))
	{
		printf("Error: Output overflowed floating point \n");
		return 1;
	}

	printf("Car Price Calculator \n");
	printf("Manufacturer Cost: $%.2f, Dealer Markup: %.2f%%, Discount: %.2f%%, Sales Tax: %.2f%% \n", manufacturer_cost, mark_up, discount, sales_tax);
	printf("Final car cost: $%.2f \n", final_cost);
	return 0;
}


