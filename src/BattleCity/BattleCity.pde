// --- BATTLE CITY ENGINE (Main Tab) ---
// Bradley


final int GRID_ROWS = 15;  final int GRID_COLS = 15; 
            final int TILE_SIZE = 30; 
            
//Tank[] nums = new Tank[32];

// Game States

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


boolean keyUp, keyDown, keyLeft, keyRight, keySpace;
Tank player;
GameMap map;

void setup() {
  size(453, 453);
  frameRate(60);
  background(0);
  brickImg = loadImage("Brick.png");
  metalImg = loadImage("Metal.png");
  grassImg = loadImage("Grass.png");
  waterImg = loadImage("Water.png");
  eagleImg = loadImage("GoldenEagle.png");
  playerImg = loadImage("PlayerTank.png");
  enemyBasicImg = loadImage("EnemyBasicTank.png");
  
  map = new GameMap();
  player = new Tank(3* TILE_SIZE, 3* TILE_SIZE, false);
  /*
  map.setTile(2, 5, 0);
  map.setTile(2, 6, 1);
  map.setTile(2, 7, 2);
  map.setTile(2, 8, 3);
  map.setTile(2, 9, 4);
  map.setTile(2, 10, 5);*/
}

void draw() {
   map.display();
   //for (int i=0; i<32; i++) {nums[i] = new Tank(0+i*16,0+i*16,false); nums[i].display();}
   player.update();
   player.display();
   
}

void keyPressed() {
  if (keyCode == UP) {keyUp = true;}
  if (keyCode == DOWN) {keyDown = true;}
  if (keyCode == LEFT) {keyLeft = true;}
  if (keyCode == RIGHT) {keyRight = true;}
}

void keyReleased() {
  if (keyCode == UP)    keyUp = false;
  if (keyCode == DOWN)  keyDown = false;
  if (keyCode == LEFT)  keyLeft = false;
  if (keyCode == RIGHT) keyRight = false;
}
