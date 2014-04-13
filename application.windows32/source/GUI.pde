
///GUIIII
//GUI

PImage img;
int index;
PVector[] vectors;
 //test draw
  
  
  

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

void moveIndex(){
 index++;
 if(index >= 3)
  index = 0;
}


