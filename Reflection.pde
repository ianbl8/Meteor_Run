/* 
Name: Ian Blake 
Student Number: 20099862

Assignment 2
REFLECTION

Section A
---------
A1 - Readme - included
A2 - Reflection - included, with relevant examples with line numbers 
A3 - Video - included

Section A - 1+5+5 = 11 marks


Section B
---------
B1 - Comments - inline used (eg lines 19, 25, 26) and multiline used (eg top lines of each class)
B2 - Indentation - all tabs auto-tidied
B3 - Naming - meaningful names used eg laserRecharge (line 25) and rocketRespawn (line 26) 
B4 - Structure - main program, classes, Readme and Reflection files all included

Section B - 1+1+1+1 = 4 marks


Section C - Loops, Conditions, Nesting
---------
- use of for (eg starting at line 67), while (eg starting at lines 259, 267) and do ... while (eg starting at line 263)
- use of if ... else (eg lines 78-221 showing mutliple branches)
- nesting (within draw(), eg conditions starting at lines 110, 137, 133)

Section C - 5 marks


Section D - Game, key handling and collision detection
---------
D1 - Working game - with scoring and lives

D2 - Handling key events - 8 way directions plus firing (lines 380-425)
   - keyPressed() (lines 384-406)
   - keyReleased() (lines 408-425)

D3 - Collision detection - 3 combinations between 3 objects (lines 427-514)
   - between rocket and meteor (lines 431-467)
   - between laser and meteor (lines 469-478)
   - between rocket and bonus (lines 480-514)

Section D - 4+8+7 = 21 marks


Section E - Classes
---------
E1 - Classes created
5 classes - Bonus, Laser, Meteor, Rocket, Star
- Bonus (fields lines 10-13, constructors incl overloaded lines 15-26, getters lines 28-40, setters lines 42-62)
- Laser (fields lines 12-16, constructors incl overloaded lines 18-30, getters lines 32-44, setters lines 46-70)
- Meteor (fields lines 13-18, constructors incl overloaded lines 20-38, getters lines 40-72, setters lines 74-124)
- Rocket (fields lines 11-16, constructors incl overloaded lines 18-32, getters lines 34-50, setters lines 52-81)
- Star (fields lines 11-14, constructors incl overloaded lines 16-26, getters lines 28-36, setters lines 38-54)

E2 - Class bespoke methods
- with no return value
  - in Bonus, display() lines 66-79, update() lines 81-90, collected() lines 92-95
  - in Laser, display() lines 74-86
  - in Meteor, display() lines 128-140, update() lines 142-161, hit() lines 163-178, destroyed() lines 180-187
  - in Rocket, display() lines 85-92
  - in Star, display() lines 58-64, update() lines 66-75
- none with return value, parameters or overloading (although some change variables referred to elsewhere, eg Bonus update() lines 81-90 and Bonus collected() lines 92-95)

E3 - Class use
- classes declared in their tabs (Bonus line 8, Laser line 9, Meteor line 11, Rocket line 8, Star line 8)
- classes initialsed in lines 10-15
- constructors called
  - Bonus in line 111 (when generated)
  - Laser in lines 191 and 196 (when fired)
  - Meteor in line 65 and 342 (overloaded)
  - Rocket in lines 64, 150 and 341
  - Star in lines 66-71 (array)
- getters called
  - Meteor for bonus generation in line 111 (meteor.getBonusXCoord() and meteor.getBonusYCoord() called)
  - Rocket for movement in lines 171-184 (rocket.getXCoord() and rocket.getYCoord() called)
  - Meteor and Rocket for laser firing in lines 186-200 (rocket.getXCoord(), rocket.getYCoord(), rocket.getRocketWidth() and meteor.getXCoord() called)
  - Meteor and Rocket for collision detection in lines 431-467 (rocket.getXCoord(), rocket.getYCoord(), rocket.getRocketWidth(), rocket.getRocketHeight(), meteor.getRadius() and meteor.getXCoord() called)
  - Meteor and Rocket for collision detection in lines 469-478 (rocket.getYCoord(), meteor.getRadius() and meteor.getYCoord() called) 
  - Bonus and Meteor for collision detection in lines 480-514 (rocket.getXCoord(), rocket.getYCoord(), rocket.getRocketWidth(), rocket.getRocketHeight(), bonus.getXCoord() and bonus.getyCoord() called)
- setters called
  - Meteor for bonus generation in line 113 (meteor.setGenerateBonus() called)
  - Rocket for movement in lines 171-184 (rocket.setXCoord() and rocket.setYCoord() called)

Section E - 9+5+10 = 24 marks


Section F - Arrays
---------
F1 - Use of arrays
star[] object array (Star) initialised line 15, random values generated lines 66-71, used to display and update lines 119-123

F2 - Calculations using arrays
Only within Player class - scores[] int array used to record scores and calculate high, low and average scores in Player lines 57-84 

Section F - 5+5 = 10 marks


Total marks = 11+4+5+21+24+10 = 75
Complexity multiplier = x0.9
Final mark = 68

*/
