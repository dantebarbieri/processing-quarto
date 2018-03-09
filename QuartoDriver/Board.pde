class Board {
  private Tile[][] grid;

  public Board() {
    grid = new Tile[4][4];
    float r = 9 * height / 40;
    float x = 9 * height / 10 + r / 2;
    float y = 9 * height / 10 + r / 2;
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        grid[i][j] = new Tile(x + j * r, y + i * r, r);
      }
    }
  }

  public boolean play(Piece piece, int r, int c) {
    if (grid[r][c].piece != null) return false;
    grid[r][c].piece = piece;
    return true;
  }

  public void show() {
    fill(13, 7, 0);
    rect(9 * height / 10, height / 2, 9 * height / 10, 9 * height / 10);
    for (Tile[] row : grid) {
      for (Tile tile : row) {
        tile.show();
      }
    }
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