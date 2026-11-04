//Rebecca Jackson

class Obstacle {
  // Member variables
  int x,y,w,h;
  color c1;
  OImage p1;

  // Constructor
  Obstacle() {
    x = 50;
    y = 50;
    w = 50;
    h = 50;
    c1 = color(128);
    p1 = loadImage("");

  }

  //Member Methods
  void display() {
    //TODO: add image and remove rect
    //image(p1,x,y);
    fill(c1);
    rect(x,y,w,h);
  }
  void move(char dir) {}
  void jump() {}
  void fire() {}
  void attack() {}
  

}
