#!/bin/bash

# Usage ./runTest.sh FILE.v [FILE.vcd]

if [ $# -lt 1  ]
  then
    echo "runTest.sh: no verilog file(s) to test" 2>&1
    exit 1;
  fi

buildfile=$(mktemp)

iverilog "$1" -o "$buildfile" && vvp "$buildfile"
shift

if [ $# -gt 0  ]
  then
    gtkwave "$1"
  fi

# CLean
rm "$buildfile"

exit 0;
