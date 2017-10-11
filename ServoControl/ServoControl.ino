#include <Servo.h>
  Servo servoY;
  Servo servoX;
  int anguloX = 90;
  int anguloY = 90;
  int x, y;
  char dato;

void setup() {
    Serial.begin(9600);
    servoY.attach(4);
    servoX.attach(3);
    servoY.write(anguloY);
    servoX.write(anguloX);
}

void loop() {
        // send data only when you receive data:
        if (Serial.available() > 0){
          dato = Serial.read();
          switch(dato){            
            case 'L'://Left
              anguloX =- 10;
              break;
            case 'R'://Right
              anguloX =+ 10;
              break;
            case 'U'://UP
              anguloY =-10;
              break;
            case 'D'://Down
              anguloY =+10;
              break;
            /*case "S":
              anguloX;
              anguloY;
            */
            }
        }
          Serial.print("Servo X = " + anguloX);
          Serial.println(" , Y = " + anguloY);          
          servoX.write(anguloX);
          servoY.write(anguloY);       
   }
 
