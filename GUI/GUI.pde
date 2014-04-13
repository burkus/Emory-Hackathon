import com.leapmotion.leap.Frame;
import com.leapmotion.leap.Gesture;
import com.leapmotion.leap.processing.LeapMotion;
import com.leapmotion.leap.Controller;

PImage img;
LeapMotion leapMotion;
PVector mousepos;
int index;
PVector[] vectors;

void setup() {
 size(displayWidth, displayHeight, P3D);
 leapMotion = new LeapMotion(this);
 img = loadImage("background.jpg");
 img.resize(displayWidth, displayHeight-160);
 frameRate(1);
 vectors = new PVector[3];
 vectors[0] = new PVector(1030, 215);
 vectors[1] = new PVector(1070, 280);
 vectors[2] = new PVector(1105, 340);
 index = 0;
}

void draw() {
  mousepos = new PVector(mouseX, mouseY);
  image(img, 0, 0);
  drawBox(vectors[index]);
  System.out.println(mousepos);
}
 
void drawBox(PVector vector){
  noFill();
  colorMode(RGB);
  stroke(155);
  pushMatrix();
  //translate(vector.x, vector.y, 0);
  rect(vector.x, vector.y, 150, 70);
  spotLight(255, 0, 0, 0, 0, 10, 
          0, -1, 0, PI/4, 1);
  popMatrix();
}

void moveIndex(){
  if(index >= 0 && index < 2)
    index ++;
  if(index >= 3)
    index = 0;
    
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
