//ATARI BREAKOUT
//Quinn Ivison


int Rows = 8; //amount of rows the blocks have
int Columns = 8; // amount of columns the blocks have
int Total = Rows * Columns; // amount of blocks

Ball balls = new Ball(); //class ball
Brick[] box = new Brick[Total]; //array of blocks

color BrickGreen = color(8, 112, 138);//colour of the bricks
color OutlineGreen = color(3, 82, 102);//colour of the bricks
color BrickPink = color(237, 30, 131);//colour of the bricks
color OutlinePink = color(179, 14, 85);//colour of the bricks
color BrickBlue = color(39, 39, 96);//colour of the bricks
color OutlineBlue = color(39, 39, 80);//colour of the bricks
color BackgroundColour = color(0);//colour of the background
color BorderColour = color(59, 4, 28);//colour of the border

boolean GameSwitch = false; //activates the gameover screen
boolean RegenBool = true; //prevents the blocks from regenerating in a loop
boolean CurtainRecede = false; //begins the border shrink

int BorderReceding = 5; //how fast the border shrinks at the start of the game
int BorderThickness = 300; //the thickness of the outside border divided 

int ScoreNumber = 0; //the score
int Lives = 3; //amount of lives the player has

int TextColour = 255;//colour of text
int TextBlink = 20; //interval in which the gameover text blinks
int GameOverText = 0; //integer which activates the blinking
int TextSize = 60; //size of text at the begin screen




void setup() {
  size(600, 850); //size of canvas
  rectMode(CENTER); //aligns text to middle
  //frameRate(20);
  for (int i = 0; i < Rows; i++) {// creates rows of blocks
    for (int j = 0; j < Columns; j++) {// creates columns of blocks
      box[i * Rows + j] = new Brick((i + 1) * width / (Rows + 2), (j + 1) * 50); //places all the bricks into the array, properly labelled.
    }
  }
}




void draw() {
  landscape(); //draws the background
  paddle(); //draws the paddle
  ballBounce(); //makes the ball bounce
  ballOffScreen(); //respawns the ball when it falls off the screen
  words(); //makes the score
  gameOver(); //creates the gameover screen
  regenerateBlocks(); //respawns the blocks
  gameBegin();//start screen
}




void landscape() {
    background(0);//colour of canvas background
  fill(0); //colours the background
  rect(width / 2, height / 2, width, height); //draws the background rectangle
  noFill(); //doesn't fill in the outline rectangle
  strokeWeight(BorderThickness * 2); //thickness of border
  stroke(BorderColour); //colour of the border
  rect(width / 2, height / 2, width, height); //draws the hollow rectangle
}




void paddle() {
  fill(BorderColour); //colours the paddle
  strokeWeight(2); //outline of paddle
  stroke(255); // colour of paddle outline
  if (mouseX > width - 110) {//if mouse is against right wall
    rect(width - 110, height - 100, 200, 10); //draws rectangle against right wall
  }
  if (mouseX < 110) {//if mouse is against left wall
    rect(110, height - 100, 200, 10); //draws rectangle against left wall
  }
  if ((mouseX <= (width - 110)) && (mouseX >= 110)) {//if mouse is in the middle of the screen
    rect(mouseX, height - 100, 200, 10); //draws rectangle following mouse
  }
}




