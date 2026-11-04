class Tank {
  float x, y;
  float speed = 2.0;
  int dir = 0; 
  int cooldown = 0;
  boolean isEnemy;
  
  Tank(float startX, float startY, boolean enemy) {
    x = startX;
    y = startY;
    isEnemy = enemy;
  }
  
  void update() {
    float nextX = x;
    float nextY = y;
    
    if (keyUp) { dir = 0; nextY -= speed; }
    else if (keyRight) { dir = 1; nextX += speed; }
    else if (keyDown) { dir = 2; nextY += speed; }
    else if (keyLeft) { dir = 3; nextX -= speed; }
    
    if (!collidesWithMap(nextX, nextY)) {
      x = constrain(nextX, 0, width - 26);
      y = constrain(nextY, 0, height - 26);
    }
    
    if (cooldown > 0) cooldown--;
    if (keySpace && cooldown == 0) {
      shoot();
      cooldown = 20;
    }
  }
  
  boolean collidesWithMap(float newX, float newY) {
    int tankWidth = 26;
    int tankHeight = 26;
    
    int leftTile   = int(newX / TILE_SIZE);
    int rightTile  = int((newX + tankWidth - 1) / TILE_SIZE);
    int topTile    = int(newY / TILE_SIZE);
    int bottomTile = int((newY + tankHeight - 1) / TILE_SIZE);
    
    if (leftTile < 0 || rightTile >= GRID_COLS || topTile < 0 || bottomTile >= GRID_ROWS) return true;
    
    for (int r = topTile; r <= bottomTile; r++) {
      for (int c = leftTile; c <= rightTile; c++) {
        int tile = map.grid[r][c];
        if (tile != TILE_EMPTY && tile != TILE_BUSH) return true;
      }
    }
    return false;
  }
  
  void shoot() {
    float bulletX = x + 13 - 2;
    float bulletY = y + 13 - 2;
    bullets.add(new Bullet(bulletX, bulletY, dir, isEnemy));
  }
  
  void draw() {
    pushMatrix();
    translate(x + 13, y + 13);
    rotate(dir * HALF_PI);
    
    noStroke();
    fill(100, 100, 100);
    rect(-13, -13, 5, 26);
    rect(8, -13, 5, 26);
    
    fill(255, 230, 0);
    rect(-8, -11, 16, 22);
    
    fill(50, 50, 50);
    rect(-2, -15, 4, 12);
    
    popMatrix();
  }
}
