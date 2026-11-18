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
      if (grid[r][c] == 0) {fill(255); rect(c * cellSize, r * cellSize, cellSize, cellSize); tileType=0;} // stuff
      if (grid[r][c] == 1) {image(brickImg, c * cellSize, r * cellSize, cellSize, cellSize); tileType=1;}  // stuff
      if (grid[r][c] == 2) {image(metalImg, c * cellSize, r * cellSize, cellSize, cellSize); tileType=2;}  // stuff
      if (grid[r][c] == 3) {image(eagleImg, c * cellSize, r * cellSize, cellSize, cellSize); tileType=3;}  // stuff
      if (grid[r][c] == 4) {image(grassImg, c * cellSize, r * cellSize, cellSize, cellSize); tileType=4;}  // stuff
      if (grid[r][c] == 5) {image(waterImg, c * cellSize, r * cellSize, cellSize, cellSize); tileType=5;}  // stuff
    }}
    
  }

  
}