void ballBounce() {

  for (int i = 0; i < Total; i++) {
    box[i].update(); //draws the blocks
  }

  balls.update(); //draws the ball
  balls.wallBounce();//balls bounce on left and right wall
  balls.ceilingBounce();//balls bounce on ceiling

  for (int i = 0; i < Total; i++) {
    //If ball hits bottom of brick, ball moves down, increment score
    if (balls.bally - balls.D / 2 <= box[i].bricky + box[i].brickHeight && balls.bally - balls.D / 2 >= box[i].bricky && balls.ballx + balls.D/4 >= box[i].brickx && balls.ballx - balls.D/4 <= box[i].brickx + box[i].brickWidth && box[i].hit == false) {
      balls.goDown(); //changes direction of ball
      box[i].gotHit(); //registers a hit on the box
      ScoreNumber += 1; //increases the score when a block is hit
    }

    //If ball hits top of brick ball moves up, increment score
    if (balls.bally + balls.D / 2 >= box[i].bricky && balls.bally - balls.D / 2 <= box[i].bricky + box[i].brickHeight / 2 && balls.ballx + balls.D/4 >= box[i].brickx && balls.ballx - balls.D/4 <= box[i].brickx + box[i].brickWidth && box[i].hit == false) {
      balls.goUp(); //changes direction of ball
      box[i].gotHit(); //registers a hit on the box
      ScoreNumber += 1; //increases the score when a block is hit
    }

    //if ball hits the left of the brick, ball switches to the right, and moves in same direction, increment score
    if (balls.ballx + balls.D / 2 >= box[i].brickx && balls.ballx + balls.D / 2 <= box[i].brickx + box[i].brickWidth / 2 && balls.bally >= box[i].bricky && balls.bally <= box[i].bricky + box[i].brickHeight && box[i].hit == false) {
      balls.goLeft(); //changes direction of ball
      box[i].gotHit(); //registers a hit on the box
      ScoreNumber += 1; //increases the score when a block is hit
    }

    //if ball hits the right of the brick, ball switches to the left, and moves in same direction, increment score
    if (balls.ballx - balls.D / 2 <= box[i].brickx + box[i].brickWidth && balls.ballx + balls.D / 2 >= box[i].brickx + box[i].brickWidth / 2 && balls.bally >= box[i].bricky && balls.bally <= box[i].bricky + box[i].brickHeight && box[i].hit == false) {
      balls.goRight(); //changes direction of ball
      box[i].gotHit(); //registers a hit on the box
      ScoreNumber += 1; //increases the score when a block is hit
    }

    if (((balls.ballx < mouseX + 100) && (balls.ballx >= mouseX - 100)) && ((balls.bally > height - 120) && (balls.bally < height - 100))) { //ball bounces on paddle
      balls.goUp(); //changes direction of ball
      balls.variableMove(); //changes direction of ball
    }

    if ((mouseX > width - 110) && ((balls.ballx >= width - 210) && ((balls.bally > height - 120) && (balls.bally < height - 100)))) { //ball bounces on left side of paddle when ball is against the right wall
      balls.goUp(); //changes direction of ball
      balls.goLeft(); //changes direction of ball
    }

    if ((mouseX < 110) && ((balls.ballx <= 210) && ((balls.bally > height - 120) && (balls.bally < height - 100)))) { //ball bounces on right side of paddle when ball is against the left wall
      balls.goUp(); //changes direction of ball
      balls.goRight(); //changes direction of ball
    }

    if ((mouseX > width - 110) && ((balls.ballx > width - 110) && ((balls.bally > height - 120) && (balls.bally < height - 100)))) { //ball bounces on right side of paddle when ball is against the right wall
      balls.goUp(); //changes direction of ball
      balls.goRight(); //changes direction of ball
    }

    if ((mouseX < 110) && ((balls.ballx < 110) && ((balls.bally > height - 120) && (balls.bally < height - 100)))) { //ball bounces on left side of paddle when ball is against the left wall
      balls.goUp(); //changes direction of ball
      balls.goLeft(); //changes direction of ball
    }
  }
}




void ballOffScreen() {
  if (((balls.bally + (balls.D + 10)) > height) && (Lives > 0)) { //ball bounces on ceiling
    balls.ballReset(); //resets the ball
    Lives -= 1; //removes a life
  }
  if (((balls.bally + (balls.D + 10)) > height) && (Lives == 0)) { //ball bounces on floor with no lives left
    balls.ballDelete(); //teleports the ball offscreen
    GameSwitch = true; //begins the gameover command
  }
}




