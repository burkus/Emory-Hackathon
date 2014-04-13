import com.leapmotion.leap.Controller;
import com.leapmotion.leap.Finger;
import com.leapmotion.leap.Frame;
import com.leapmotion.leap.Hand;
import com.leapmotion.leap.HandList;
import com.leapmotion.leap.Controller;
import com.leapmotion.leap.processing.LeapMotion;

import oscP5.OscMessage;
import oscP5.OscP5;

LeapMotion leapMotion;

OscP5 oscP5;
String host = "localhost";
int sendPort = 6449;
public static PVector hand_position;
void setup()
{
  size(displayWidth, displayHeight, P3D);

  leapMotion = new LeapMotion(this);
}

void draw()
{
  background(0);
  fill(20);
  translate(width/2, height/2, 0);
  rect(0, 0, width, height);
}

void onFrame(final Controller controller)
{
  Frame frame = controller.frame();
  HandList hands = frame.hands();
  if (!hands.isEmpty())
  {
    Hand leftHand = hands.leftmost();
    sendHand("/hand0", leftHand);

    for (int i = 0, size = leftHand.fingers().count(); i < size; i++)
    {
      sendFinger("/finger0-" + i, leftHand.fingers().get(i));
    }

    if (hands.count() > 1)
    {
      Hand rightHand = hands.rightmost();
      sendHand("/hand1", rightHand);

      for (int i = 0, size = rightHand.fingers().count(); i < size; i++)
      {
        sendFinger("/finger1-" + i, rightHand.fingers().get(i));
      }
    }
  }
}

void sendHand(final String address, final Hand hand)
{
  OscMessage message = new OscMessage(address);
  message.add(hand.id());
  message.add(0);
  message.add(hand.stabilizedPalmPosition().getX());
  message.add(hand.stabilizedPalmPosition().getY());
  message.add(hand.stabilizedPalmPosition().getZ());
  oscP5.send(message, host, sendPort);
}

void sendFinger(final String address, final Finger finger)
{
  OscMessage message = new OscMessage(address);
  message.add(finger.hand().id());
  message.add(finger.id());
  message.add(finger.stabilizedTipPosition().getX());
  message.add(finger.stabilizedTipPosition().getY());
  message.add(finger.stabilizedTipPosition().getZ());
  oscP5.send(message, host, sendPort);
}

void updateHands(){
 hand_position = new PVector(hand.stabilizedPalmPosition().getX(),
              finger.stabilizedTipPosition().getY());
}
