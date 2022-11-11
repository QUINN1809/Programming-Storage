
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
