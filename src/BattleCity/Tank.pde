// stephen
class Tank {
  // member variable
  float x, y, w, h;
  int speed = 2;
  boolean isColliding;
  int lives;
  // constructor
  Tank(float x, float y, boolean isColliding) {
    this.x = x;
    this.y = y;
    w = 26;
    h = 26;
    this.isColliding = isColliding;
  }
  void update() {int dx = 0, dy = 0; if (keyUp) {dy -= 1;} if (keyDown) {dy += 1;} if (keyLeft) {dx -= 1;} if (keyRight) {dx += 1;} move(dx, dy);}
  // Member Methods: behaviors of the buttons
  void move(int dx, int dy) {for (int i = 0; i < speed; i++) {float nextX = x + dx;float nextY = y + dy; x = nextX; y = nextY;}}
  void display() {image(playerImg,x,y, w,h);}
  
}
