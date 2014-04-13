void initSound(){

 sound1 = minim.loadFile("glassHit.mp3", 2048);
 //sound2 = minim.loadFile("glassHit.mp3", 2048);
 sound3 = minim.loadFile("gravelHit.mp3", 2048);
 //sound4 = minim.loadFile("hoverSelect.mp3", 2048);
 //sound5 = minim.loadFile("finalSelect.mp3", 2048);
 //sound6 = minim.loadFile("gameStart.mp3", 2048);
 //sound7 = minim.loadFile("gameWin.mp3", 2048);
 //sound8 = minim.loadFile("gameLose.mp3", 2048);
 
}

void playerHit(){
  
 sound1.play();

}

void AIHit(){

// sound2.play(); 


}

void gravelHit(){
  
  sound3.play(); 


}

void hover(){
  
 //sound4.play(); 

}

void finalSelect(){
 
 //sound5.play(); 

}

void gameStart(){
  
 //sound6.play(); 

}

void gameWin(){
  
// sound7.play(); 
}

void gameLose(){
  
  //sound8.play(); 
}




