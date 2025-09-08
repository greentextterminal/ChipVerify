// Synchronous (Clocked) Reset Example
// The sensitivity list depends on the posedge of clk, therefore only during a rising edge of the clk
// if rst is asserted then the reset condition is triggered and the reset block is executed.
// This results in a clocked or synchronous process since the conditions will only trigger during the posedge of clk.
reg signal;
always @ (posedge clk) begin
  if (rst) begin // if clk == 1 && rst == 1 ; synced to clk
    signal <= 0;
  end
  else begin
    signal <= 1;
  end
end

// Asynchronous (Unclocked) Reset Example
// The sensitivity list depends on the posedge of clk and the posedge of rst, thefore if rst is asserted
// then the reset condition will be triggered and the reset block will execute regardless of the clk edge.
// This results in an unclocked or asynchronous reset process since clk edge alignment can be circumvented.
reg signal;
always @ (posedge clk or posedge rst) begin
  if (rst) begin // if rst == 1 ; unsynced to clk
    signal <= 0;
  end
  else begin
    signal <= 1;
  end
end
