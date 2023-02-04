/*  //<>//
 * METEOR RUN
 * Ian Blake
 * 20099862
 */

// Import Swing for JOptionPane
import javax.swing.*;

// Initialise game objects
Rocket rocket;
Meteor meteor;
Laser laser;
Bonus bonus;
Star[] star;
Player player;
String name;

// Set up variables for controls
boolean up = false;
boolean down = false;
boolean left = false;
boolean right = false;
boolean fire = false;
int laserRecharge = 0; // number not boolean, as used as timer when triggered
int rocketRespawn = 0; // number not boolean, as used as timer when triggered


// Set up variable for star field
int stars = 80 + int(random(80));

// Set up variables for lives and scoring on new game
boolean setupGame = true;
boolean getReady = false;
boolean playGame = false;
boolean gameOver = false;
boolean allOver = false;
boolean bonusState = false;
int maxGames;
int gamesPlayed = 0;
int lives = 3;
int score = 0;
int extraLife = 1000;

// Set up font and colour variables (fonts assigned later)
PFont fontTitle, fontLarge, fontMedium, fontSmall;
color white = color(255, 255, 255);
color black = color (0, 0, 0);
color red = color(255, 0, 0);
color yellow = color(255, 255, 0);
color green = color(0, 255, 0);
color cyan = color(0, 255, 255);
color blue = color(0, 0, 255);
color magenta = color(255, 0, 255);
color lightMagenta = color(255, 153, 255);
color lightGrey = color (200, 180, 200);
color darkGrey = color (100, 80, 100);

void setup() {
  noCursor();
  size(960, 720); // 4:3 aspect ratio
  background(black);
  fonts();
  rocket = new Rocket(); // use defaults
  meteor = new Meteor(40, 1, random(-3, 3)); // overloaded
  star = new Star[stars];
  for (int i = 0; i < stars; i++) {
    int x = int(random(width));
    int y = int(random(60, height));
    star[i] = new Star(x, y);
  }
}

void draw() {
  background(black);

  // title screen until keyPressed(), then ready screen
  if (setupGame) {
    // get game details
    titleScreen();

    // ready screen until keyPressed(), then play game
  } else if (getReady) {
    // display the title screen
    readyScreen();

    // game over screen
  } else if (gameOver) {
    // game over screen
    gameOver();

    // all over screen
  } else if (allOver) {
    // game over screen
    allOver();

    // play the game
  } else if (playGame) {

    // display lives left and current score
    fill(white);
    textFont(fontMedium);
    textAlign(LEFT, TOP);
    text("LIVES: " + lives, 10, 10);
    textAlign(RIGHT, TOP);
    text("SCORE:       ", 950, 10); // allow enough space for a really good score!
    text(score, 950, 10);

    // check for bonus generation
    if (meteor.generateBonus) {
      bonus = new Bonus (meteor.getBonusXCoord(), meteor.getBonusYCoord(), true);
      bonusState = true;
      meteor.setGenerateBonus(false);
    }

    // update meteor position
    meteor.update();

    // display star field
    for (int i = 0; i < stars; i++) {
      star[i].display();
      star[i].update();
    }

    // crash screen if the rocket hits a meteor
    // brief yellow flash
    if (crashRocket(rocket, meteor)) {
      background(yellow);
      lives--;
    }

    // check if lives lost
    if (lives == 0) {
      player.addScore(score);
      gamesPlayed++;
      gameOver = true;
    } else {
      gameOver = false;
    }

    // check if max games played
    if (gameOver && gamesPlayed >= maxGames) {
      gameOver = false;
      allOver = true;
    }


    // if the rocket is about to respawn, reset its position
    if (rocketRespawn == 1) {
      rocket = new Rocket() ;
    }

    // update laserRecharge and rocketRespawn timers
    laserRecharge--;
    if (laserRecharge < 0) {
      laserRecharge = 0;
    }

    rocketRespawn--;
    if (rocketRespawn < 0) {
      rocketRespawn = 0;
    }

    // check for extra life granted at score levels
    if (score >= extraLife) {
      background(blue);
      lives++;
      extraLife = extraLife * 2;
    }

    // move the rocket if a key has been pressed
    // see keyPressed() and keyReleased() below
    if (up) {
      rocket.setYCoord(rocket.getYCoord() - 10);
    }
    if (down) {
      rocket.setYCoord(rocket.getYCoord() + 10);
    }
    if (left) {
      rocket.setXCoord(rocket.getXCoord() - 10);
    }
    if (right) {
      rocket.setXCoord(rocket.getXCoord() + 10);
    }

    // fire the laser if a key has been pressed
    // see keyPressed() and keyReleased() below
    if (fire && laserRecharge == 0) {
      if (hitMeteor(rocket, meteor)) {
        // laser to meteor if it hits one
        laser = new Laser(rocket, rocket.getXCoord()+rocket.getRocketWidth(), int(meteor.getXCoord()), rocket.getYCoord());
        score = score + (50 - meteor.getRadius());
        meteor.hit();
      } else {
        // laser to the end of the screen
        laser = new Laser(rocket, rocket.getXCoord()+rocket.getRocketWidth(), width, rocket.getYCoord());
      }
      laser.display();
      fire = false;
    }

    if (scoreBonus(rocket, bonus)) {
      score = score + int(bonus.getXCoord());
      bonusState = false;
    }

    // display the meteor
    meteor.display();

    // display the bonus where one exists
    if (bonusState) {
      bonus.update();
      bonus.display();
    }

    // display the rocket if it is not paused
    // uses int variable for delay
    if (rocketRespawn == 0) {
      rocket.display();
    }
  }
}

