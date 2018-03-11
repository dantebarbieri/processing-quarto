class Tile{
  public Piece piece;
  private float x, y, d;
  
  public Tile(float x, float y, float d){
    this.x = x;
    this.y = y;
    this.d = d;
    piece = null;
  }
  
  public Tile(Tile other){
    this.x = other.x;
    this.y = other.y;
    this.d = other.d;
    piece = other.piece;
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