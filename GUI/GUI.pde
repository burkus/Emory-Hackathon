import de.voidplus.leapmotion.*;
import development.*;
///GUIIII
//GUI
LeapMotion leap;
PImage img;
int index;
PVector[] vectors;

int num_fingers;

void setup() {
  size(displayWidth, displayHeight - 160, P3D);
  fill(50);
  frameRate(1);
  
  vectors = new PVector[4];
  leap = new LeapMotion(this);
  vectors[0 + 1] = new PVector(1030, 215); //LOCATIONS OF GUI rects
  vectors[1 + 1] = new PVector(1070, 280);
  vectors[2 + 1] = new PVector(1105, 340);
  index = 1;
  img = loadImage("background.jpg");
  img.resize(displayWidth, displayHeight - 160);
}

void GUIdraw() { //test draw
  image(img, 0, 0);
  update(leap);
  drawBox(vectors[index]);
  if(num_fingers > 3) {
    num_fingers = 3;
  }
  if(num_fingers < 1) {
   num_fingers = 1; 
  }
  index = num_fingers;
  while(index == 1) {
    if(keyPressed(ENTER) || keyPressed(RETURN)) {
      initGame();
      break;
    }
  }
  while(index == 2) {
    frame = 3;
    break;
  }
  while(index == 3){
   exit(); 
  }
}

void drawBox(PVector vector){
  noFill();
  colorMode(RGB);
  stroke(155);
  pushMatrix();
  rect(vector.x, vector.y, 150, 70);
  spotLight(255, 0, 0, 0, 0, 10, 
          0, -1, 0, PI/4, 1);
  popMatrix();
}

