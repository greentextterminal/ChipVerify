// Continuous Assignment
// This is essentially continuously driving a wire with signals from some logic such that it instantly 
// updates to refelct the logically "processed" inputs. Typically reserved for combinational logic.

wire a, b, out;
assign out = a & b; // AND gate

/* 
In this example we can visualize the behavior of an AND gate captured with the above Verilog and 
depicted in the visual below. The inputs are a and b. The output is out. The inputs are "processed"
through the AND gate and are immediately reflected in the output (out). The circuit below does not
depend on any timing or memory elements such as a clock based DFF (register; reg), therefore out
is continuously driven by its inputs. When a and b are both 0, out will instantly be driven with a 0, 
when a and b are both 1, out will instantly update and be driven with a 1.
       _______
a ----|       |
      |  AND  |----- out (the output 'out' is a continuous assignment)
b ----|  gate |
       -------
*/
