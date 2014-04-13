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

void moveIndex(){
 index++;
 if(index >= 3)
  index = 0;
}

void update(LeapMotion leap){

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


