class Bullet {
  float x, y;
  float speed = 6.0;
  int dir;
  boolean isEnemyBullet;
  boolean active = true;
  
  Bullet(float startX, float startY, int d, boolean enemyBullet) {
    x = startX;
    y = startY;
    dir = d;
    isEnemyBullet = enemyBullet;
  }
  
  void update() {
    switch (dir) {
      case 0: y -= speed; break;
      case 1: x += speed; break;
      case 2: y += speed; break;
      case 3: x -= speed; break;
    }
    
    if (x < 0 || x > width || y < 0 || y > height) {
      active = false;
      return;
    }
    
    if (isEnemyBullet) {
      if (x >= player.x && x <= player.x + TILE_SIZE && y >= player.y && y <= player.y + TILE_SIZE) {
        player.x = 4 * TILE_SIZE;
        player.y = 12 * TILE_SIZE;
        active = false;
        return;
      }
    } else {
      for (int i = enemies.size() - 1; i >= 0; i--) {
        EnemyTank e = enemies.get(i);
        if (x >= e.x && x <= e.x + TILE_SIZE && y >= e.y && y <= e.y + TILE_SIZE) {
          enemies.remove(i);
          active = false;
          return;
        }
      }
    }
    
    int col = int((x + 2) / TILE_SIZE);
    int row = int((y + 2) / TILE_SIZE);
    
    if (row >= 0 && row < GRID_ROWS && col >= 0 && col < GRID_COLS) {
      int tile = map.grid[row][col];
      
      if (tile == TILE_BRICK) {
        map.grid[row][col] = TILE_EMPTY;
        active = false;
      } else if (tile == TILE_STEEL || tile == TILE_WATER) {
        active = false;
      } else if (tile == TILE_BUSH) {
        map.burnBushAndNeighbors(row, col);
        active = false;
      } else if (tile == TILE_EAGLE) {
        map.grid[row][col] = TILE_EMPTY;
        active = false;
      }
    }
  }
  
  void draw() {
    fill(255, 255, 255);
    noStroke();
    ellipse(x + 2, y + 2, 6, 6);
  }
}

class EntityManager {
  ArrayList<Bullet> list = new ArrayList<Bullet>();
  
  void add(Bullet b) {
    list.add(b);
  }
  
  void update() {
    for (int i = list.size() - 1; i >= 0; i--) {
      Bullet b = list.get(i);
      b.update();
      if (!b.active) {
        list.remove(i);
      }
    }
  }
  
  void draw() {
    for (Bullet b : list) {
      b.draw();
    }
  }
}
