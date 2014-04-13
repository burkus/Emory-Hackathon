

import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

import de.voidplus.leapmotion.*;
import development.*;



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


void setup(){
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


void draw(){
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

void drawEnvironment(){
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

void drawPaddle(){

   try{
     
paddleX = hand_position.x*1.1;
paddleY = hand_position.y*1.1;

  noFill();
  strokeWeight(2);
stroke(0,255,0);
 rect(paddleX,paddleY,100,50);
 }catch(Exception e){
  println(e); 
 }
}


void reset(){ 
frameNumber = 0;
}  
  
void initGame(){
 points = 0;
  lives = 3; 
 frameNumber = 1;
}

void stop(){
 minim.stop();
 super.stop();
player.close(); 
}


 void initialize(){
  if(!init){
    player.play();
  player.loop();
 init = true; 
  }
  
 } 

