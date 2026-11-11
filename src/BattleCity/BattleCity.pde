// --- BATTLE CITY ENGINE (Main Tab) ---

final int MACRO_COLS = 13;
final int MACRO_ROWS = 13;
final int GRID_COLS = 26; 
final int GRID_ROWS = 26;
final int TILE_SIZE = 16; 
final int MACRO_SIZE = 32;

// Game States
final int STATE_START = 0;
final int STATE_MENU = 1;
final int STATE_MANUAL_PLAY = 2;
final int STATE_QUICK_PLAY = 3;
final int STATE_PLAYING = 4;
final int STATE_VICTORY = 5;
final int STATE_SCORE = 6;
int gameState = STATE_START;

String selectedDifficulty = "Normal";
boolean cheatsEnabled = false;
boolean useRandomMap = false; // defalt to made levels

int currentLevel = 1;
int maxLevels = 10;
int enemiesRemainingToSpawn = 0;
int spawnTimer = 0;
int score = 0;

// Tile Types
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
}

void draw() {
  background(0);
  
  switch (gameState) {
    case STATE_START:
      startScreen.draw();
      break;
    case STATE_MENU:
      drawMainMenu();
      break;
    case STATE_MANUAL_PLAY:
      drawManualPlaySettings();
      break;
    case STATE_QUICK_PLAY:
      currentLevel = 1;
      score = 0;
      initGameSession();
      gameState = STATE_PLAYING;
      break;
    case STATE_PLAYING:
      // Spawner logic: keep up to 4 enemies active at once until wave is cleared
      spawnTimer++;
      if (enemies.size() < 4 && enemiesRemainingToSpawn > 0 && spawnTimer > 90) {
        spawnEnemyWave();
        spawnTimer = 0;
      }
      
      // Check level completion
      if (enemies.size() == 0 && enemiesRemainingToSpawn == 0) {
        currentLevel++;
        if (currentLevel > maxLevels) {
          gameState = STATE_VICTORY;
        } else {
          initGameSession();
        }
      }
      
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
      
      // HUD Overlay
      fill(255);
      textSize(12);
      text("LEVEL: " + currentLevel + "/" + maxLevels, 50, 15);
      text("SCORE: " + score, 360, 15);
      break;
      
    case STATE_VICTORY:
      drawVictoryScreen();
      break;
      
    case STATE_SCORE:
      drawScoreScreen();
      break;
  }
}

void drawMainMenu() {
  textAlign(CENTER, CENTER);
  fill(255, 230, 0);
  textSize(28);
  text("MAIN MENU", width / 2, 80);
  
  textSize(16);
  fill(255);
  text("[ 1 ] Quick Play (Campaign)", width / 2, 170);
  text("[ 2 ] Manual Play & Settings", width / 2, 220);
  
  fill(150);
  textSize(12);
  text("Press 1 or 2 to select", width / 2, 350);
}

void drawManualPlaySettings() {
  textAlign(CENTER, CENTER);
  fill(255, 230, 0);
  textSize(24);
  text("LEVEL SETTINGS", width / 2, 50);
  
  textSize(14);
  fill(255);
  text("Difficulty (D): " + selectedDifficulty, width / 2, 130);
  text("Cheats (C): " + (cheatsEnabled ? "ON" : "OFF"), width / 2, 170);
  text("Map Mode (M): " + (useRandomMap ? "Random Generator" : "Campaign Levels"), width / 2, 210);
  
  fill(255, 100, 100);
  text("Press ENTER to Launch", width / 2, 320);
  
  fill(150);
  textSize(11);
  text("Controls: [D] Diff | [C] Cheat | [M] Map", width / 2, 370);
}

void drawVictoryScreen() {
  textAlign(CENTER, CENTER);
  fill(0, 255, 100);
  textSize(32);
  text("CAMPAIGN VICTORY!", width / 2, 120);
  
  fill(255);
  textSize(18);
  text("All 10 Bases Defended Successfully!", width / 2, 180);
  text("Final Score: " + score, width / 2, 220);
  
  fill(255, 230, 0);
  textSize(14);
  text("PRESS SPACE TO RETURN TO MENU", width / 2, 320);
}

void drawScoreScreen() {
  textAlign(CENTER, CENTER);
  fill(255, 50, 50);
  textSize(32);
  text("GAME OVER", width / 2, 120);
  
  fill(255);
  textSize(18);
  text("Base Destroyed at Level " + currentLevel, width / 2, 180);
  text("Final Score: " + score, width / 2, 220);
  
  fill(255, 230, 0);
  textSize(14);
  text("PRESS SPACE TO RETURN TO MENU", width / 2, 320);
}

void initGameSession() {
  if (useRandomMap) {
    map.generateRandom();
  } else {
    map.loadLevel(currentLevel);
  }
  
  player = new Tank(4 * MACRO_SIZE, 12 * MACRO_SIZE, false);
  enemies.clear();
  
  // Scale enemy count based on level
  enemiesRemainingToSpawn = 4 + (currentLevel * 2); 
  spawnEnemyWave();
}

void spawnEnemyWave() {
  if (enemiesRemainingToSpawn <= 0) return;
  
  // Spawn at top-left, top-center, or top-right
  float[] spawnX = {1 * MACRO_SIZE, 6 * MACRO_SIZE, 11 * MACRO_SIZE};
  float sx = spawnX[int(random(spawnX.length))];
  
  enemies.add(new EnemyTank(sx, 0));
  enemiesRemainingToSpawn--;
}

void keyPressed() {
  if (gameState == STATE_START) {
    if (key == ' ') gameState = STATE_MENU;
    return;
  }
  if (gameState == STATE_MENU) {
    if (key == '1') {
      currentLevel = 1;
      score = 0;
      initGameSession();
      gameState = STATE_PLAYING;
    }
    if (key == '2') gameState = STATE_MANUAL_PLAY;
    return;
  }
  if (gameState == STATE_MANUAL_PLAY) {
    if (key == 'd' || key == 'D') {
      if (selectedDifficulty.equals("Easy")) selectedDifficulty = "Normal";
      else if (selectedDifficulty.equals("Normal")) selectedDifficulty = "Hard";
      else selectedDifficulty = "Easy";
    }
    if (key == 'c' || key == 'C') cheatsEnabled = !cheatsEnabled;
    if (key == 'm' || key == 'M') useRandomMap = !useRandomMap;
    if (keyCode == RETURN || keyCode == ENTER) {
      currentLevel = 1;
      score = 0;
      initGameSession();
      gameState = STATE_PLAYING;
    }
    return;
  }
  if (gameState == STATE_SCORE || gameState == STATE_VICTORY) {
    if (key == ' ') gameState = STATE_START;
    return;
  }

  if (gameState == STATE_PLAYING) {
    if (keyCode == UP    || key == 'w' || key == 'W') keyUp = true;
    if (keyCode == DOWN  || key == 's' || key == 'S') keyDown = true;
    if (keyCode == LEFT  || key == 'a' || key == 'A') keyLeft = true;
    if (keyCode == RIGHT || key == 'd' || key == 'D') keyRight = true;
    if (key == ' ') keySpace = true;
  }
}

void keyReleased() {
  if (gameState == STATE_PLAYING) {
    if (keyCode == UP    || key == 'w' || key == 'W') keyUp = false;
    if (keyCode == DOWN  || key == 's' || key == 'S') keyDown = false;
    if (keyCode == LEFT  || key == 'a' || key == 'A') keyLeft = false;
    if (keyCode == RIGHT || key == 'd' || key == 'D') keyRight = false;
    if (key == ' ') keySpace = false;
  }
}
