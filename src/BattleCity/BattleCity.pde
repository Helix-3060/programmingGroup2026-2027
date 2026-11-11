// --- BATTLE CITY ENGINE (Main Tab) ---

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
final int TILE_EMPTY = 0;
final int TILE_BRICK = 1;
final int TILE_STEEL = 2;
final int TILE_EAGLE = 3;
final int TILE_BUSH = 4;
final int TILE_WATER = 5;

// lucas

void setup() {
  size(640, 640);
}

void draw() {
  background(0);
}


