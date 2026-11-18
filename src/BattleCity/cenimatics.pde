//stephen

import processing.video.*;
Movie myMovie;

void setup() {
  size(200, 200);
  myMovie = new Movie(this, "totoro.mov");
  myMovie.loop();
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}