void words() {
  fill(255); //colour of text
  textSize(30); //size of text
  textAlign(CENTER); //aligns the text to the middle
  text(ScoreNumber, width - 35, 40); //draws the actual score
  text("Score:", width - 100, 40); //draws the score label
  text(Lives, 105, 40); //draws the actual score
  text("Lives:", 55, 40); //draws the score label
}




void gameOver() {
  if (GameSwitch == true) {
    fill(0); //colours the gameover rectangle
    strokeWeight(10); //outline of gameover reactangle
    stroke(255); //colour of outline
    rect(width / 2, height / 2, 400, 300); //draws the gameover rectangle

    textSize(15); //size of the text
    fill(255); //colours the text
    text("Press Spacebar to Restart the Game", width / 2, height / 2 + 75); //draws the score label

    GameOverText += 1; //makes the gameover text blink
    if (GameOverText > TextBlink) { //makes the gameover text blink
      textSize(60); //size of text
      fill(255); //colour of text
      text("GAMEOVER", width / 2, height / 2 - 15); //draws the score label
      if (GameOverText == TextBlink * 2) { //makes the gameover text blink
        GameOverText = 0; //makes the gameover text blink
      }
    }
    restartGame(); //restarts the game
  }
}




void regenerateBlocks() {
  for (int k = 1; k < 1000; k++) {//creates the list of numbers which will multiply into 64
    if (ScoreNumber == k * 64) { //any score which is a multiple of 64 will respawn the blocks
      if (RegenBool == true) {//prevents code from repeating
        balls.ballReset(); //resets the ball
        for (int i = 0; i < Rows; i++) {//creates rows of bricks
          for (int j = 0; j < Columns; j++) {//creates columns of bricks
            box[i * Rows + j] = new Brick((i + 1) * width / (Rows + 2), (j + 1) * 50); //resets the bricks
          }
        }
        RegenBool = false; //prevents code from repeating
      }
    }
    if (ScoreNumber == k * 64 + 1) { //turns the variable back on after the players score is no longer a multiple of 64
      RegenBool = true;//lets the code work during the next cycle
    }
  }
}




void restartGame() {
  if (keyPressed) { //restarts the game if spacebar is pressed
    if (key == ' ') { //restarts the game if spacebar is pressed
      GameSwitch = false; //turns off the gameover screen
      Lives = 3; //resets the lives
      balls.ballReset(); //resets the ball
      ScoreNumber = 0; //resets the score
      for (int i = 0; i < Rows; i++) {//creates rows of bricks
        for (int j = 0; j < Columns; j++) {//creates columns of bricks
          box[i * Rows + j] = new Brick((i + 1) * width / (Rows + 2), (j + 1) * 50); //resets the bricks
        }
      }
    }
  }
}




void gameBegin() {
  noFill(); //doesn't fill in the outline rectangle
  strokeWeight(BorderThickness * 2); //thickness of border
  stroke(BorderColour); //colour of the border
  rect(width / 2, height / 2, width, height); //draws the hollow rectangle

  fill(TextColour); //colour of text
  textSize(TextSize); //size of text
  text("ATARI BREAKOUT", width / 2, height / 2); //draws the actual score

  if (CurtainRecede == false) {//curtain recede is always false until the startup screen is over
    balls.ballReset();//prevents ball from moving 
  }

  if (mousePressed == true) {// if the mouse is clicked
    CurtainRecede = true;//activates the start screen animation
  }
  if (CurtainRecede == true) {
    if (TextSize > 1) {//if the text is larger than 1
      TextSize -= 1;//make the text become small 
    } else {
      TextSize = 1;//prevents text from becoming a number below zero
      TextColour=0;//makes the text disapear
    }
    if (BorderThickness > 10) {//if the border is wider than 10
      BorderThickness -= BorderReceding;//make the border shrink
      balls.ballReset();//prevents ball from moving while the border is shrinking
    } else {
      BorderThickness = 10;//stop the border from shrinking at 10
    }
  }
}
//BALL CLASS
class Ball {
  float ballx; //ball x
  float bally; //ball y
  float speedx; //ball velocity in x
  float speedy; //ball velocity in y
  float D; //ball diameter
  float d1; //makes the ball move variably
  float d2; //makes the ball move variably

