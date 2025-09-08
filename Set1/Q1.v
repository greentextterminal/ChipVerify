// swapping contents of 2 registers with a temporary register
// blocking assignments for sequential execution
reg a, b, temp;
always @ (posedge clk) begin
  temp = a;    // store a in temp; temp now holds a
  a    = b;    // store b in a; a now holds b
  b    = temp; // store temp in b; b now holds temp (a)
end

// swapping contents of 2 registers without a temporary register
// non blocking assignments for parallel execution
reg a, b;
always @ (posedge clk) begin
  a <= b; // store b in a (occurs in parallel with line below)
  b <= a; // store a in b (occurs in parallel with line above)
end
