//stephen
class Music {
  int currentSong = 0;
}

Music() {
  
}

void display(int id) {
  currentSong = id;

  if (id == 1) {
        song1();
      } else if (id == 2) {
        song2();
      }
}
