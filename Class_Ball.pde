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