void fonts() {
  /* 
   set up PressStart2P font in 4 sizes (64, 32, 24, 16)
   https://www.fontspace.com/press-start-2p-font-f11591
   */
  fontTitle = createFont("PressStart2P-vaV7.ttf", 64);
  fontLarge = createFont("PressStart2P-vaV7.ttf", 32);
  fontMedium = createFont("PressStart2P-vaV7.ttf", 24);
  fontSmall = createFont("PressStart2P-vaV7.ttf", 16);
}

void titleScreen() {
  // game title screen
  textFont(fontTitle);
  textAlign(CENTER, BOTTOM);
  fill(red);
  text("METEOR RUN", 480, 360);
  textFont(fontSmall);
  textAlign(CENTER, TOP);
  fill(cyan);
  text("by IAN BLAKE 2022", 480, 380);

  // flash PRESS ANY KEY TO START
  if (millis() % 1000 < 600) {
    textFont(fontMedium);
    textAlign(CENTER, TOP);
    fill(yellow);
    text("PRESS ANY KEY TO START", 480, 480);
  }

  // detect key press to start game
  if (keyPressed == true) {
    delay(500);

    // get game data
    while (maxGames < 1 || maxGames > 3) {
      maxGames = Integer.parseInt(JOptionPane.showInputDialog("This is\nMETEOR RUN\n\nHow many games would you like to play?\n(Please enter 1, 2 or 3)", "1"));
    }

    do {
      name = JOptionPane.showInputDialog("What is your name?\n(Please enter up to three characters.)");
    } while (name.length() < 1 || name.length() > 3);

    while (name.length() < 3) {
      name = name + "*";
    }

    player = new Player(name, maxGames);

    setupGame = false;
    getReady = true;
  }
}

void readyScreen() {
  // game title screen
  textFont(fontTitle);
  textAlign(CENTER, BOTTOM);
  fill(red);
  text("METEOR RUN", 480, 360);
  textFont(fontMedium);
  textAlign(CENTER, TOP);
  fill(white);
  text("READY PLAYER " + player.getName(), 480, 440);

  // flash PRESS ANY KEY TO START
  if (millis() % 1000 < 600) {
    textFont(fontMedium);
    textAlign(CENTER, TOP);
    fill(yellow);
    text("PRESS ANY KEY TO START", 480, 480);
  }

  // detect key press to start game
  if (keyPressed == true) {
    delay(500);
    getReady = false;
    playGame = true;
  }
}

void gameOver() {
  // display the final score
  fill(white);
  textFont(fontMedium);
  textAlign(LEFT, TOP);
  text("LIVES: " + lives, 10, 10);
  textAlign(RIGHT, TOP);
  text("SCORE:       ", 950, 10); // allow space for a really good score
  text(score, 950, 10);

  // flash GAME OVER screen
  if (millis() % 1000 < 600) {
    textFont(fontTitle);
    textAlign(CENTER, BOTTOM);
    fill(red);
    text("GAME OVER", 480, 360);
    textFont(fontMedium);
    textAlign(CENTER, TOP);
    fill(yellow);
    text("PRESS ANY KEY TO PLAY AGAIN", 480, 480);
  }

  // detect key press to play again
  if (keyPressed == true) {
    delay(500);
    resetGame();
  }
}

void resetGame() {
  // reset game variables to allow replay
  lives = 3;
  score = 0;
  extraLife = 1000;
  gameOver = false;
  playGame = true;
  rocket = new Rocket();
  meteor = new Meteor(40, 1, random(-3, 3));
}

void allOver() {
  // display the final score
  background(black);
  fill(white);
  textFont(fontMedium);
  textAlign(LEFT, TOP);
  text("LIVES: " + lives, 10, 10);
  textAlign(RIGHT, TOP);
  text("SCORE:       ", 950, 10); // allow space for a really good score
  text(score, 950, 10);

  // flash GAME OVER screen
  if (millis() % 1000 < 600) {
    textFont(fontTitle);
    textAlign(CENTER, BOTTOM);
    fill(red);
    text("GAME OVER", 480, 360);
    textFont(fontMedium);
    textAlign(CENTER, TOP);
    fill(green);
    text("PRESS ANY KEY WHEN READY", 480, 480);
  }

  // detect key press to show stats
  if (keyPressed == true) {
    JOptionPane.showMessageDialog(null, "Well done, " + player.getName() + "!\n\n"
      + "Statistics\nGames played: "+ gamesPlayed
      + "\n\n" + player.toString()
      + "\n\n Best score: " + player.highScore()
      + "\n Average score: " + player.averageScore()
      + "\n Worst score: " + player.lowScore());
    exit();
  }
}

