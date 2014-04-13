//Ball class

class ball{
 private final float GRAVITY = -.1;
 private float x;
 private float y;
 private float z;
 private float dx;
 private float dy;
 private float dz;
 private int size;
  
  public ball(){
  x = width/2;
  y = height/2;

  dz = 3;
  dx = 0;
  z = -500;
  size = 50;
  } 
  
  void drawBall(){
   pushMatrix();
   translate(x,y,z);
   strokeWeight(1);
    stroke(0,0,0);
   fill(255,0,0);
  sphere(size);
  popMatrix(); 
y +=dy;
x +=dx;
z +=dz;
  
}
  
  void applyGravity(){
    dy -= GRAVITY;
    y -= GRAVITY;
  }
  
  public float getX(){
   return x; 
  }
  public float getY(){
   return y; 
  }
  public float getZ(){
   return z; 
  }
  public float getDX(){
   return dx; 
  }
  public float getDY(){
   return dy; 
  }
  public float getDZ(){
   return dz; 
  }
  
  void setX(float sx){
    x = sx;
  }
  void setY(float sy){
    y = sy;
  }
  void setZ(float sz){
    z = sz;
  }
  void setDX(float sdx){
    dx = sdx;
  }
  void setDY(float sdy){
    dy = sdy;
  }
  void setDZ(float sdz){
    dz = sdz;
  } 
  
  void testCollisions(){
    if(y >= height-40){
     dy = -dy;
    y += GRAVITY;
   points++;
  gravelHit(); 
    }
    if(dx >= 20){
     dx--; 
    }
    if(dx <= -20){
      dx++;
    }
     if(dy >= 20){
     dy--; 
    }
    if(dy <= -20){
      dy++;
    }
     if(dz >= 20){
     dz--; 
    }
    if(dz <= -20){
      dz++;
    }
    if(x >= width){
      dx = -dx;
    }
    if(x <= 0){
     dx = -dx;
    }
   if((z >= -50 && z <= 60) && (x >= paddleX && x <= (paddleX+100)) && y >= (paddleY-50)){

     bounce();
   } 
   if(z <= -1000){
     AIHit();
     bounce(); 
   }
   if(z >= 500){
    gameLose();
     lives--;
    x = width/2;
    y = height/2;
    z = -200;
     dz = 3;
     dx = 0;
     dy = 0;
   }
  
   
   
  }
  
  void bounce(){
    dz = -dz;
    dx = dx + (random(10)-5);
    points+=5;
    playerHit();
  }
 
 
 }
