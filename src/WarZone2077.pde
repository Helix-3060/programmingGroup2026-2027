// --- BATTLE CITY ENGIINE TEST ---

// maap grid config in 13 x 13
final int GRID_COLS = 13;
final int GRID_ROWS = 13;
final int TILE_SIZE = 32; // 13 * 32 = 416px display field

// tile types
final int TILE_EMPTY = 0;
final int TILE_BRICK = 1;
final int TILE_STEEL = 2;
final int TILE_EAGLE = 3;

int[][] map = new int[GRID_ROWS][GRID_COLS];

// game objects
Tank player;
ArrayList<Bullet> bullets = new ArrayList<Bullet>();

// imput reading
boolean keyUp, keyDown, keyLeft, keyRight, keySpace;

void setup() {
  size(416, 416); // Match 13x13 grid exactly (13 * 32)
  frameRate(60);
  
  // start map layout
  initMap();
  
  // spawn player 
  player = new Tank(4 * TILE_SIZE, 12 * TILE_SIZE);
}

void draw() {
  background(0); // Classic pitch-black background
  
  // 1. Update game stste
  player.update();
  updateBullets();

  //render world
  drawMap();
  player.draw();
  drawBullets();
}

// map render
void initMap() {
  // Clear map
  for (int r = 0; r < GRID_ROWS; r++) {
    for (int c = 0; c < GRID_COLS; c++) {
      map[r][c] = TILE_EMPTY;
    }
  }
  
  // Sample walls
  for (int r = 1; r < 10; r += 2) {
    map[r][1] = TILE_BRICK; map[r][2] = TILE_BRICK;
    map[r][4] = TILE_BRICK; map[r][5] = TILE_BRICK;
    map[r][7] = TILE_BRICK; map[r][8] = TILE_BRICK;
    map[r][10] = TILE_BRICK; map[r][11] = TILE_BRICK;
  }
  
  // Steel wall
  map[6][6] = TILE_STEEL;
  
  // eagle
  map[12][6] = TILE_EAGLE;
  map[12][5] = TILE_BRICK;
  map[11][5] = TILE_BRICK;
  map[11][6] = TILE_BRICK;
  map[11][7] = TILE_BRICK;
  map[12][7] = TILE_BRICK;
}

void drawMap() {
  for (int r = 0; r < GRID_ROWS; r++) {
    for (int c = 0; c < GRID_COLS; c++) {
      int x = c * TILE_SIZE;
      int y = r * TILE_SIZE;
      
      switch (map[r][c]) {
        case TILE_BRICK:
          fill(212, 80, 0); // Brick Orange/Brown
          stroke(0);
          rect(x, y, TILE_SIZE, TILE_SIZE);
          // Simple inner brick pattern lines
          stroke(140, 40, 0);
          line(x, y + 16, x + 32, y + 16);
          line(x + 16, y, x + 16, y + 16);
          line(x + 8, y + 16, x + 8, y + 32);
          break;
          
        case TILE_STEEL:
          fill(192); // Steel Gray
          stroke(255);
          rect(x, y, TILE_SIZE, TILE_SIZE);
          fill(255);
          rect(x + 6, y + 6, 8, 8);
          rect(x + 18, y + 18, 8, 8);
          break;
          
        case TILE_EAGLE:
          fill(255, 215, 0); // Eagle Gold
          noStroke();
          triangle(x + 16, y + 4, x + 4, y + 28, x + 28, y + 28);
          break;
      }
    }
  }
}

// tank
class Tank {
  float x, y;
  float speed = 2.0;
  int dir = 0; // 0: Up, 1: Right, 2: Down, 3: Left
  int cooldown = 0;
  
  Tank(float startX, float startY) {
    x = startX;
    y = startY;
  }
  
  void update() {
    float nextX = x;
    float nextY = y;
    
    if (keyUp) { dir = 0; nextY -= speed; }
    else if (keyRight) { dir = 1; nextX += speed; }
    else if (keyDown) { dir = 2; nextY += speed; }
    else if (keyLeft) { dir = 3; nextX -= speed; }
    
    // Check collisin
    if (!collidesWithMap(nextX, nextY)) {
      x = constrain(nextX, 0, width - TILE_SIZE);
      y = constrain(nextY, 0, height - TILE_SIZE);
    }
    
    // Firing 
    if (cooldown > 0) cooldown--;
    if (keySpace && cooldown == 0) {
      shoot();
      cooldown = 20; // Fire rate limit
    }
  }
  
