// stephen
// colision looks interesting could we discuss more about how it works so i can better understand. and comment it in the code
class Tank {
  // member variable
  float x, y, w, h;
  int speed = 2;
  boolean isColliding;
  int lives;
  int lastTopX = -1, lastBottomX = -1, lastLeftX = -1, lastRightX = -1;   
  int lastTopY = -1, lastBottomY = -1, lastLeftY = -1, lastRightY = -1;
  int tileU, tileB, tileR, tileL;
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
  void move(int dx, int dy) {for (int i = 0; i < speed; i++) {float nextX = x + dx;float nextY = y + dy;
                                                              collision(); 
                                                              if (tileU == 1 && nextY < y) {} 
                                                         else if (tileU == 2 && nextY < y) {}
                                                         else if (tileU == 3 && nextY < y) {}
                                                         else if (tileU == 4 && nextY < y) {}
                                                         else if (tileU == 5 && nextY < y) {}
                                                            else {x = nextX; y = nextY;}
                                                              
                                                            }
                                                           }
  void display() {image(playerImg,x,y, w,h); }
  
  void collision() {// the if statements here are simply for debugging use if the collisons are wrong
         // checks top of tank
           int topX = int(x) / TILE_SIZE; 
           int topY = int(y-30) / TILE_SIZE; 
           tileU = map.getTile(topX, topY);
         //if (topX != lastTopX || topY != -1) {if (lastTopX != -1) {map.setTile(lastTopX, lastTopY, 0);}map.setTile(topX, topY, 1); lastTopX = topX; lastTopY = topY;}
         
         // checks bottom
           int bottomX = int(x) / TILE_SIZE;
           int bottomY = int(y+30) / TILE_SIZE;
           tileB = map.getTile(bottomX, bottomY);
         //if (bottomX != lastBottomX || bottomY != -1) {if (lastBottomX != -1) {map.setTile(lastBottomX, lastBottomY, 0);}map.setTile(bottomX, bottomY, 1); lastBottomX = bottomX; lastBottomY = bottomY;}
         
         // checks left
           int leftX = int(x-30) / TILE_SIZE;
           int leftY = int(y) / TILE_SIZE;
           tileL = map.getTile(leftX, leftY);
         //if (leftX != lastLeftX || leftY != lastLeftY) {if (leftY != -1) {map.setTile(lastLeftX, lastLeftY, 0);}map.setTile(leftX, leftY, 1); lastLeftX = leftX; lastLeftY = leftY;}
         
         // checks right
           int rightX = int(x+30) / TILE_SIZE;
           int rightY = int(y) / TILE_SIZE;
           tileR = map.getTile(rightX, rightY);
         //if (rightX != lastRightX || rightY != lastRightY) {if (lastRightY != -1) {map.setTile(lastRightX, lastRightY, 0);}map.setTile(rightX, rightY, 1); lastRightX = rightX; lastRightY = rightY;}
         
                }
}
