// What do you understand by casex and casez statements?

/*
case statements
All case statements (case, casez, casex) are a way to describe conditional logic.
For context, standard case modeling should first be described.
In a case statement you have a case expression, case items, case statement(s), and a default statement.
If a case expression matches a case item then that case items case statements will execute. Like in C,
only one of the case items statements can execute if a case expression matches a case item. If none of the
case items match then the default case items statemens will execute. Case statements require exact matches.
case, casez, and casex statments all have similar structures, they mainly differ in logic. An example case/casez/casex structure is depicted below:

case (case_expression)
  case_item1 : 
    begin
      // case 1 statements ...
      // ...
    end
  case_item2 :
  begin
      // case 2 statements ...
      // ...
    end
  case_item3 :
  begin
      // case 3 statements ...
      // ...
    end
  default:
  begin
      // case 4 statements ...
      // ...
    end
endcase
*/

// case example
input [3:0] switches;
output reg [3:0] leds;

always @ (switches) begin
  case (switches)
    4'b0001 : leds = 4'b0001; // 1 LED on
    4'b0010 : leds = 4'b0011; // 2 LEDs on
    4'b0100 : leds = 4'b0111; // 3 LEDs on
    4'b1000 : leds = 4'b1111; // 4 LEDs on
    default : leds = 4'b0000; // all LEDs off
  endcase
end

/*
casez statements
casez statements are similar in structure to a case statement but differ in their case expression
and case items matching. In casez statment, the actual case expression doesn't change, rather it 
allows for wildcard operators ('?') to be used in case item comparison. By introducing the '?' character 
into the case item you introduce flexibility to the comparison being done between the case expression
and the case item. The '?' character is a "dont care" bit meaning it can take on the values: 0, 1, Z. 
The '?' is a dont care bit only in the bit position that it is assigned to. Due to the overlap in case item
matches that can occur relative to the case expression, multiple case items may match a case expression.  
Therefore, it is very important to remember that the first case item that matches the case expression will 
be the block that executes. This means that the first matching casez item has priority. The wildcard is used
in the case expression as well as the case items, so it is important to remember they work in tandem.
'?' is the wildcard and is ignored during comparison. '?' wildcard ignores 0, 1, and Z.
*/

// casez example
input [3:0] switches;
output reg [3:0] leds;

always @ (switches) begin
  casez (switches)
    4'b???1 : leds = 4'b0001; // case 1, 1 LED on
    4'b??1? : leds = 4'b0011; // case 2. 2 LEDs on
    4'b?1?? : leds = 4'b0111; // case 3, 3 LEDs on
    4'b1??? : leds = 4'b1111; // case 4, 4 LEDs on
    default : leds = 4'b0000; // default case, all LEDs off
  endcase
end

/*
Examples:
if switches == 0010 then case 2 will execute
if switches == 1000 then case 4 will execute
if switches == 1111 then case 1 will execute due to priority (something to note if cases 1, 2, or 3 were desired)
if switches == 0000 then default case case will execute
if switches == ZZZZ then case 1 will execute since the upper 3 bits of the case item are dont cares while the fourht bit is a 1,
                    the switches input, which is the case expression, is 4 Z's and since the upper 3 bits in both the case expression
                    and the case item of case 1 are ignored, the 
*/

/*
casex statements


*/
