/* 
 Class: Player
 used for scoring/player details
 derived from Player class in Pong game
 */

public class Player {

  // fields

  private String name;
  private int[] scores;
  private int counter;

  // constructors

  public Player(String name, int games) {
    if (name.length() < 3) {
      this.name = name;
    } else {
      this.name = name.substring(0, 3);
    }
    scores = new int[games];
    counter = 0;
  }

  // getters

  public String getName() {
    return name;
  }

  public int[] getScores() {
    return scores;
  }

  // setters

  public void setName(String name) {
    this.name = name.substring(0, 3);
  }

  public void setScores(int[] scores) {
    this.scores = scores;
  }

  // methods

  // add score to scores array
  public void addScore(int score) {
    if (score >= 0) {
      scores[counter] = score;
      counter++;
    }
  }

  // method for highest score
  public int highScore() {
    int highScore = scores[0];
    for (int i = 1; i < counter; i++) {
      if (scores[i] > highScore) {
        highScore = scores[i];
      }
    }
    return highScore;
  }

  public int lowScore() {
    int lowScore = scores[0];
    for (int i = 1; i < counter; i++) {
      if (scores[i] < lowScore) {
        lowScore = scores[i];
      }
    }
    return lowScore;
  }

  public int averageScore() {
    int allScores = 0;
    for (int i = 0; i < counter; i++) {
      allScores = allScores + scores[i];
    }
    return (allScores / counter);
  }

  // return string with score
  public String toString() {
    String str = "Scores for " + name + "\n\n";
    for (int i = 0; i < counter; i ++) {
      str = str + "Score " + (i + 1) + ": " + scores[i] + "\n";
    }
    return str;
  }
}
