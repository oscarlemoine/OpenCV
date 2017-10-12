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
              anguloX = anguloX + 10;
              servoX.write(anguloX);
              break;
            case 'R'://Right
              anguloX = anguloX - 10;
              servoX.write(anguloX);
              break;
            case 'U'://UP
              anguloY = anguloY + 10;
              servoY.write(anguloY);   
              break;
            case 'D'://Down
              anguloY = anguloY - 10;
              servoY.write(anguloY);   
              break;
            case '0'://BUSCAR
              servoX.write(0);     
              break;              
            }
        }
   }
 
