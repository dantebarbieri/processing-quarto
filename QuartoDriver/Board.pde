class Board {
  public Tile[][] grid;

  public Board() {
    grid = new Tile[4][4];
    float r = 9 * height / 40;
    float x = 41 * height / 80 - 2 * r + r / 2;
    float y = height / 2 - 2 * r + r / 2;
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        grid[i][j] = new Tile(x + j * r, y + i * r, 9 * r / 10);
      }
    }
  }
  
  public Board(Board other) {
    grid = new Tile[4][4];
    for(int i = 0; i < other.grid.length; i++){
      for(int j = 0; j < other.grid[i].length; j++){
        grid[i][j] = new Tile(other.grid[i][j]);
      }
    }
  }

  public boolean play(Piece piece, int r, int c) {
    if (grid[r][c].piece != null) return false;
    Piece move = new Piece(piece);
    move.x = grid[r][c].x;
    move.y = grid[r][c].y;
    move.r = grid[r][c].d / 2;
    move.selection = true;
    grid[r][c].piece = move;
    return true;
  }

  public void show() {
    fill(35, 51, 0);
    stroke(150, 150, 150);
    strokeWeight(15);
    rect(41 * height / 80, height / 2, 9 * height / 10, 9 * height / 10);
    for (Tile[] row : grid) {
      for (Tile tile : row) {
        tile.show();
      }
    }
  }

  public boolean tieGame() {
    for (Tile[] row : grid) {
      for (Tile tile : row) {
        if (tile.piece == null) {
          return false;
        }
      }
    }
    return true;
  }

  public boolean gameOver() {
    for (Tile[] row : grid) {
      boolean full = true; 
      for (Tile tile : row) {
        if (tile.piece == null) full = false;
      }
      if (full) {
        Piece[] pieces = {row[1].piece, row[2].piece, row[3].piece}; 
        boolean[] comparison = row[0].piece.compareToMultiple(pieces); 
        for (boolean element : comparison) {
          if (element) {
            return true;
          }
        }
      }
    }
    for (int i = 0; i < grid[0].length; i++) {
      boolean full = true; 
      for (int j = 0; j < grid.length; j++) {
        if (grid[j][i].piece == null) full = false;
      }
      if (full) {
        Piece[] pieces = {grid[1][i].piece, grid[2][i].piece, grid[3][i].piece}; 
        boolean[] comparison = grid[0][i].piece.compareToMultiple(pieces); 
        for (boolean element : comparison) {
          if (element) {
            return true;
          }
        }
      }
    }
    boolean full = true; 
    for (int i = 0; i < (grid.length + grid[0].length) / 2; i++) {
      if (grid[i][i].piece == null) full = false;
    }
    if (full) {
      Piece[] pieces = {grid[1][1].piece, grid[2][2].piece, grid[3][3].piece}; 
      boolean[] comparison = grid[0][0].piece.compareToMultiple(pieces); 
      for (boolean element : comparison) {
        if (element) {
          return true;
        }
      }
    }
    full = true; 
    for (int i = 0; i < (grid.length + grid[0].length) / 2; i++) {
      if (grid[i][3-i].piece == null) full = false;
    }
    if (full) {
      Piece[] pieces = {grid[1][2].piece, grid[2][1].piece, grid[3][0].piece}; 
      boolean[] comparison = grid[0][3].piece.compareToMultiple(pieces); 
      for (boolean element : comparison) {
        if (element) {
          return true;
        }
      }
    }
    return false;
  }
}