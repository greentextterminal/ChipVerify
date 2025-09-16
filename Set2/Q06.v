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

always @ (*) begin
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

always @ (*) begin
  casez (switches)
    4'b???1 : leds = 4'b0001; // case 1, 1 LED on
    4'b??1? : leds = 4'b0011; // case 2. 2 LEDs on
    4'b?1?? : leds = 4'b0111; // case 3, 3 LEDs on
    4'b1??? : leds = 4'b1111; // case 4, 4 LEDs on
    default : leds = 4'b0000; // default case, all LEDs off
  endcase
end

/*
casez examples:
if switches == 0010 then case 2 will execute
if switches == 1000 then case 4 will execute
if switches == 1111 then case 1 will execute due to priority (something to note if cases 1, 2, or 3 were desired)
if switches == 0000 then default case case will execute
if switches == ZZZZ then case 1 will execute due to the case expression value and the first priority of the case item. This needs to be broken down
                    since the case expression, case item, and the priority ordering of the case item all play a role. The case expression is 4'ZZZZ
                    and during the case item comparison the first case item we encounter is case 1 whose condition is 4'b???1. Since the case item
                    condition of case 1s upper 3 bits is ??? then the those upper 3 bits are ignored (ignores 0, 1, or Z), while the lower bit is a 1 
                    which means that the comparison is exlusively looking for a 1 to match. However, the case expression we're passing in is ZZZZ,
                    so when compared against the first items the upper 3 bits are ignored, but the lower bit is a Z. In a casez statement the 'Z' 
                    is a wildcard and acts like a "dont care" bit so when the lower Z bit in the case expression is compared against the lower 1 bit
                    in case item 1, then the 1 is ignored and the upper bits are as well. Subsequently, a match occurs and case item 1 wins the comparison.

                    case expression = ZZZZ        case item 1 = ???1  comparisons  notes
                    -----------------------       ------------------  -----------  -----------------------------------------------------------------------------------------------------------------------
                    bit[3] = Z  <---dont care---> bit[3] = ?          "match"      ? is a dont care, so the case expressions 0,1,Z are ignored
                    bit[2] = Z  <---dont care---> bit[3] = ?          "match"      ? is a dont care, so the case expressions 0,1,Z are ignored
                    bit[1] = Z  <---dont care---> bit[1] = ?          "match"      ? is a dont care, so the case expressions 0,1,Z are ignored
                    bit[0] = Z  <---dont care---> bit[0] = 1          "match"      case item 1 is explicitly looking for bit 1, but the incoming bit 1 of the case expression is a Z (dont care situation)
                    
                    It should be noted that this is only valid behavior in simulation. Once synthesized into hardware, Z (high-impedance) values or X (unknown) values
                    don't really exist. Z would become a floating value and could take on a 1 or 0 depending on the electrical characteristics of the ciruit
                    and the broader system it's located in, while an unknown value would settle to some value of 0 or 1 in a circuit. The simulator outputs an X
                    when it can't predict a value. With this nuance in mind one should be aware of the differences between simulation and hardware. The results
                    obtained from simulation can very easily differ from the realities of hardware. An example of this can be observed with this casez example. In simualation
                    we can observe a (ZZZZ) and logically map its ouput to something like case item 1, but in hardware those Z's are floating pins and if internal/external
                    pull up or pull down resistors weren't used to properly tri-state and pull the line up or down then you could have a scenario where perhaps all four pins are floating
                    at some voltage level below the threshold voltage needed to be registered as a 1 and thus the case expression looks like this (0000) which would match the default case item.
                    However, stray EMI or crosstalk could push the voltage level of one of the floating Z bits, lets say bit 3's, past the threshold voltage to be registered as a 1, 
                    changing the case expression to (1000) and now case item 4 wins the comparison, completely changing the outcome. For this reason, care should be taken
                    when designing digital circuits, since fundamental differences exist between simulation and hardware implementations.
*/

/*
casex statements

They are identical to the casez explanation above except for the fact that the '?' wildcard ignores 0, 1, Z, and X. X being an unknown.
It looks identical to a casez statement and the only difference is that you can pass in X (unknowns) and the '?' operator ignores them.
This is considered risky because this can mask potential bugs.
*/

// casex example
input [3:0] switches;
output reg [3:0] leds;

always @ (*) begin
  casez (switches)
    4'b???1 : leds = 4'b0001; // case 1, 1 LED on
    4'b??1? : leds = 4'b0011; // case 2. 2 LEDs on
    4'b?1?? : leds = 4'b0111; // case 3, 3 LEDs on
    4'b1??? : leds = 4'b1111; // case 4, 4 LEDs on
    default : leds = 4'b0000; // default case, all LEDs off
  endcase
end

/*
casez examples:
if switches == X1XZ then case 3 will execute
if switches == 10XZ then case 4 will execute
