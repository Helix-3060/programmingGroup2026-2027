//stephen
//this came from the refenceing site, still have no idea how this works i need to resaerch more but i need to focas on other classes right now.
import processing.video.*;
Movie myMovie;

void setup() {
  myMovie = new Movie(this, "totoro.mov");
  myMovie.loop();
}
// on the code refence in prossesing.org it says we can use .mp4 and .mov but it says .mov loads faster and smoother.
void movieEvent(Movie m) {
  m.read();
}
