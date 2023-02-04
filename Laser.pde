/* 
 Class: Laser
 used for the rocket's laser
 fires from the front of the rocket
 across to the end of the screen, 
 or to the meteor that it hits
 */

public class Laser
{

  // fields

  private int laserLeft;
  private int laserRight;
  private int yCoord;

  // constructors

  public Laser(Rocket rocket) {
    setLaserLeft(rocket, rocket.getXCoord()+rocket.getRocketWidth());
    setLaserRight(rocket, width);
    setYCoord(rocket, rocket.getYCoord());
  }

  public Laser(Rocket rocket, int laserLeft, int laserRight, int yCoord) {
    setLaserLeft(rocket, laserLeft);
    setLaserRight(rocket, laserRight);
    setYCoord(rocket, yCoord);
  }

  // getters

  public int getLaserLeft() {
    return this.laserLeft;
  }

  public int getLaserRight() {
    return this.laserRight;
  }

  public int getYCoord() {
    return this.yCoord;
  }

  //setters

  public void setLaserLeft(Rocket rocket, int laserLeft) {
    if ((laserLeft >= rocket.getXCoord()) && (laserLeft <= rocket.getXCoord()+rocket.getRocketWidth())) {
      this.laserLeft = laserLeft;
    } else {
      this.laserLeft = rocket.getXCoord()+rocket.getRocketWidth();
    }
  }  

  public void setLaserRight(Rocket rocket, int laserRight) {
    if ((laserRight >= (rocket.getXCoord()+rocket.getRocketWidth())) && (laserRight <= width)) {
      this.laserRight = laserRight;
    } else {
      this.laserRight = width;
    }
  }  

  public void setYCoord(Rocket rocket, int yCoord) {
    if ((yCoord >= 0) && (yCoord <= height)) {
      this.yCoord = yCoord;
    } else {
      this.yCoord = rocket.getYCoord();
    }
  }  

  // methods

  public void display()
  {
    // display the rocket
    strokeWeight(11);
    stroke(magenta);
    line(laserLeft - 5, yCoord, laserRight, yCoord);
    strokeWeight(7);
    stroke(lightMagenta);
    line(laserLeft - 2, yCoord, laserRight, yCoord);
    strokeWeight(3);
    stroke(white);
    line(laserLeft, yCoord, laserRight, yCoord);
  }
}
