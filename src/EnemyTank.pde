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
    if (dirTimer > 90 || collidesWithMap(futureX(), futureY())) {
      dir = int(random(4));
      dirTimer = 0;
    }
    
    switch (dir) {
      case 0: nextY -= speed; break;
      case 1: nextX += speed; break;
      case 2: nextY += speed; break;
      case 3: nextX -= speed; break;
    }
    
    if (!collidesWithMap(nextX, nextY)) {
      x = constrain(nextX, 0, width - TILE_SIZE);
      y = constrain(nextY, 0, height - TILE_SIZE);
    } else {
      dir = int(random(4));
    }
    
    cooldown++;
    if (cooldown > 60) {
      shoot();
      cooldown = 0;
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
    int leftTile   = int(newX / TILE_SIZE);
    int rightTile  = int((newX + TILE_SIZE - 1) / TILE_SIZE);
    int topTile    = int(newY / TILE_SIZE);
    int bottomTile = int((newY + TILE_SIZE - 1) / TILE_SIZE);
    
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
    float bulletX = x + TILE_SIZE / 2.0 - 2;
    float bulletY = y + TILE_SIZE / 2.0 - 2;
    bullets.add(new Bullet(bulletX, bulletY, dir, true));
  }
  
  void draw() {
    pushMatrix();
    translate(x + TILE_SIZE / 2.0, y + TILE_SIZE / 2.0);
    rotate(dir * HALF_PI);
    
    noStroke();
    fill(80, 80, 80);
    rect(-16, -16, 6, 32);
    rect(10, -16, 6, 32);
    
    fill(200, 50, 50);
    rect(-10, -14, 20, 28);
    
    fill(30, 30, 30);
    rect(-3, -18, 6, 14);
    
    popMatrix();
  }
}
