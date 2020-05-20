PImage img, img1;
import oscP5.*;
import netP5.*;
OscP5 oscP5;
int puerto;
float xa; // valor del mouse
float ya;
float posx, posy;

void setup() {
  size(900, 720);
  frameRate(30); //  Especifica el número de fotogramas que se mostrarán cada segundo.
  img = loadImage("bode.jpg");
  img.loadPixels(); //Laimagen sera convertida a pixeles 
  loadPixels();
  
  puerto=12000;
  oscP5=new OscP5(this,puerto);
}

void draw() {
  if(mousePressed){
    img1 = loadImage("rem.jpg");
    img1.loadPixels(); //Laimagen sera convertida a pixeles 
    loadPixels();
    
    for (int x = 0; x < img1.width; x++) {
      for (int y = 0; y < img1.height; y++ ) { 
        int loc = x + y*img1.width; //Calcula la ubicación 1D a partir de una cuadrícula 2D
        float r,g,b; // Obtiene los valores R, G, B de la imagen
        r = red (img1.pixels[loc]);
        g = green (img1.pixels[loc]);
        b = blue (img1.pixels[loc]);
        
        float maxdist = 100; //Calcula una cantidad para cambiar el brillo en función de la proximidad al mouse = tamaño circulo
        float d = dist(x, y, posx, posy);//Funcion del Mouse
        float adjustbrightness = 255*(maxdist-d)/maxdist; // radio de luz e intensidad
        r += adjustbrightness;
        g += adjustbrightness;
        b += adjustbrightness;
        
        r = constrain(r, 0, 255); //Restrinje los valores RGB entre blanco y negro
        color c = color(r,g, b); // se escoge el color a utilizar
        pixels[y*width + x] = c;
      }
    }
    updatePixels();
      
    } else{
    for (int x = 0; x < img.width; x++) {
      for (int y = 0; y < img.height; y++ ) { 
        int loc = x + y*img.width; //Calcula la ubicación 1D a partir de una cuadrícula 2D
        float r,g,b; // Obtiene los valores R, G, B de la imagen
        r = red (img.pixels[loc]);
        g = green (img.pixels[loc]);
        b = blue (img.pixels[loc]);
        
        float maxdist = 100; //Calcula una cantidad para cambiar el brillo en función de la proximidad al mouse = tamaño circulo
        float d = dist(x, y, posx, posy);//Funcion del Mouse
        float adjustbrightness = 255*(maxdist-d)/maxdist; // radio de luz e intensidad
        r += adjustbrightness;
        g += adjustbrightness;
        b += adjustbrightness;
        
        r = constrain(r, 0, 255); //Restrinje los valores RGB entre blanco y negro
        color c = color(r,g, b); // se escoge el color a utilizar
        pixels[y*width + x] = c;
      }
    }
    updatePixels();
    }
}

void oscEvent(OscMessage theOscMessage)
{
  if (theOscMessage.checkAddrPattern("/xa")==true){
    
    if (theOscMessage.checkTypetag("f")){
      xa=theOscMessage.get(0).floatValue();
      println("pd--> posx: "+xa);
      posx=int (map(xa,0,1.0,0,width));
      return;
    }
      
    }
    
    if (theOscMessage.checkAddrPattern("/ya")==true){
    
    if (theOscMessage.checkTypetag("f")){
      ya=theOscMessage.get(0).floatValue();
      println("pd--> posy: "+ya);
      posy=int (map(ya,0,1.0,0,width));
      return;
    }
      
    }
}
