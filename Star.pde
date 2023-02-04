/* 
Class: Star
 used for background stars
 random small dots, moving slowly right to left
 uses an array to generate multiple stars
 */

public class Star
{

  // fields

  private int xCoord;
  private int yCoord;

  // constructors

  public Star() {
    setXCoord(int(random(width)));
    setYCoord(int(random(60, height)));
  }

  public Star(int xCoord, int yCoord) {
    setXCoord(xCoord);
    setYCoord(yCoord);
  }

  // getters

  public int getXCoord() {
    return this.xCoord;
  }

  public int getYCoord() {
    return this.yCoord;
  }

  // setters

  public void setXCoord(int xCoord) {
    if ((xCoord >= 0) && (xCoord <= width)) {
      this.xCoord = xCoord;
    } else {
      this.xCoord = int(random(width));
    }
  }

  public void setYCoord(int yCoord) {
    if ((yCoord >= 60) && (yCoord <= height)) {
      this.yCoord = yCoord;
    } else {
      this.yCoord = int(random(60, height));
    }
  }

  // methods

  public void display()
  {
    // display the star
    fill(white);
    noStroke();
    circle(xCoord, yCoord, 1);
  }

  public void update()
  {
    // move the star one pixel to the left
    // revert to the right-hand side at the end
    if (getXCoord() > 0) {
      setXCoord(getXCoord() - 1);
    } else {
      setXCoord(width);
    }
  }
}
