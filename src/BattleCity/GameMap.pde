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
      grid[row-1][col-1] = tileType;
    }
  }
  
  void display() {
    for (int r = 0; r < grid.length; r++) {for (int c = 0; c < grid.length; c++) {
      //noStroke();
      if (grid[r][c] == 0) {fill(255); rect(c * cellSize, r * cellSize, cellSize, cellSize);} // stuff
      if (grid[r][c] == 1) {image(brickImg, c * cellSize, r * cellSize, cellSize, cellSize);}  // stuff
      if (grid[r][c] == 2) {image(metalImg, c * cellSize, r * cellSize, cellSize, cellSize);}  // stuff
      if (grid[r][c] == 3) {image(eagleImg, c * cellSize, r * cellSize, cellSize, cellSize);}  // stuff
      if (grid[r][c] == 4) {image(grassImg, c * cellSize, r * cellSize, cellSize, cellSize);}  // stuff
      if (grid[r][c] == 5) {image(waterImg, c * cellSize, r * cellSize, cellSize, cellSize);}  // stuff
      
      

      setTile(2, 5, 0);
      setTile(2, 6, 1);
      setTile(2, 7, 2);
      setTile(2, 8, 3);
      setTile(2, 9, 4);
      setTile(2, 10, 5);
    }}
  }
  
  
}
