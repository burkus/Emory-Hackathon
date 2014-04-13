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
