// --- BATTLE CITY ENGINE (Main Tab) ---
// Bradley

final int MACRO_COLS = 16; final int MACRO_ROWS = 16;
final int GRID_ROWS = 16;  final int GRID_COLS = 16; 
            final int TILE_SIZE = 32; 
            
//Tank[] nums = new Tank[32];

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

GameMap map;

void setup() {
  size(516, 516);
  frameRate(60);
  brickImg = loadImage("Brick.png");
  metalImg = loadImage("Metal.png");
  grassImg = loadImage("Grass.png");
  waterImg = loadImage("Water.png");
  eagleImg = loadImage("GoldenEagle.png");
  playerImg = loadImage("PlayerTank.png");
  enemyBasicImg = loadImage("EnemyBasicTank.png");
  map = new GameMap();
}

void draw() {
   //for (int i=0; i<32; i++) {nums[i] = new Tank(0+i*16,0+i*16,false); nums[i].display();}
   map.display();
}
