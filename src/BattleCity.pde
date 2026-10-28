final int GRID_COLS = 13;
final int GRID_ROWS = 13;
final int TILE_SIZE = 32;

final int STATE_START = 0;
final int STATE_PLAYING = 1;
int gameState = STATE_START;

final int TILE_EMPTY = 0;
final int TILE_BRICK = 1;
final int TILE_STEEL = 2;
final int TILE_EAGLE = 3;
final int TILE_BUSH = 4;
final int TILE_WATER = 5;

GameMap map;
Tank player;
ArrayList<EnemyTank> enemies = new ArrayList<EnemyTank>();
EntityManager bullets;
StartScreen startScreen;

boolean keyUp, keyDown, keyLeft, keyRight, keySpace;

void setup() {
  size(416, 416);
  frameRate(60);
  
  map = new GameMap();
  bullets = new EntityManager();
  startScreen = new StartScreen();
  
  player = new Tank(4 * TILE_SIZE, 12 * TILE_SIZE, false);
  
  enemies.add(new EnemyTank(1 * TILE_SIZE, 0));
  enemies.add(new EnemyTank(11 * TILE_SIZE, 0));
}

void draw() {
  background(0);
  
  switch (gameState) {
    case STATE_START:
      startScreen.draw();
      break;
    case STATE_PLAYING:
      player.update();
      for (int i = enemies.size() - 1; i >= 0; i--) {
        EnemyTank e = enemies.get(i);
        e.update();
      }
      bullets.update();
      
      map.drawBase();
      player.draw();
      for (EnemyTank e : enemies) {
        e.draw();
      }
      map.drawOverlays();
      bullets.draw();
      break;
  }
}

void keyPressed() {
  if (gameState == STATE_START) {
    if (key == ' ') {
      gameState = STATE_PLAYING;
    }
    return;
  }

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