  boolean collidesWithMap(float newX, float newY) {
    // Check all four corners of the tank bounding box
    int leftTile   = int(newX / TILE_SIZE);
    int rightTile  = int((newX + TILE_SIZE - 1) / TILE_SIZE);
    int topTile    = int(newY / TILE_SIZE);
    int bottomTile = int((newY + TILE_SIZE - 1) / TILE_SIZE);
    
    // Prevent array out-of-bounds checks
    if (leftTile < 0 || rightTile >= GRID_COLS || topTile < 0 || bottomTile >= GRID_ROWS) return true;
    
    // Check if any covered tile is solid
    for (int r = topTile; r <= bottomTile; r++) {
      for (int c = leftTile; c <= rightTile; c++) {
        if (map[r][c] != TILE_EMPTY) return true;
      }
    }
    return false;
  }
  
  void shoot() {
    float bulletX = x + TILE_SIZE / 2.0 - 2;
    float bulletY = y + TILE_SIZE / 2.0 - 2;
    bullets.add(new Bullet(bulletX, bulletY, dir));
  }
  
  void draw() {
    pushMatrix();
    translate(x + TILE_SIZE / 2.0, y + TILE_SIZE / 2.0);
    rotate(dir * HALF_PI); // Rotate matrix according to direction
    
    // tank body
    fill(255, 204, 0); // Classic P1 Yellow
    noStroke();
    rect(-14, -14, 28, 28);
    
    // tread
    fill(80);
    rect(-16, -16, 6, 32);
    rect(10, -16, 6, 32);
    
    // Cannon barrel
    fill(0);
    rect(-3, -16, 6, 12);
    
    popMatrix();
  }
}

// bullet systemm
class Bullet {
  float x, y;
  float speed = 6.0;
  int dir;
  boolean active = true;
  
  Bullet(float startX, float startY, int d) {
    x = startX;
    y = startY;
    dir = d;
  }
  
  void update() {
    switch (dir) {
      case 0: y -= speed; break;
      case 1: x += speed; break;
      case 2: y += speed; break;
      case 3: x -= speed; break;
    }
    
    // beyond screen checking
    if (x < 0 || x > width || y < 0 || y > height) {
      active = false;
      return;
    }
    
    // Map Collistion
    int col = int((x + 2) / TILE_SIZE);
    int row = int((y + 2) / TILE_SIZE);
    
    if (row >= 0 && row < GRID_ROWS && col >= 0 && col < GRID_COLS) {
      int tile = map[row][col];
      
      if (tile == TILE_BRICK) {
        map[row][col] = TILE_EMPTY; // Destroy brick
        active = false;
      } else if (tile == TILE_STEEL) {
        active = false; // Steel resists normal bullets
      } else if (tile == TILE_EAGLE) {
        map[row][col] = TILE_EMPTY; // Base destroyed
        active = false;
      }
    }
  }
  
  void draw() {
    fill(255, 255, 200);
    noStroke();
    ellipse(x + 2, y + 2, 6, 6);
  }
}

void updateBullets() {
  for (int i = bullets.size() - 1; i >= 0; i--) {
    Bullet b = bullets.get(i);
    b.update();
    if (!b.active) {
      bullets.remove(i);
    }
  }
}

void drawBullets() {
  for (Bullet b : bullets) {
    b.draw();
  }
}

// --- KEYBOARD CONTROLLER ---
void keyPressed() {
  if (keyCode == UP    || key == 'w' || key == 'W') keyUp = true;
  if (keyCode == DOWN  || key == 's' || key == 'S') keyDown = true;
  if (keyCode == LEFT  || key == 'a' || key == 'A') keyLeft = true;
  if (keyCode == RIGHT || key == 'd' || key == 'D') keyRight = true;
  if (key == ' ') keySpace = true;
}

void keyReleased() {
  if (keyCode == UP    || key == 'w' || key == 'W') keyUp = false;
  if (keyCode == DOWN  || key == 's' || key == 'S') keyDown = false;
  if (keyCode == LEFT  || key == 'a' || key == 'A') keyLeft = false;
  if (keyCode == RIGHT || key == 'd' || key == 'D') keyRight = false;
  if (key == ' ') keySpace = false;
}
