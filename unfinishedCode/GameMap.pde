// Bradley Nieto
class GameMap {
  int[][] grid = new int[GRID_ROWS][GRID_COLS];
  
  GameMap() {
    loadLevel(1);
  }
  
  void loadLevel(int lvl) {
    clearGrid();
    
    switch(lvl) {
      case 1: // Classic Columns
        for (int r = 1; r < 10; r += 2) {
          setMacro(r, 1, TILE_BRICK); setMacro(r, 2, TILE_BRICK);
          setMacro(r, 4, TILE_BRICK); setMacro(r, 5, TILE_BRICK);
          setMacro(r, 7, TILE_BRICK); setMacro(r, 8, TILE_BRICK);
          setMacro(r, 10, TILE_BRICK); setMacro(r, 11, TILE_BRICK);
        }
        setMacro(6, 6, TILE_STEEL);
        setMacro(3, 3, TILE_WATER); setMacro(3, 9, TILE_WATER);
        setMacro(9, 2, TILE_BUSH); setMacro(9, 3, TILE_BUSH);
        break;
        
      case 2: // Dual Steel Fortresses
        setMacro(2, 2, TILE_STEEL); setMacro(2, 3, TILE_STEEL); setMacro(2, 4, TILE_STEEL);
        setMacro(2, 8, TILE_STEEL); setMacro(2, 9, TILE_STEEL); setMacro(2, 10, TILE_STEEL);
        setMacro(6, 1, TILE_BRICK); setMacro(6, 2, TILE_BRICK); setMacro(6, 3, TILE_BRICK);
        setMacro(6, 9, TILE_BRICK); setMacro(6, 10, TILE_BRICK); setMacro(6, 11, TILE_BRICK);
        setMacro(4, 6, TILE_WATER); setMacro(5, 6, TILE_WATER);
        setMacro(8, 5, TILE_BUSH); setMacro(8, 6, TILE_BUSH); setMacro(8, 7, TILE_BUSH);
        break;
        
      case 3: // The Maze
        for (int c = 1; c < 12; c += 2) {
          setMacro(2, c, TILE_BRICK);
          setMacro(4, c, TILE_BRICK);
          setMacro(6, c, TILE_BRICK);
          setMacro(8, c, TILE_BRICK);
        }
        setMacro(5, 6, TILE_STEEL);
        setMacro(3, 6, TILE_WATER);
        break;
        
      case 4: // River Crossings
        for (int r = 1; r < 11; r++) {
          setMacro(r, 3, TILE_WATER);
          setMacro(r, 9, TILE_WATER);
        }
        setMacro(5, 6, TILE_BRICK);
        setMacro(6, 5, TILE_BRICK); setMacro(6, 7, TILE_BRICK);
        setMacro(8, 6, TILE_STEEL);
        break;
        
      case 5: // Forest Ambush
        for (int r = 2; r < 10; r++) {
          for (int c = 1; c < 12; c += 3) {
            setMacro(r, c, TILE_BUSH);
          }
        }
        setMacro(3, 6, TILE_BRICK); setMacro(7, 6, TILE_BRICK);
        setMacro(5, 2, TILE_STEEL); setMacro(5, 10, TILE_STEEL);
        break;
        
      case 6: // Diamond Wall
        setMacro(3, 6, TILE_BRICK);
        setMacro(4, 5, TILE_BRICK); setMacro(4, 7, TILE_BRICK);
        setMacro(5, 4, TILE_BRICK); setMacro(5, 8, TILE_BRICK);
        setMacro(6, 3, TILE_BRICK); setMacro(6, 9, TILE_BRICK);
        setMacro(7, 4, TILE_BRICK); setMacro(7, 8, TILE_BRICK);
        setMacro(8, 5, TILE_BRICK); setMacro(8, 7, TILE_BRICK);
        setMacro(9, 6, TILE_BRICK);
        setMacro(6, 6, TILE_STEEL);
        break;
        
      case 7: // The Iron Wall
        for (int c = 1; c < 12; c++) {
          if (c != 6) setMacro(5, c, TILE_STEEL);
        }
        setMacro(2, 3, TILE_BRICK); setMacro(2, 9, TILE_BRICK);
        setMacro(8, 3, TILE_BRICK); setMacro(8, 9, TILE_BRICK);
        setMacro(3, 6, TILE_WATER);
        break;
        
      case 8: // Sniper Alley
        for (int r = 1; r < 11; r += 2) {
          setMacro(r, 2, TILE_BRICK); setMacro(r, 6, TILE_BRICK); setMacro(r, 10, TILE_BRICK);
        }
        setMacro(4, 4, TILE_STEEL); setMacro(4, 8, TILE_STEEL);
        setMacro(7, 4, TILE_WATER); setMacro(7, 8, TILE_WATER);
        break;
        
      case 9: // The Gauntlet
        setMacro(2, 1, TILE_BRICK); setMacro(2, 2, TILE_BRICK); setMacro(2, 3, TILE_BRICK);
        setMacro(2, 9, TILE_BRICK); setMacro(2, 10, TILE_BRICK); setMacro(2, 11, TILE_BRICK);
        setMacro(4, 4, TILE_STEEL); setMacro(4, 5, TILE_STEEL); setMacro(4, 7, TILE_STEEL); setMacro(4, 8, TILE_STEEL);
        setMacro(6, 2, TILE_BRICK); setMacro(6, 6, TILE_BRICK); setMacro(6, 10, TILE_BRICK);
        setMacro(8, 4, TILE_WATER); setMacro(8, 8, TILE_WATER);
        break;
        
      case 10: // Final Fortress
        setMacro(2, 5, TILE_STEEL); setMacro(2, 6, TILE_STEEL); setMacro(2, 7, TILE_STEEL);
        setMacro(4, 3, TILE_STEEL); setMacro(4, 9, TILE_STEEL);
        setMacro(6, 2, TILE_BRICK); setMacro(6, 4, TILE_BRICK); setMacro(6, 8, TILE_BRICK); setMacro(6, 10, TILE_BRICK);
        setMacro(8, 5, TILE_BRICK); setMacro(8, 6, TILE_BRICK); setMacro(8, 7, TILE_BRICK);
        setMacro(3, 1, TILE_WATER); setMacro(3, 11, TILE_WATER);
        break;
    }
    
    // Always place Eagle Base at the bottom center
    setMacro(12, 6, TILE_EAGLE);
    setMacro(12, 5, TILE_BRICK);
    setMacro(11, 5, TILE_BRICK);
    setMacro(11, 6, TILE_BRICK);
    setMacro(11, 7, TILE_BRICK);
    setMacro(12, 7, TILE_BRICK);
  }
  
