// Bradley Nieto
class GameMap {
  // member variable
  int[][] grid;
  int cellSize = TILE_SIZE;
  // constructor
  GameMap() {grid = new int[GRID_ROWS][GRID_COLS];}
  
  // Member Methods: behaviors of the buttons
  // easy way to place objects
  void setTile(int col, int row, int tileType) {
    // checks only in the boundaries of the map
    if (col >= 0 && col < GRID_COLS && row >=0 && row < GRID_ROWS) {
      grid[row][col] = tileType;
    }
  }
  
  void display() {
    for (int r = 0; r < grid.length; r++) {for (int c = 0; c < grid.length; c++) {
      for (int i = 0; i < 5; r++) {if (grid[r][c] == i) {} else {fill(255);}}
      
      setTile(1, 4, 1);
      rect(c * cellSize, r * cellSize, cellSize, cellSize);
    }}
  }
  
}
