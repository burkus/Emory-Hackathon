/**
*@author Andrew Burkus
*GUI
  */
import com.leapmotion.leap.processing.*;
import com.leapmotion.leap.Frame;
import com.leapmotion.leap.Gesture;
import com.leapmotion.leap.processing.LeapMotion;
import com.leapmotion.leap.Controller;

LeapMotion leapMotion;
int [] buttons = new int [3];
PVector [] vectors = new PVector[3];
int index;
PImage Background;
void setup() {
  size(displayWidth, displayHeight, P3D);
  textSize(48);
  Background = loadImage("background.jpg");
  Background.resize(displayWidth, displayHeight);
  leapMotion = new LeapMotion(this);
  index = 0;
 ///vectors[0] = new PVector(//add button COORDS);
  //vectors[1] = new PVector(//^);
  //vectors[2] = new PVector(//^);
}

void draw() {
  image(Background, 0, 0);
  drawBox(vectors[index]);
}
 
void drawBox(PVector vector){
  noFill();
  colorMode(RGB);
  stroke(155);
  pushMatrix();
  translate(vector.x, vector.y, 0);
  lights();
  rect(0, 0, 150, 78);
  spotLight(255, 0, 0, 0, 0, 10, 
          0, -1, 0, PI/4, 1);
  popMatrix();
}

void moveIndex(){
  index++;
}

void onInit(final Controller controller)
{
  controller.enableGesture(Gesture.Type.TYPE_CIRCLE);
  controller.enableGesture(Gesture.Type.TYPE_KEY_TAP);
  controller.enableGesture(Gesture.Type.TYPE_SCREEN_TAP);
  controller.enableGesture(Gesture.Type.TYPE_SWIPE);
  // enable background policy
  controller.setPolicyFlags(Controller.PolicyFlag.POLICY_BACKGROUND_FRAMES);
}

void onFrame(final Controller controller)
{
  Frame frame = controller.frame();
  for (Gesture gesture : frame.gestures())
  {
    if ("TYPE_CIRCLE".equals(gesture.type().toString()) && "STATE_START".equals(gesture.state().toString())) {
     fill(155);
     text("Hi", 50, 50);
    }
    else if ("TYPE_KEY_TAP".equals(gesture.type().toString()) && "STATE_STOP".equals(gesture.state().toString())) {
     fill(155);
      text("No!", 50, 50);
    }
    else if ("TYPE_SWIPE".equals(gesture.type().toString()) && "STATE_START".equals(gesture.state().toString())) {
      moveIndex();
    }
    else if ("TYPE_SCREEN_TAP".equals(gesture.type().toString()) && "STATE_STOP".equals(gesture.state().toString())) {
     fill(155);
      text("Whatup", 50, 50);
    }
    println("gesture " + gesture + " id " + gesture.id() + " type " + gesture.type() + " state " + gesture.state() + " duration " + gesture.duration() + " durationSeconds " + gesture.durationSeconds()); 
  }
}