  void clearGrid() {
    for (int r = 0; r < GRID_ROWS; r++) {
      for (int c = 0; c < GRID_COLS; c++) {
        grid[r][c] = TILE_EMPTY;
      }
    }
  }
  
  void setMacro(int mr, int mc, int type) {
    int sr = mr * 2;
    int sc = mc * 2;
    grid[sr][sc] = type;
    grid[sr+1][sc] = type;
    grid[sr][sc+1] = type;
    grid[sr+1][sc+1] = type;
  }
  
  void generateRandom() {
    clearGrid();
    for (int mr = 1; mr < MACRO_ROWS - 1; mr++) {
      for (int mc = 0; mc < MACRO_COLS / 2; mc++) {
        if (mr >= 10 && mc >= 3 && mc <= 9) continue;
        
        float rand = random(1.0);
        if (rand < 0.25) setMacro(mr, mc, TILE_BRICK);
        else if (rand < 0.32) setMacro(mr, mc, TILE_STEEL);
        else if (rand < 0.38) setMacro(mr, mc, TILE_BUSH);
        for (int r = 0; r < GRID_ROWS; r++) {for (int c = 0; c < GRID_COLS; c++) { // scans the entire grid, besides player spawn so not stuck
          int mirroredCols = 25 - c; // matches the left side with the right side, 0 grid on the left side is 25 on the right, etc etc
          grid[r][mirroredCols] = grid[r][c]; // then overwrites left side onto the right side but backwards, 
        }}
        
      }
    }
    setMacro(12, 6, TILE_EAGLE);
    setMacro(12, 5, TILE_BRICK);
    setMacro(11, 5, TILE_BRICK);
    setMacro(11, 6, TILE_BRICK);
    setMacro(11, 7, TILE_BRICK);
    setMacro(12, 7, TILE_BRICK);
  }
  
  void drawBase() {
    for (int r = 0; r < GRID_ROWS; r++) {
      for (int c = 0; c < GRID_COLS; c++) {
        int x = c * TILE_SIZE;
        int y = r * TILE_SIZE;
        switch (grid[r][c]) {
          case TILE_BRICK:
            fill(180, 50, 0);
            noStroke();
            //rect(x, y, TILE_SIZE, TILE_SIZE);
            image(brickImg, x, y, TILE_SIZE, TILE_SIZE);
            stroke(100, 20, 0);
            strokeWeight(1);
            noFill();
            rect(x, y, TILE_SIZE, TILE_SIZE);
            noStroke();
            break;
          case TILE_STEEL:
            noStroke();
            fill(150, 150, 150);
            image(metalImg, x, y, TILE_SIZE, TILE_SIZE);
            break;
          case TILE_WATER:
            noStroke();
            fill(0, 100, 200);
            image(waterImg, x, y, TILE_SIZE, TILE_SIZE);
            break;
          case TILE_EAGLE:
            noStroke();
            fill(255, 200, 0);
            if (r % 2 == 0 && c % 2 == 0) {image(eagleImg, x, y, TILE_SIZE*2, TILE_SIZE*2);}
            //rect(x, y, TILE_SIZE, TILE_SIZE);
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