/*
 * Key handling section
 */

void keyPressed() {
  // move rocket when key pressed
  // pattern: Q W E
  //          A + D
  //          Z X C
  // (also UP DOWN LEFT RIGHT)
  if ((key == 'q') || (key == 'Q') || (key == 'w') || (key == 'W') || (key == 'e') || (key == 'E') || (keyCode == UP)) {
    up = true;
  }
  if ((key == 'z') || (key == 'Z') || (key == 'x') || (key == 'X') || (key == 'c') || (key == 'C') || (keyCode == DOWN)) {
    down = true;
  }
  if ((key == 'q') || (key == 'Q') || (key == 'a') || (key == 'A') || (key == 'z') || (key == 'Z') || (keyCode == LEFT)) {
    left = true;
  }
  if ((key == 'e') || (key == 'E') || (key == 'd') || (key == 'D') || (key == 'c') || (key == 'C') || (keyCode == RIGHT)) {
    right = true;
  }
  // fire Laser when S, SPACE or SHIFT pressed
  if ((key == 's') || (key == 'S') || (key == ' ') || (keyCode == SHIFT)) {
    fire = true;
  }
}

void keyReleased() {
  // reset all when key released
  if ((key == 'q') || (key == 'Q') || (key == 'w') || (key == 'W') || (key == 'e') || (key == 'E') || (keyCode == UP)) {
    up = false;
  }
  if ((key == 'z') || (key == 'Z') || (key == 'x') || (key == 'X') || (key == 'c') || (key == 'C') || (keyCode == DOWN)) {
    down = false;
  }
  if ((key == 'q') || (key == 'Q') || (key == 'a') || (key == 'A') || (key == 'z') || (key == 'Z') || (keyCode == LEFT)) {
    left = false;
  }
  if ((key == 'e') || (key == 'E') || (key == 'd') || (key == 'D') || (key == 'c') || (key == 'C') || (keyCode == RIGHT)) {
    right = false;
  }
  if ((key == 's') || (key == 'S') || (key == ' ') || (keyCode == SHIFT)) {
    fire = false;
  }
}

/*
 * Collision detection section
 */

boolean crashRocket(Rocket rocket, Meteor meteor) {
  // check if rocket has hit the meteor

  if (rocketRespawn == 0) {
    // measure distance between rocket and meteor
    float xDistanceRocketMeteor = abs(rocket.getXCoord() + rocket.getRocketWidth()/2 - meteor.getXCoord());
    float yDistanceRocketMeteor = abs(rocket.getYCoord() - meteor.getYCoord());

    // if too far away, no collision
    if (xDistanceRocketMeteor > (rocket.getRocketWidth()/2 + meteor.getRadius()/2)) {
      return false;
    }
    if (yDistanceRocketMeteor > (rocket.getRocketHeight()/2 + meteor.getRadius()/2)) {
      return false;
    }

    // if head on, collision
    if (xDistanceRocketMeteor <= rocket.getRocketWidth()/2) {
      rocketRespawn = 90;
      return true;
    }
    if (yDistanceRocketMeteor <= rocket.getRocketWidth()/2) {
      rocketRespawn = 90;
      return true;
    }

    float cornerDistance = pow(xDistanceRocketMeteor - rocket.getRocketWidth()/2, 2) + pow(yDistanceRocketMeteor - rocket.getRocketHeight()/2, 2);
    if (cornerDistance <= pow(meteor.getRadius()/2, 2)) {
      rocketRespawn = 90;
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}

boolean hitMeteor(Rocket rocket, Meteor meteor) {
  // check if laser has hit the target

  if ((rocket.getYCoord() >= (meteor.getYCoord() - meteor.getRadius())) && (rocket.getYCoord() <= (meteor.getYCoord() + meteor.getRadius()))) {
    laserRecharge = 30; // cannot fire laser for half a second after hitting a meteor
    return true;
  } else {
    return false;
  }
}

boolean scoreBonus(Rocket rocket, Bonus bonus) {
  // check if rocket has caught the bonus
  // use 15px for bonus

  if (rocketRespawn == 0 && bonusState == true) {
    // measure distance between rocket and meteor
    float xDistanceRocketBonus = abs(rocket.getXCoord() + rocket.getRocketWidth()/2 - bonus.getXCoord());
    float yDistanceRocketBonus = abs(rocket.getYCoord() - bonus.getYCoord());

    // if too far away, no collision
    if (xDistanceRocketBonus > (rocket.getRocketWidth()/2 + 15)) {
      return false;
    }
    if (yDistanceRocketBonus > (rocket.getRocketHeight()/2 + 15)) {
      return false;
    }

    // if head on, collision
    if (xDistanceRocketBonus <= rocket.getRocketWidth()/2) {
      return true;
    }
    if (yDistanceRocketBonus <= rocket.getRocketWidth()/2) {
      return true;
    }

    float cornerDistance = pow(xDistanceRocketBonus - rocket.getRocketWidth()/2, 2) + pow(yDistanceRocketBonus - rocket.getRocketHeight()/2, 2);
    if (cornerDistance <= pow(15/2, 2)) {
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}
