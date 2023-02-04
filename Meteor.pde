/* 
 Class: Meteor
 used for the meteors hurtling along
 move right to left, with variable up/down speed
 reduce in size when hit by the laser
 lose a life when hit by the rocket
 can leave a bonus behind when destroyed
 but this is based on time hit (50%)
 */

public class Meteor {

  // fields

  private int radius;
  private float xCoord, yCoord, xSpeed, ySpeed;
  private boolean generateBonus;
  private float bonusXCoord, bonusYCoord;

  // constructors

  public Meteor() {
    setRadius(40);
    setXSpeed(1);
    setYSpeed(random(-3, 3));
    setXCoord(width);
    setYCoord(random(50 + radius, height - radius));
    setGenerateBonus(false);
  }

  public Meteor(int radius, float xSpeed, float ySpeed) {
    setRadius(radius);
    setXSpeed(xSpeed);
    setYSpeed(ySpeed);
    setXCoord(width);
    setYCoord(random(50 + radius, height - radius));
    setGenerateBonus(false);
  }

  // getters

  public float getXCoord() {
    return this.xCoord;
  }

  public float getYCoord() {
    return this.yCoord;
  }

  public int getRadius() {
    return this.radius;
  }

  public float getXSpeed() {
    return this.xSpeed;
  }

  public float getYSpeed() {
    return this.ySpeed;
  }

  public boolean getGenerateBonus() {
    return this.generateBonus;
  }

  public float getBonusXCoord() {
    return this.bonusXCoord;
  }

  public float getBonusYCoord() {
    return this.bonusYCoord;
  }

  // setters 
  
  public void setRadius(int radius) {
    if ((radius == 10) || (radius == 20) || (radius == 30) || (radius == 40)) {
      this.radius = radius;
    } else {
      this.radius = 40;
    }
  }  

  public void setXSpeed(float xSpeed) {
    if ((xSpeed >= 1) && (xSpeed <= 100) ) {
      this.xSpeed = xSpeed;
    } else {
      this.xSpeed = 1;
    }
  }  

  public void setYSpeed(float ySpeed) {
    if ((ySpeed >= -5) && (ySpeed <= 5) ) {
      this.ySpeed = ySpeed;
    } else {
      this.ySpeed = random(-3, 3);
    }
  }  

  public void setXCoord(float xCoord) {
    if ((xCoord >= 0 - radius) && (xCoord <= width + radius)) {
      this.xCoord = xCoord;
    } else {
      this.xCoord = width + radius;
    }
  }

  public void setYCoord(float yCoord) {
    if ((yCoord >= 55) && (yCoord <= height - (radius + 1))) {
      this.yCoord = yCoord;
    }
  }

  public void setGenerateBonus(boolean generateBonus) {
    this.generateBonus = generateBonus;
  }

  public void setBonusXCoord(float xCoord) {
    this.bonusXCoord = xCoord;
  }

  public void setBonusYCoord(float yCoord) {
    this.bonusYCoord = yCoord;
  }

  // methods

  public void display()
  {
    // draw the meteor
    noStroke();
    fill(lightGrey);
    circle(xCoord, yCoord, radius * 2);

    // draw small craters
    fill(darkGrey);
    circle(xCoord+(radius*0.25), yCoord-(radius*0.25), radius*0.5);
    circle(xCoord-(radius*0.5), yCoord, radius*0.25);
    circle(xCoord+(radius*0.25), yCoord+(radius*0.5), radius*0.25);
  }

  public void update()
  {
    // bounce against top or bottom
    if ((this.getYCoord() <= (55 + this.getRadius())) || (this.getYCoord() >= (height - (this.getRadius()+ 5)))) {
      this.setYSpeed(this.getYSpeed() * -1);
    }

    // reset when a meteor gets to the end
    if (this.getXCoord() < this.getRadius()) {
      this.setXCoord(width);
      this.setYCoord(random(60 + this.getRadius(), height - this.getRadius() ));
      this.setXSpeed(this.getXSpeed() + 0.1);
      this.setYSpeed(random(-3, 3));
      this.setRadius(40);
    }

    // update meteor position
    this.setXCoord(this.getXCoord() - this.getXSpeed());
    this.setYCoord(this.getYCoord() - this.getYSpeed());
  }

  public void hit()
  {
    this.setYSpeed(random(-3, 3));
    if (this.getRadius() > 10) {
      this.setRadius(this.getRadius() - 10);
    } else if (this.getRadius() <= 10) {
      // 50% chance of generating bonus
      // using time when meteor hit
      if (millis() % 1000 < 500) {
        this.generateBonus = true;
        this.bonusXCoord = this.xCoord;
        this.bonusYCoord = this.yCoord;
      }
      this.destroyed();
    }
  }

  public void destroyed()
  {
    this.setXCoord(width);
    this.setYCoord(random(50 + this.getRadius(), height - this.getRadius() ));
    this.setXSpeed(this.getXSpeed() + 0.1);
    this.setYSpeed(random(-3, 3));
    this.setRadius(40);
  }
}
