class EnemyTank {
  float x, y;
  float speed = 1.5;
  int dir = 2;
  int dirTimer = 0;
  int cooldown = 0;
  
  EnemyTank(float startX, float startY) {
    x = startX;
    y = startY;
  }
  
  void update() {
    float nextX = x;
    float nextY = y;
    
    dirTimer++;
    // AI Decision: Every 60 frames or upon wall collision, bias towards the Eagle base (bottom-center)
    if (dirTimer > 60 || collidesWithMap(futureX(), futureY())) {
      chooseTacticalDirection();
      dirTimer = 0;
    }
    
    switch (dir) {
      case 0: nextY -= speed; break;
      case 1: nextX += speed; break;
      case 2: nextY += speed; break;
      case 3: nextX -= speed; break;
    }
    
    if (!collidesWithMap(nextX, nextY)) {
      x = constrain(nextX, 0, width - 26);
      y = constrain(nextY, 0, height - 26);
    } else {
      chooseTacticalDirection();
    }
    
    // Aggressive automatic firing toward base/player
    cooldown++;
    if (cooldown > 45) {
      shoot();
      cooldown = 0;
    }
  }
  
  void chooseTacticalDirection() {
    // Eagle is around x = 208 (center), y = 384 (bottom)
    float targetX = 208;
    float targetY = 384;
    
    float dx = targetX - x;
    float dy = targetY - y;
    
    // Higher chance to move towards the Eagle base vertically or horizontally
    if (abs(dy) > abs(dx)) {
      dir = (dy > 0) ? 2 : 0; // Down or Up
    } else {
      dir = (dx > 0) ? 1 : 3; // Right or Left
    }
    
    // Add some tactical randomness so they don't get permanently stuck
    if (random(1.0) < 0.3) {
      dir = int(random(4));
    }
  }
  
  float futureX() {
    float nx = x;
    if (dir == 1) nx += speed;
    if (dir == 3) nx -= speed;
    return nx;
  }
  
  float futureY() {
    float ny = y;
    if (dir == 0) ny -= speed;
    if (dir == 2) ny += speed;
    return ny;
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
    bullets.add(new Bullet(bulletX, bulletY, dir, true));
  }
  
  void draw() {
    pushMatrix();
    translate(x + 13, y + 13);
    rotate(dir * HALF_PI);
    
    noStroke();
    fill(80, 80, 80);
    rect(-13, -13, 5, 26);
    rect(8, -13, 5, 26);
    
    fill(200, 50, 50);
    rect(-8, -11, 16, 22);
    
    fill(30, 30, 30);
    rect(-2, -15, 4, 12);
    
    popMatrix();
  }
}
