class Tile{
  public Piece piece;
  private float x, y, d;
  
  public Tile(){
    x = 0;
    y = 0;
    d = 0;
    piece = null;
  }
  
  public Tile(float x, float y, float d){
    x = x;
    y = y;
    d = d;
    piece = null;
  }
  
  public boolean clicked(){
    return Math.hypot(mouseX - x, mouseY - y) < d / 2;
  }
  
  public void show(){
    fill(65, 77, 50);
    ellipse(x, y, d, d);
    if(piece != null){
      piece.show();
    }
  }
}