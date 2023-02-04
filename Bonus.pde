/* 
 Class: Bonus
 used for bonuses left by destroyed meteors
 only appear when left - otherwise ignored
 rocket collides with bonus to collect points
 */

public class Bonus {

  // fields

  private boolean active = false;
  private float xCoord, yCoord;

  // constructors

  public Bonus() {
    setXCoord(width);
    setYCoord(height/2);
  }

  public Bonus(float xCoord, float yCoord, boolean active) {
    setXCoord(xCoord);
    setYCoord(yCoord);
    setActive(active);
  }

  // getters

  public float getXCoord() {
    return this.xCoord;
  }

  public float getYCoord() {
    return this.yCoord;
  }

  public boolean getActive() {
    return this.active;
  }

  // setters 
  
  public void setXCoord(float xCoord) {
    if ((xCoord >= 0) && (xCoord <= width)) {
      this.xCoord = xCoord;
    } else {
      this.xCoord = width;
    }
  }

  public void setYCoord(float yCoord) {
    if ((yCoord >= 60) && (yCoord <= height)) {
      this.yCoord = yCoord;
    } else {
      this.yCoord = height/2;
    }
  }

  public void setActive(boolean active) {
    this.active = active;
  }

  // methods

  public void display()
  {
    // display the bonus asterisk, but only if active
    // uses HSB to rotate hue based on X position
    if (this.getActive()) {
      noStroke();
      colorMode(HSB, 360, 100, 100);
      fill(this.xCoord % 360, 100, 100);
      textFont(fontMedium);
      textAlign(CENTER, CENTER);
      text("*", this.xCoord, this.yCoord);
      colorMode(RGB, 255, 255, 255);
    }
  }

  public void update()
  {
    // reset when a bonus gets to the end
    if (this.getXCoord() < 1) {
      this.setActive(false);
    }

    // update bonus position
    this.setXCoord(this.getXCoord() - 1);
  }

  public void collected()
  {
    this.setActive(false);
  }
}
