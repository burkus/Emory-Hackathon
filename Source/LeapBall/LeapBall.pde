

import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

import de.voidplus.leapmotion.*;
import development.*;



//fields
short frame;
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
  frame = 0;
  frameX = displayWidth;
  frameY = displayHeight;
  frameZ = 0;
  leap = new LeapMotion(this);
  points = 0;
  
  font = loadFont("OCRAExtended-48.vlw");
    minim = new Minim(this);

  player = minim.loadFile("resonance.mp3");
  player.play();
  player.loop();
  
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
}


void draw(){
  if(frame==0){
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
    frame = 3;
  }
  if(index == 3){
   exit();
  }
  }
  }

  
  if(frame==1){

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
if(frame==3){
  image(help,0,0);
  timer++;
  if(timer >= 600){
   timer = 0;
   frame = 0; 
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
stroke(50,200,50);
 rect(paddleX,paddleY,100,50);
 }catch(Exception e){
  println(e); 
 }
}


void reset(){ 
frame = 0;
}  
  
void initGame(){
 points = 0;
  lives = 3; 
 frame = 1;
}

void stop(){
 minim.stop();
 super.stop();
player.close(); 
}


  

