//Variables to initialize inside main:


import de.voidplus.leapmotion.*;
import development.*;

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

