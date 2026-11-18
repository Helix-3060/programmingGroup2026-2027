//stephen

import processing.video.*;
Movie myMovie;

void setup() {
  myMovie = new Movie(this, "totoro.mov");
  myMovie.loop();
}
// on the code refence in prossesing.org it says we can use .mp4 and .mov but it says .mov loads faster and smoother.
// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}
