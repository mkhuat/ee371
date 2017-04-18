module testBench;
	// connect the two modules
	wire inputs;
	wire outputs;
	
	// declare an instance of the MyDesign module
	Main main (outputs, inputs);
	
	// declare an instance of the Tester module
	Tester myTester (outputs, inputs);

	// file specifications for gtkwave

	initial

	begin

		// dump file is for dumping all the variables in a simulation
		$dumpfile("gfxFile.vcd");

		// dumps all the variables in module myDesign and below
		// but not modules instantiated in myDesign into the dump file.
		$dumpvars(1,myDesign);

	end

endmodule