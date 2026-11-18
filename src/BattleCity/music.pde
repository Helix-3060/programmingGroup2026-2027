//stephen
import processing.sound.*;

class music {
  int CSong = 0;
 SoundFile song1;
 SoundFile song2;
}

Music(int id) {
  
}
void display(int id) {
  CSong = id;

  if (id == 1) {
        song1();
      } else if (id == 2) {
        song2();
      }


  //note to dev team, need to ask Mr k on how to set tthis up the refences arent helping much...
  //also fyi "CSong" is short for "Current song", and if we want another track copy paste the else if and incesue "id == (the number) by onee.
  file = new SoundFile(this, "sample.mp3");
  file.play();
} 
