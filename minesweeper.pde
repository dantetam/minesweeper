public boolean active = false;
public Tile[][] tiles;
public int rows = 10, cols = 10, mines = 10;

public void setup()
{
  size(800,800);

}

public void draw()
{
  float w = width/float(rows), h = height/float(cols);
  if (tiles == null) return;
  for (int r = 0; r < tiles.length; r++)
  {
    for (int c = 0; c < tiles[0].length; c++)
    {
      Tile t = tiles[r][c];
      if (t.getMode() == 0)
        fill(150);
      else if (t.getMode() == 1)
        fill(255);
      else
        fill(255,0,0);
      rect(r*w, c*h, w, h);
    }
  }
}

public void keyPressed()
{
  if (key == 32)
  {
    tiles = null;
    active = true;
  }
}

public void mousePressed()
{
  if (!active) return;
  int r = int(mouseX/width*float(rows)), c = int(mouseY/height*float(cols));
  println(r); println(c);
  if (mouseButton == RIGHT)
  {
    Tile t = tiles[r][c];
    if (t.getMode() == 2 || t.getMode() == 1) return;
    else //if (t.getMode() == 0) 
    {
      if (t.hasMine())
      {
        t.mode(2);
      }
      else
        return;
    }
  }
  else
  {
    if (tiles == null)
      setTiles(r,c);
    else
    {
      Tile t = tiles[r][c];
      if (t.getMode() == 2 || t.getMode() == 1)
      {
        return;
      }
      else //if (t.getMode() == 0)
      {
        if (t.hasMine())
        {
          active = false; println("Lost");
        }
        else
        {
          t.mode(1);
        }
      }
    }
  }
}

public void setTiles(int mouseR, int mouseC)
{
  tiles = new Tile[rows][cols];
  for (int r = 0; r < tiles.length; r++)
  {
    for (int c = 0; c < tiles[0].length; c++)
    {
      tiles[r][c] = new Tile(false, 0);
    }
  }
  int r,c;
  for (int i = 0; i < mines; i++)
  {
    do
    {
      r = int(random(0,1)*float(tiles.length)); c = int(random(0,1)*float(tiles[0].length));
    } while (tiles[r][c].hasMine() || (r == mouseR && c == mouseC));
    tiles[r][c].mine();
  }
}

public class Tile
{
  private boolean mine;
  private int mode = 0; //0 -> unrevealed; 1 -> dug (shows # of neighboring mines); 2 -> flag 
  
  public Tile(boolean mine, int m)
  {
    this.mine = mine; mode = m;
  }
  
  public boolean hasMine() {return mine;}
  public int getMode() {return mode;}
  public void mine() {mine = true;}
  public void mode(int n) {mode = n;}
 
}
