import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.spi.*; 
import ddf.minim.signals.*; 
import ddf.minim.*; 
import ddf.minim.analysis.*; 
import ddf.minim.ugens.*; 
import ddf.minim.effects.*; 
import de.voidplus.leapmotion.*; 
import development.*; 
import de.voidplus.leapmotion.*; 
import development.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class LeapBall extends PApplet {















//fields
short frameNumber;
ball b;
AI ai;
int frameX;
int frameY;
int frameZ;
PImage menuImage;
PImage gui;
PImage help;
int points;
int lives;
PFont font;
int time;
int timer;
boolean init;


int selection;
float paddleX;
float paddleY;

Minim minim;
AudioPlayer player;
AudioPlayer sound1,sound2,sound3,sound4,sound5,sound6,sound7,sound8;
LeapMotion leap;


public void setup(){
index = 1;
  time = 0;
  frameNumber = 0;
  frameX = displayWidth;
  frameY = displayHeight;
  frameZ = 0;
  leap = new LeapMotion(this);
  points = 0;
  
  font = loadFont("OCRAExtended-48.vlw");
    minim = new Minim(this);

  player = minim.loadFile("resonance.mp3");
 
  
  size(frameX, frameY, P3D);
  noCursor();
  b = new ball();
  
ai = new AI();
    menuImage = loadImage("leapBallBG2.jpg");
     menuImage.resize(frameX, frameY);

 gui = loadImage("GUI.png");
      gui.resize(width, height/12);
      

  help = loadImage("leapBallHelp.jpg");
   help.resize(width, height);
  
   initSound();
  vectors = new PVector[4];
  vectors[0 + 1] = new PVector(975, 215); //LOCATIONS OF GUI rects
  vectors[1 + 1] = new PVector(1000, 280);
  vectors[2 + 1] = new PVector(1050, 340);

initialize();
}


public void draw(){
  if(frameNumber==0){
    image(menuImage, 0, 0);
  update(leap);
  drawBox(vectors[index]);
  if(num_fingers > 3) {
    num_fingers = 3;
  }
  if(num_fingers < 1) {
   num_fingers = 1; 
  }
  index = num_fingers;
 
 if(keyPressed){
 if(index == 1) {
      initGame();
      }
    if(index == 2) {
    frameNumber = 3;
  }
  if(index == 3){
   exit();
  }
  }
  }

  
  if(frameNumber==1){

  translate(width/100, height/100,0);
  background(0);
  b.drawBall();
drawEnvironment();
b.applyGravity();
b.testCollisions();
 update(leap);
 drawPaddle();
 ai.act();
if(lives < 0){
 reset();
}
}
if(frameNumber==3){
  image(help,0,0);
  timer++;
  if(timer >= 600){
   timer = 0;
   frameNumber = 0; 
  }
}
}

public void drawEnvironment(){
pushMatrix();
fill(150);
translate(frameX/2,frameY,0);
box(7000,1,7000);
popMatrix();
 image(gui, -13, 0);
 textSize(25);
 fill(100,255,100);
 text(points, 140, 25);
 text(lives, 120, 50);
   stroke(0);

}

public void drawPaddle(){

   try{
     
paddleX = hand_position.x*1.1f;
paddleY = hand_position.y*1.1f;

  noFill();
  strokeWeight(2);
stroke(0,255,0);
 rect(paddleX,paddleY,100,50);
 }catch(Exception e){
  println(e); 
 }
}


public void reset(){ 
frameNumber = 0;
}  
  
public void initGame(){
 points = 0;
  lives = 3; 
 frameNumber = 1;
}

public void stop(){
 minim.stop();
 super.stop();
player.close(); 
}


 public void initialize(){
  if(!init){
    player.play();
  player.loop();
 init = true; 
  }
  
 } 

public class AI{
  
  private float moveX,moveY,moveZ;
  public AI(){
    moveX = 100;
    moveY = 100;
    moveZ = -500;
    
  }
 
  public void act(){
    
    //Set tracing values
    moveX = b.getX() + 40;
    moveY = b.getY();
  
    //Movement
    pushMatrix();
    stroke(0);
    fill(0,0,255);
    translate(moveX,moveY,-1000);
    box(80,100,15);
    popMatrix();

    
    //Collision test
    if ((b.getX() <= (moveX + 40)) && (b.getX() >= (moveX - 40))){
       if ((b.getY() <= (moveX + 50)) && (b.getX() >= (moveX - 50))){
          if (b.getZ() == -150){
            b.bounce();
          }
       }
    }
   
  }
  
}

///GUIIII
//GUI

PImage img;
int index;
PVector[] vectors;
 //test draw
  
  
  

public void drawBox(PVector vector){
  noFill();
  colorMode(RGB);
  stroke(155);
  pushMatrix();
  rect(vector.x, vector.y, 150, 70);
  spotLight(255, 0, 0, 0, 0, 10, 
          0, -1, 0, PI/4, 1);
  popMatrix();
}

public void moveIndex(){
 index++;
 if(index >= 3)
  index = 0;
}


//Variables to initialize inside main:





int     hand_id;         
PVector hand_position;   
PVector hand_stabilized; 
PVector hand_direction;  
PVector hand_dynamics;   
float   hand_roll;       

float   hand_pitch;      
float   hand_yaw;        
PVector sphere_position; 
float   sphere_radius;   

int     finger_id;        
PVector finger_position;  
PVector finger_stabilized;
PVector finger_velocity;  
PVector finger_direction; 

int     touch_zone;    
float   touch_distance;

int     tool_id;        
PVector tool_position;  
PVector tool_stabilized;
PVector tool_velocity;
PVector tool_direction;

float device_horizontal_view_angle;
float device_verical_view_angle;
float device_range;

int num_fingers;






public void update(LeapMotion leap){

     for(Hand hand : leap.getHands()){
            //Hands
          hand_id          = hand.getId();
          hand_position    = hand.getPosition();
          hand_stabilized  = hand.getStabilizedPosition();
          hand_direction   = hand.getDirection();
          hand_dynamics    = hand.getDynamics();
          hand_roll        = hand.getRoll();
          
          hand_pitch       = hand.getPitch();
          hand_yaw         = hand.getYaw();
          sphere_position  = hand.getSpherePosition();
          sphere_radius    = hand.getSphereRadius();
          num_fingers      = hand.getFingers().size();
            // FINGERS
            for(Finger finger : hand.getFingers()){
    
                // Basics
                finger_id         = finger.getId();
                finger_position   = finger.getPosition();
                finger_stabilized = finger.getStabilizedPosition();
                finger_velocity   = finger.getVelocity();
                finger_direction  = finger.getDirection();
             
                // Touch Emulation
                 touch_zone        = finger.getTouchZone();
                 touch_distance    = finger.getTouchDistance();
  
                switch(touch_zone){
                    case -1: // None
                    break;
                    case 0:  //Hovering
                         println("Hovering (#"+finger_id+"): "+touch_distance);
                    break;
                    case 1:  //Touching
                         println("Touching (#"+finger_id+")");
                    break;
                }
            }
    
            // TOOLS
            for(Tool tool : hand.getTools()){
    
                // Basics
                tool_id           = tool.getId();
                tool_position     = tool.getPosition();
                tool_stabilized   = tool.getStabilizedPosition();
                tool_velocity     = tool.getVelocity();
                tool_direction    = tool.getDirection();
    
                // Touch Emulation
                 touch_zone        = tool.getTouchZone();
                 touch_distance    = tool.getTouchDistance();
    
                switch(touch_zone){
                    case -1: // None
                    break;
                    case 0: // Hovering
                         println("Hovering (#"+tool_id+"): "+touch_distance);
                    break;
                    case 1: // Touching
                         println("Touching (#"+tool_id+")");
                    break;
                }
            }
    
        }
    
        // DEVICES
        for(Device device : leap.getDevices()){
           device_horizontal_view_angle = device.getHorizontalViewAngle();
           device_verical_view_angle = device.getVerticalViewAngle();
           device_range = device.getRange();
        }

}

//Ball class

class ball{
 private final float GRAVITY = -.1f;
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
  
  public void drawBall(){
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
  
  public void applyGravity(){
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
  
  public void setX(float sx){
    x = sx;
  }
  public void setY(float sy){
    y = sy;
  }
  public void setZ(float sz){
    z = sz;
  }
  public void setDX(float sdx){
    dx = sdx;
  }
  public void setDY(float sdy){
    dy = sdy;
  }
  public void setDZ(float sdz){
    dz = sdz;
  } 
  
  public void testCollisions(){
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
  
  public void bounce(){
    dz = -dz;
    dx = dx + (random(10)-5);
    points+=5;
    playerHit();
  }
 
 
 }
public void initSound(){

 sound1 = minim.loadFile("glassHit.mp3", 2048);
 //sound2 = minim.loadFile("glassHit.mp3", 2048);
 sound3 = minim.loadFile("gravelHit.mp3", 2048);
 //sound4 = minim.loadFile("hoverSelect.mp3", 2048);
 //sound5 = minim.loadFile("finalSelect.mp3", 2048);
 //sound6 = minim.loadFile("gameStart.mp3", 2048);
 //sound7 = minim.loadFile("gameWin.mp3", 2048);
 //sound8 = minim.loadFile("gameLose.mp3", 2048);
 
}

public void playerHit(){
  
 sound1.play();

}

public void AIHit(){

// sound2.play(); 


}

public void gravelHit(){
  
  sound3.play(); 


}

public void hover(){
  
 //sound4.play(); 

}

public void finalSelect(){
 
 //sound5.play(); 

}

public void gameStart(){
  
 //sound6.play(); 

}

public void gameWin(){
  
// sound7.play(); 
}

public void gameLose(){
  
  //sound8.play(); 
}




  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--hide-stop", "LeapBall" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
