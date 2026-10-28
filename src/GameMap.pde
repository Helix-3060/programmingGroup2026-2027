class GameMap {
  int[][] grid = new int[GRID_ROWS][GRID_COLS];
  
  GameMap() {
    init();
  }
  
  void init() {
    for (int r = 0; r < GRID_ROWS; r++) {
      for (int c = 0; c < GRID_COLS; c++) {
        grid[r][c] = TILE_EMPTY;
      }
    }
    
    for (int r = 1; r < 10; r += 2) {
      grid[r][1] = TILE_BRICK; grid[r][2] = TILE_BRICK;
      grid[r][4] = TILE_BRICK; grid[r][5] = TILE_BRICK;
      grid[r][7] = TILE_BRICK; grid[r][8] = TILE_BRICK;
      grid[r][10] = TILE_BRICK; grid[r][11] = TILE_BRICK;
    }
    
    grid[6][6] = TILE_STEEL;
    
    grid[3][3] = TILE_WATER;
    grid[3][9] = TILE_WATER;
    
    grid[9][2] = TILE_BUSH;
    grid[9][3] = TILE_BUSH;
    grid[10][2] = TILE_BUSH;
    grid[10][3] = TILE_BUSH;
    
    grid[12][6] = TILE_EAGLE;
    grid[12][5] = TILE_BRICK;
    grid[11][5] = TILE_BRICK;
    grid[11][6] = TILE_BRICK;
    grid[11][7] = TILE_BRICK;
    grid[12][7] = TILE_BRICK;
  }
  
  void drawBase() {
    noStroke();
    for (int r = 0; r < GRID_ROWS; r++) {
      for (int c = 0; c < GRID_COLS; c++) {
        int x = c * TILE_SIZE;
        int y = r * TILE_SIZE;
        
        switch (grid[r][c]) {
          case TILE_BRICK:
            fill(180, 50, 0);
            rect(x, y, TILE_SIZE, TILE_SIZE);
            break;
          case TILE_STEEL:
            fill(150, 150, 150);
            rect(x, y, TILE_SIZE, TILE_SIZE);
            break;
          case TILE_WATER:
            fill(0, 100, 200);
            rect(x, y, TILE_SIZE, TILE_SIZE);
            break;
          case TILE_EAGLE:
            fill(255, 200, 0);
            rect(x, y, TILE_SIZE, TILE_SIZE);
            break;
        }
      }
    }
  }
  
  void drawOverlays() {
    noStroke();
    for (int r = 0; r < GRID_ROWS; r++) {
      for (int c = 0; c < GRID_COLS; c++) {
        if (grid[r][c] == TILE_BUSH) {
          int x = c * TILE_SIZE;
          int y = r * TILE_SIZE;
          fill(34, 139, 34, 200);
          rect(x, y, TILE_SIZE, TILE_SIZE);
        }
      }
    }
  }
  
  void burnBushAndNeighbors(int r, int c) {
    if (r < 0 || r >= GRID_ROWS || c < 0 || c >= GRID_COLS) return;
    if (grid[r][c] == TILE_BUSH) {
      grid[r][c] = TILE_EMPTY;
      burnBushAndNeighbors(r + 1, c);
      burnBushAndNeighbors(r - 1, c);
      burnBushAndNeighbors(r, c + 1);
      burnBushAndNeighbors(r, c - 1);
    }
  }
}