  //Ball constructor
  Ball() {
    ballx = 300; //ball starting location
    bally = 450; //ball starting location
    speedx = 0; //ball starts moving straght down 
    speedy = 4; //ball starts moving straght down
    D = 10; //diameter of ball
  }

  //Update the ball
  void update() {
    strokeWeight(0); //stroke width of ball
    stroke(0); //colour of ball outline
    fill(255); //colour of ball
    ellipse(ballx, bally, D, D); //draws the ball

    bally += speedy; //increment y
    ballx += speedx; //increment x

    d1 = dist(ballx, height - 100, mouseX - 100, height - 100); //creates the variable speed
    d2 = map(d1, -0, 200, -4, 4); //maps the variable speed
  }

  //sends ball back to starting location
  void ballReset() {
    ballx = 300;
    bally = 450;
    speedx = 0;
    speedy = 4;
  }

  //teleports the ball of screen
  void ballDelete() {
    ballx = 30000;
    bally = 450;
    speedy = 0;
  }

  //Ball bounces on left and right wall
  void wallBounce() {
    if (ballx > width - 20 || ballx < 20) {
      speedx *= -1;
    }
  }

  //Ball bounces on ceiling
  void ceilingBounce() {
    if (bally < 20) {
      speedy = 4;
    }
  }

  //Ball goes left
  void goLeft() {
    speedx *= -1; //decrement x
  }

  //Ball goes right
  void goRight() {
    speedx *= -1; //increment x
  }

  //Ball changes in y direction
  void goDown() {
    speedy = 4;
  }

  //Ball changes in y direction
  void goUp() {
    speedy = -4;
  }

  //ball moves variably
  void variableMove() {
    speedx = d2;
  }
}


//BRICK CLASS
class Brick {

  float brickx; //brick x
  float bricky; //brick y
  float brickWidth; //brick width
  float brickHeight; //brich height
  int ColourFill;//colour of brick
  int ColourOutline;//colour of brick outline
  int Ticker;//randomizes brick colour

  boolean hit; //whether or not the brick has been hit

    //brick constructor
  Brick(float brickx0, float bricky0) {
    brickx = brickx0;
    bricky = bricky0;

    Ticker = int (random(3));//creates random numbers of 0,1,2

    if (Ticker == 0) {//if the number is 0 
      ColourFill = BrickGreen;//make the brick green
      ColourOutline = OutlineGreen;//make the brick green
    }
    if (Ticker == 1) {//if the number is 1
      ColourFill = BrickPink;//make the brick pink
      ColourOutline = OutlinePink;//make the brick pink
    }
    if (Ticker == 2) {//if the number is 2 
      ColourFill = BrickBlue;//make the brick blue
      ColourOutline = OutlineBlue;//make the brick blue
    }

    brickWidth = 50; //brick width
    brickHeight = 25; //brick height

    hit = false; //brick is initially not hit
  }

  //Draws the brick
  void update() {
    stroke(ColourOutline); //colour of brick outline
    fill(ColourFill); //colour of brick
    rect(brickx + brickWidth / 2, bricky + brickHeight / 2, brickWidth, brickHeight); //draws brick
  }

  //What happens to the brick once it gets hit
  void gotHit() {
    hit = true; //brick recognizes that it has been hit
    ColourFill=BackgroundColour;//colours the block to blend in with background
    ColourOutline=BackgroundColour;//colours the block to blend in with background
    rect(brickx + brickWidth / 2, bricky + brickHeight / 2, brickWidth, brickHeight); //draws brick
  }
}
