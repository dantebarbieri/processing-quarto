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
    this.x = x;
    this.y = y;
    this.d = d;
    piece = null;
  }
  
  public boolean clicked(){
    return Math.hypot(mouseX - x, mouseY - y) < d;
  }
  
  public void show(){
    fill(26, 13, 0);
    stroke(150, 150, 150);
    ellipse(x, y, d, d);
    if(this.piece != null){
      this.piece.show(x, y, d / 2f);
    }
  }
}