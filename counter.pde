int x = 0; // a variable that will be used to keep track of the number currently displayed.
int button = 13; // The button variable refers to pin 13, which gets 5V input whenever the physical button is pressed.
unsigned long changeTime; //time the button was last pressed.
void setup() //function to set up the pins
{                
  pinMode(1, OUTPUT);     
  pinMode(2, OUTPUT); 
  pinMode(4, OUTPUT);     
  pinMode(5, OUTPUT); 
  pinMode(6, OUTPUT);     
  pinMode(7, OUTPUT); 
  pinMode(9, OUTPUT);     
  pinMode(10, OUTPUT);  // all pins except pin 13 supply 5V to the Single Digit Display.
  pinMode(button, INPUT); //pin 13 is the input pin
 
}
 /* 
 This is a 2d array that has 10 1d arrays. Each 1d array stores the state
 of the digits from 0 to 9. Each 1d array has 11 integers, most of which
 correspond to the LED in the SDD. For a certain digit, if a certain LED
 in the SDD should be powered on, then the value correspnding to LED in that digit array will be 1. For example for digit 8, LED no. 2 should be switched on. So digits[8][2] == 1. Arrays start from 0, but since the numbering of my LEDs start from 1 in the schematic, the 0th integer of every digit array will be 0, as output pin no. 0 in my Arduino isn't connected to anything. Also since 3 and 8 refer to ground in the SDD schematic, the 3rd and 8th element of every digit array will be 0, as output pin no. 3 and output pin no. 8 in my Arduino isn't connected to anything. Finally LED 5 in the SDD is the decimal point LED which I don't use in the project, so the 5th element of every digit display will be 0. To display 7. instead of 7, change digits[7][5] to 1, so that the decimal point will be displayed.
 */
 
int digits[10][11] = {{0, 1, 1, 0, 1, 0, 1, 1, 0, 1, 0},
{0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0},
{0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 1},
{0, 0, 1, 0, 1, 0, 1, 1, 0, 0, 1},
{0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 1},
{0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 1},
{0, 1, 1, 0, 1, 0, 0, 1, 0, 1, 1},
{0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0},
{0, 1, 1, 0, 1, 0, 1, 1, 0, 1, 1},
{0, 0, 1, 0, 1, 0, 1, 1, 0, 1, 1}};



void controller(int dig[]) /* a method to display a certain digit. Takes the digit array as a parameter. */
{
  digitalWrite(1, LOW);
  digitalWrite(2, LOW); 
  digitalWrite(4, LOW);
  digitalWrite(6, LOW); 
  digitalWrite(7, LOW);
  digitalWrite(8, LOW); 
  digitalWrite(9, LOW);
  digitalWrite(10, LOW); //turn off all LEDs.
  
    for (int i = 0; i <= 10; i++) /* iterate through every element in the array, and if the element has the value of 1, turn on the LED that corresponds to the element number. For example if dig[4] == 1, turn on LED no. 4. */
  {
    if(dig[i] == 1)
    {
      digitalWrite(i, HIGH);
    }
  }
}


void loop() // keep on doing the following
{

 int state = digitalRead(button); //see if button is pressed (state == high)
 if (state == HIGH && (millis() - changeTime) > 150)
/* If the button is pressed, AND it has been atleast 150 ms. before the last button press, the increase the number in the SDD. The part about checking the time passed is important to prevent the SDD from skipping numbers.

*/
 {
   if(x < 10) 
/* x is iniatized to be 0, if x is smaller than 9, then do the following */
   {
   controller(digits[x]); // function to display x.
   x++; // add one to x.
   state = LOW; // change button state to low, not pressed
   changeTime = millis(); // get time of the button press.
   }
   
   else
/*If x > 9, then make x return to 0, as the SDD cannot display 2 or more digit numbers.
*/
   {
     x = 0; // change x to 0.
   controller(digits[x]); // function to display x.
   x++; // add one to x.
   state = LOW; // change button state to low, not pressed
   changeTime = millis(); // get time of the button press.
   } 
 }
 
 
}
