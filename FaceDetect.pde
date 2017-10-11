import gab.opencv.*;
import processing.video.*;
import java.awt.*;
import processing.serial.*;

Capture video;
OpenCV opencv;
PImage miraFrancotirador;
Serial puerto;

void setup() {
  puerto = new Serial(this, "COM3", 9600);
  miraFrancotirador = loadImage("francotirador1.png");
  size(670, 510);
  video  = new Capture(this, 640/2, 480/2);
  opencv = new OpenCV(this, 640/2, 480/2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  opencv.startBackgroundSubtraction(5, 3, 0.5);  
  video.start();
}

void draw() {
  int minX = 150;
  int maxX = 170;
  int minY = 100;
  int maxY = 140;  
  
if(video.available()){
  video.read();
  }
  
scale(2);
opencv.loadImage(video);
image(video,8,8);//(imagen, X, Y)
text("+",160,120);//posicion Y   

Rectangle[] faces = opencv.detect();
 
for(int i = 0; i< faces.length;i++){
  noFill();       //objeto sin relleno
  stroke(255,100,0);//color linea(rojo, verde, azul)
  strokeWeight(1);//ancho de linea del objeto a dibujar
  //zona demarcada
  line(minX, 20, minX, 240);
  line(maxX, 20, maxX, 240);
  line(20,minY ,310,minY);
  line(20,maxY,310,maxY);

 //muestra posicion
 text("X:"+(faces[0].x)+", Y:"+(faces[0].y),//texto 
       10 ,   //posicion X
       20);   //posicion Y  
  
//demarcacion de objeto detectado
//mira de francotirador
  image(miraFrancotirador,
        faces[i].x+5,                     //posicion X
        faces[i].y-faces[i].height/2*0.5, //posicion Y
        faces[i].width*1.1,               //ancho
        faces[i].height*1.3);             //alto
  //puntero
  text("*",//ubicacion puntero laser
       faces[0].x+faces[0].width*0.5,//posicion x
       faces[0].y+faces[0].height*0.5);//posicion Y
      


/*
//dibuja elipse sobre cara
  text("+", faces[i].x+faces[i].width/2*1.1,faces[i].y+faces[i].height/2);  
  text("Alto:"+faces[i].height+", Ancho:"+faces[i].width, faces[i].x ,faces[i].y);  
  ellipse(faces[i].x+faces[i].width/2*1.1, // X
          faces[i].y+faces[i].height/2*1.3,// Y
          faces[i].width*1.1,              // ancho
          faces[i].height*1.3);            // alto
*/
//mueve servo eje X(derecha o izquierda)
if(faces[0].x+faces[0].width*0.5<150){
  println("mover Izquierda: "+1);
  puerto.write('L');
}else if(faces[0].x+faces[0].width*0.5>170){
         println("mover Derecha  : "+1);
         puerto.write('R');
         }else{
           println("mantener X");
           puerto.write('S');
         }
         
//mueve servo eje Y (arriba o abajo)
if(faces[0].y<70){
  println("mover arriba: "+1);
  puerto.write('U');
}else if(faces[0].y>110){
         println("mover abajo  : "+1);
         puerto.write('D');
         }else{
           println("mantener Y");
           puerto.write('S');
         }
         
         
         
  }
}
/*
void movieEvent(Movie m) {
  m.read();
}*/