// --- BATTLE CITY ENGINE (Main Tab) ---
// Bradley

final int MACRO_COLS = 13; final int MACRO_ROWS = 13;
final int GRID_ROWS = 26;  final int GRID_COLS = 26; 
final int TILE_SIZE = 16;  final int MACRO_SIZE = 32;

// Game States
final int STATE_START = 0;       final int STATE_MENU = 1;
final int STATE_MANUAL_PLAY = 2; final int STATE_QUICK_PLAY = 3;
final int STATE_PLAYING = 4;     final int STATE_VICTORY = 5;
final int STATE_SCORE = 6;       int gameState = STATE_START;

String selectedDifficulty = "Normal";
boolean cheatsEnabled = false;       boolean useRandomMap = false; // Default to pre-made levels

int currentLevel = 1;            int maxLevels = 10;
int enemiesRemainingToSpawn = 0; int spawnTimer = 0;int score = 0;

PImage brickImg;PImage metalImg;PImage grassImg;
      PImage waterImg;PImage eagleImg;

PImage enemyBasicImg;PImage enemyArmorImg;
PImage enemyPowerImg;PImage enemySpeedImg;

PImage playerImg;

// Tile Types
final int TILE_EMPTY = 0;  final int TILE_BRICK = 1;
final int TILE_STEEL = 2;  final int TILE_EAGLE = 3;
final int TILE_BUSH = 4;   final int TILE_WATER = 5;

boolean keyUp, keyDown, keyLeft, keyRight, keySpace;



void setup() {
  size(416, 416);
  frameRate(60);
  brickImg = loadImage("Brick.png");
  metalImg = loadImage("Metal.png");
  grassImg = loadImage("Grass.png");
  waterImg = loadImage("Water.png");
  eagleImg = loadImage("GoldenEagle.png");
  playerImg = loadImage("PlayerTank.png");
  enemyBasicImg = loadImage("EnemyBasicTank.png");
  
}

void draw() {
  background(0);
  switch (gameState) {
    case STATE_START:
      //startScreen.draw();
      break;
    case STATE_MENU:
      drawMainMenu();
      break;
    case STATE_MANUAL_PLAY:
      drawManualPlaySettings();
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

void keyPressed() {
  if (gameState == STATE_START) {
    if (key == ' ') gameState = STATE_MENU;
    return;
  }
  if (gameState == STATE_MENU) {
    if (key == '1') {
        // this is quick play but playing is not implemented yet
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
    return;
  }
}

