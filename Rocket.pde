/* 
 Class: Rocket
 used for the player's rocket
 can move within the first quarter
 of the screen width only
 */

public class Rocket
{

  // fields
  
  private int xCoord;
  private int yCoord;
  private int rocketWidth;
  private int rocketHeight;

  // constructors

  public Rocket() {
    setRocketWidth(50);
    setRocketHeight(30);
    setXCoord(10 + this.rocketWidth);
    setYCoord(height/2);
  }

  public Rocket(int rocketWidth, int rocketHeight) {
    setRocketWidth(rocketWidth);
    setRocketHeight(rocketHeight);
    setXCoord(10 + this.rocketWidth);
    setYCoord(height/2);
  }

  // getters

  public int getXCoord() {
    return this.xCoord;
  }

  public int getYCoord() {
    return this.yCoord;
  }

  public int getRocketWidth() {
    return this.rocketWidth;
  }

  public int getRocketHeight() {
    return this.rocketHeight;
  }

  //setters
  
  public void setRocketWidth(int rocketWidth) {
    if ((rocketWidth >= 30) && (rocketWidth <= width/6)) {
      this.rocketWidth = rocketWidth;
    } else {
      this.rocketWidth = 50;
    }
  }  

  public void setRocketHeight(int rocketHeight) {
    //The rocket height must be between 50 and height/2 (inclusive)
    if ((rocketHeight >= 20) && (rocketHeight <= height/6)) {
      this.rocketHeight = rocketHeight;
    } else {
      this.rocketHeight = 30;
    }
  }  

  public void setXCoord(int xCoord) {
    if ((xCoord >= 5) && (xCoord <= width/4)) {
      this.xCoord = xCoord;
    }
  }

  public void setYCoord(int yCoord) {
    if ((yCoord >= 60) && (yCoord <= height - rocketHeight/2)) {
      this.yCoord = yCoord;
    }
  }

  // methods
  
  public void display()
  {
    // display the rocket
    fill(blue);
    strokeWeight(3);
    stroke(green);
    triangle(xCoord, yCoord-(rocketHeight/2), xCoord+rocketWidth, yCoord, xCoord, yCoord+(rocketHeight/2));
  }
}
