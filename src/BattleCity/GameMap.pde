// Bradley Nieto
class GameMap {
  
  // member variable
  int tileType;
  final int TILE_EMPTY = 0;  final int TILE_BRICK = 1;
  final int TILE_STEEL = 2;  final int TILE_EAGLE = 3;
  final int TILE_BUSH = 4;   final int TILE_WATER = 5;
  
  int[][] grid;
  int cellSize = TILE_SIZE;
  // constructor
  GameMap() {grid = new int[GRID_ROWS][GRID_COLS];}
  
  void setTile(int col, int row, int tileType) {
    // checks only in the boundaries of the map
    if (col >= 0 && col < GRID_COLS && row >=0 && row < GRID_ROWS) {
      grid[row-1][col] = tileType;
    }
  }
  void display() {
    for (int r = 0; r < grid.length; r++) {for (int c = 0; c < grid.length; c++) {
      //noStroke();
      if (grid[r][c] == 0) {fill(255); rect(c * cellSize, r * cellSize, cellSize, cellSize);}  /* empty tile */ if (grid[r][c] == 1) {image(brickImg, c * cellSize, r * cellSize, cellSize, cellSize);}  /* brick tile */
      if (grid[r][c] == 2) {image(metalImg, c * cellSize, r * cellSize, cellSize, cellSize);}  /* steel tile */ if (grid[r][c] == 3) {image(eagleImg, c * cellSize, r * cellSize, cellSize, cellSize);}  /* eagle tile */
      if (grid[r][c] == 4) {image(grassImg, c * cellSize, r * cellSize, cellSize, cellSize);}  /* tile bush */  if (grid[r][c] == 5) {image(waterImg, c * cellSize, r * cellSize, cellSize, cellSize);}  /* tile water */}}
  }
  
  void getTile(int x, int y) {if (grid[y][x] == 1) {println("brick at ", x, "," ,y); tileType = TILE_BRICK;}}

  
}
