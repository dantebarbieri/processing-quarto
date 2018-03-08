class Board {
  private Piece[][] grid;

  public Board() {
    grid = new Piece[4][4];
  }

  public boolean gameOver() {
    for (Piece[] row : grid) {
      boolean full = true;
      for (Piece piece : row) {
        if (piece == null) full = false;
      }
      if (full) {
        boolean[] comparison = row[0].compareToMultiple(row);
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
        if (grid[j][i] == null) full = false;
      }
      if (full) {
        Piece[] col = {grid[0][i], grid[1][i], grid[2][i], grid[3][i]};
        boolean[] comparison = grid[0][i].compareToMultiple(col);
        for (boolean element : comparison) {
          if (element) {
            return true;
          }
        }
      }
    }
    boolean full = true;
    for (int i = 0; i < (grid.length + grid[0].length) / 2; i++) {
      if (grid[i][i] == null) full = false;
    }
    if (full) {
      Piece[] diag = {grid[0][0], grid[1][1], grid[2][2], grid[3][3]};
      boolean[] comparison = grid[0][0].compareToMultiple(diag);
      for (boolean element : comparison) {
        if (element) {
          return true;
        }
      }
    }
    full = true;
    for (int i = 0; i < (grid.length + grid[0].length) / 2; i++) {
      if (grid[i][3-i] == null) full = false;
    }
    if (full) {
      Piece[] diag = {grid[0][3], grid[1][2], grid[2][1], grid[3][0]};
      boolean[] comparison = grid[0][3].compareToMultiple(diag);
      for (boolean element : comparison) {
        if (element) {
          return true;
        }
      }
    }
    return false;
  }
}