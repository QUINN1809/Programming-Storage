 int boxcount = 10; // this is how many boxes you have
 int counter = 0;

 bool snakeCollide = false; //makes snake die when touching itself
 bool increaseSize = false; //makes snake bigger

 bool preventDoubleTeleport = true;

 int snakeMove = 40; //distance snake moves
 int snakeSize = 40; //size of the snake
 int snakeIncrease = 3; //how much the snake lengthens after eating apple

 int appleSize = 35; //size of the apple
 int teleporterSize = 35;

 float[] boxX = new float[boxcount]; // this creates the array "boxX"
 float[] boxY = new float[boxcount]; // this creates the array "boxY"

 bool snakeLeft = false; //the direction the snake is going in
 bool snakeRight = false; //the direction the snake is going in
 bool snakeUp = false; //the direction the snake is going in
 bool snakeDown = false; //the direction the snake is going in

 int squares = 32; //How many squares to a side?
 int boardSize = 1280; //Set pixel size for the board itself within the window.
 float dx = boardSize / squares; //Size of each square in the board

 int r = 94; //red
 int g = 70; //green
 int b = 47; //blue



 void setup() {

     appleRandomX = int(random(1, 30)) * 40 - 20; //creates the position for the apple
     appleRandomY = int(random(1, 18)) * 40 - 20; //creates the position for the apple
     appleRandomX2 = int(random(1, 30)) * 40 - 20; //creates the position for the apple
     appleRandomY2 = int(random(1, 18)) * 40 - 20; //creates the position for the apple
     appleRandomX3 = int(random(1, 30)) * 40 - 20; //creates the position for the apple
     appleRandomY3 = int(random(1, 18)) * 40 - 20; //creates the position for the apple

     teleporterRandomX = int(random(1, 30)) * 40 - 20; //creates the position for the teleporter
     teleporterRandomY = int(random(1, 18)) * 40 - 20; //creates the position for the teleporter
     teleporter2RandomX = int(random(1, 30)) * 40 - 20; //creates the position for the teleporter
     teleporter2RandomY = int(random(1, 18)) * 40 - 20; //creates the position for the teleporter

     boxcount = 10;

     snakeMove = 40;

     size(1200, 720);
     background(100);
     rectMode(CENTER); // draws the rectangle with Center mode started.

     snakeCollide = false;

     for (int i = 0; i < boxcount; i++) {
         boxX[i] = 620; // starting horizontal position of snake
         boxY[i] = 380; // starting verticle position of snake
     }
 }



 void draw() {

     drawCheckerboard()
     apple();
     teleporter();
     display();
     keyPressed();
     snakeDeath();
     snakeRun();
     snakeTouch();
     frameRate(8);

 }

 void display() {

     for (int i = 0; i < boxcount; i++) { // this will loop through and draw the boxes based on the array.
         noStroke(); //removes outline of the snake boxes
         fill(120, 255, 100); // colour of the snake
         rect(boxX[i], boxY[i], snakeSize, snakeSize); //  draws the snake boxes

         snakeEye(); //eyes of the snake

         score();
     }
 }



 void snakeEye() {
     if (key == CODED) {
         if ((keyCode == LEFT) && (snakeRight == false)) { //snake's eyes looking left
             fill(0); //colour of snake's eye
             rect(boxX[0] - 10, boxY[0] + 10, 10, 10);
             rect(boxX[0] - 10, boxY[0] - 10, 10, 10);
             fill(255); //colour of snake's iris
             rect(boxX[0] - 10, boxY[0] + 10, 3, 3);
             rect(boxX[0] - 10, boxY[0] - 10, 3, 3);
         } else if ((keyCode == UP) && (snakeDown == false)) { //snake's eyes looking up
             fill(0); //colour of snake's eye
             rect(boxX[0] - 10, boxY[0] - 10, 10, 10);
             rect(boxX[0] + 10, boxY[0] - 10, 10, 10);
             fill(255); //colour of snake's iris
             rect(boxX[0] - 10, boxY[0] - 10, 3, 3);
             rect(boxX[0] + 10, boxY[0] - 10, 3, 3);
         } else if ((keyCode == DOWN) && (snakeUp == false)) { // snake's eyes looking down
             fill(0); //colour of snake's eye
             rect(boxX[0] + 10, boxY[0] + 10, 10, 10);
             rect(boxX[0] - 10, boxY[0] + 10, 10, 10);
             fill(255); //colour of snake's iris
             rect(boxX[0] + 10, boxY[0] + 10, 3, 3);
             rect(boxX[0] - 10, boxY[0] + 10, 3, 3);
         } else if ((keyCode == RIGHT) && (snakeLeft == false)) { // snake's eyes looking right
             fill(0); //colour of snake's eye
             rect(boxX[0] + 10, boxY[0] - 10, 10, 10);
             rect(boxX[0] + 10, boxY[0] + 10, 10, 10);
             fill(255); //colour of snake's iris
             rect(boxX[0] + 10, boxY[0] - 10, 3, 3);
             rect(boxX[0] + 10, boxY[0] + 10, 3, 3);
         } if ((keyCode == RIGHT) && (snakeLeft == true)) { //snake's eyes looking left
             fill(0); //colour of snake's eye
             rect(boxX[0] - 10, boxY[0] + 10, 10, 10);
             rect(boxX[0] - 10, boxY[0] - 10, 10, 10);
             fill(255); //colour of snake's iris
             rect(boxX[0] - 10, boxY[0] + 10, 3, 3);
             rect(boxX[0] - 10, boxY[0] - 10, 3, 3);
         } else if ((keyCode == DOWN) && (snakeUp == true)) { //snake's eyes looking up
             fill(0); //colour of snake's eye
             rect(boxX[0] - 10, boxY[0] - 10, 10, 10);
             rect(boxX[0] + 10, boxY[0] - 10, 10, 10);
             fill(255); //colour of snake's iris
             rect(boxX[0] - 10, boxY[0] - 10, 3, 3);
             rect(boxX[0] + 10, boxY[0] - 10, 3, 3);
         } else if ((keyCode == UP) && (snakeDown == true)) { // snake's eyes looking down
             fill(0); //colour of snake's eye
             rect(boxX[0] + 10, boxY[0] + 10, 10, 10);
             rect(boxX[0] - 10, boxY[0] + 10, 10, 10);
             fill(255); //colour of snake's iris
             rect(boxX[0] + 10, boxY[0] + 10, 3, 3);
             rect(boxX[0] - 10, boxY[0] + 10, 3, 3);
         } else if ((keyCode == LEFT) && (snakeRight == true)) { // snake's eyes looking right
             fill(0); //colour of snake's eye
             rect(boxX[0] + 10, boxY[0] - 10, 10, 10);
             rect(boxX[0] + 10, boxY[0] + 10, 10, 10);
             fill(255); //colour of snake's iris
             rect(boxX[0] + 10, boxY[0] - 10, 3, 3);
             rect(boxX[0] + 10, boxY[0] + 10, 3, 3);
         }
     
     }
     
 }



 void score() {//makes the score at the top of the sketch

     fill(255);
     textSize(30);
     textAlign(CENTER);
     text(boxcount - 1, width / 2 + 40, 50);

     fill(255);
     textSize(30);
     textAlign(CENTER);
     text('Length:', width / 2 - 40, 50);
 }



 void drawCheckerboard() {//creates the checkerboard in the background
     for (int i = 0; i < squares; i++) { 
         for (int j = 0; j < squares; j++) {
             fill(r, g, b); 
             rect(j * dx - 20, i * dx - 20, dx, dx); //draw the squares

             if (r == 94) { //switches the colour of the columns
                 r = 143;
                 g = 127;
                 b = 96;
             } else {
                 r = 94;
                 g = 70;
                 b = 47;
             }
         }
         if ((squares % 2 == 0) && (r == 94)) { // turns the columns into squares
             r = 143;
             g = 127;
             b = 96;
         } else if ((squares % 2 == 0) && (r == 143)) {
             r = 94;
             g = 70;
             b = 47;
         }
     }
 }

 void snake() {//snake array

     for (int i = boxcount - 1; i > 0; i--) {
         boxX[i] = boxX[i - 1];
         boxY[i] = boxY[i - 1];
     }

     counter = counter + 1;

     if (counter > boxcount - 1) {
         counter = 0;
     }
 }



 void snakeRun() {
     if (snakeLeft == true) {
         boxX[0] = boxX[0] - snakeMove;
     }//makes the snake move
     if (snakeRight == true) {
         boxX[0] = boxX[0] + snakeMove;
     }//makes the snake move
     if (snakeUp == true) {
         boxY[0] = boxY[0] - snakeMove;
     }//makes the snake move
     if (snakeDown == true) {
         boxY[0] = boxY[0] + snakeMove;
     }//makes the snake move
     if ((snakeDown == true) || (snakeRight == true) || (snakeLeft == true) || (snakeUp == true)) {
         snakeCollide = true;
     }//activates boolean involved in snakeTouch
 }



 void keyPressed() {
     if (key == CODED) {
         if ((keyCode == LEFT) && (snakeRight == false)) { //moves snake left
             snakeLeft = true;
             snakeRight = false;
             snakeUp = false;
             snakeDown = false;
         } else if ((keyCode == UP) && (snakeDown == false)) { //moves snake up
             snakeLeft = false;
             snakeRight = false;
             snakeUp = true;
             snakeDown = false;
         } else if ((keyCode == DOWN) && (snakeUp == false)) { //moves snake down
             snakeLeft = false;
             snakeRight = false;
             snakeUp = false;
             snakeDown = true;
         } else if ((keyCode == RIGHT) && (snakeLeft == false)) { //moves snake right
             snakeLeft = false;
             snakeRight = true;
             snakeUp = false;
             snakeDown = false;
         }
         snake();
     }
 }



 void snakeTouch() {//makes the snake die when touching itself

     if ((snakeDown == true) || (snakeRight == true) || (snakeLeft == true) || (snakeUp == true)) {
         snakeCollide = true;
     }

     for (int i = 0; i < boxcount; i++) {

         if ((boxX[0] == boxX[i + 1]) && (boxY[0] == boxY[i + 1]) && (snakeCollide == true)) {

             snakeMove = 0;//prevents snake from moving out of death zone

             background(0);//creates the gamerover screen

             snakeDown = false;//prevents snake from moving out of death zone
             snakeUp = false;//prevents snake from moving out of death zone
             snakeRight = false;//prevents snake from moving out of death zone
             snakeLeft = false;//prevents snake from moving out of death zone

             fill(255);//creates the gameover screen
             textSize(140);//creates the gameover screen
             textAlign(CENTER);//creates the gameover screen
             text("GAME OVER", width / 2, height / 2);//creates the gameover screen

             if (keyPressed) {
                 if (key == ' ') {
                     setup()//resets the sketch//creates the gameover screen
                 }
             }
         }
     }
 }



 void snakeDeath() {//snake dies when touching border

     for (int i = 0; i < boxcount; i++) {
         if ((boxX[0] < 0) || (boxX[0] > width) || (boxY[0] > height) || (boxY[0] < 0)) {

             background(0);//creates the gameover screen

             snakeMove = 0;//prevents snake from moving out of death zone

             snakeDown = false;//prevents snake from moving out of death zone
             snakeUp = false;//prevents snake from moving out of death zone
             snakeRight = false;//prevents snake from moving out of death zone
             snakeLeft = false;//prevents snake from moving out of death zone

             fill(255);//creates the gameover screen
             textSize(140);//creates the gameover screen
             textAlign(CENTER);//creates the gameover screen
             text("GAME OVER", width / 2, height / 2);//creates the gameover screen

             if (keyPressed) {
                 if (key == ' ') {
                     setup()//resets the sketch
                 }
             }
         }
     }
 }

void teleporter() {

    fill(200, 10, 220);
    strokeWeight(2);
    stroke(106, 215, 230);
    ellipse(teleporterRandomX, teleporterRandomY, teleporterSize / 1.5, teleporterSize);//making 1st teleporter

    fill(200, 10, 220);
    strokeWeight(2);
    stroke(106, 215, 230);
    ellipse(teleporter2RandomX, teleporter2RandomY, teleporterSize / 1.5, teleporterSize);//making 2nd teleporter

    for (int i = 0; i < boxcount; i++) {
        if ((teleporterRandomX == boxX[0]) && (teleporterRandomY == boxY[0]) && (preventDoubleTeleport == true)) {//teleports the snake
            boxX[0] = teleporter2RandomX;
            boxY[0] = teleporter2RandomY;
            preventDoubleTeleport = false;//prevents the snake from teleporting instantly back
        }
        if ((teleporter2RandomX == boxX[0]) && (teleporter2RandomY == boxY[0]) && (preventDoubleTeleport == true)) {//teleports the snake
            boxX[0] = teleporterRandomX;
            boxY[0] = teleporterRandomY;
            preventDoubleTeleport = false;
        }

    }
    preventDoubleTeleport = true;
}



void apple() {

    fill(230, 40, 46);
    strokeWeight(2);
    stroke(184, 18, 0);

    rect(appleRandomX, appleRandomY, appleSize, appleSize, appleRandomY, 3);// draws the apple

    if ((appleRandomY < 0) || (appleRandomY > height)) {
        appleRandomY = int(random(18)) * 40 - 20;
    } //prevents the apple from spawning off screen
    if ((appleRandomX < 0) || (appleRandomX > width)) {
        appleRandomX = int(random(30)) * 40 - 20;
    } //prevents the apple from spawning off screen

    for (int i = 0; i < boxcount; i++) {

        if ((appleRandomX == boxX[i + 1]) && (appleRandomY == boxY[i + 1])) {
            appleRandomX = int(random(30)) * 40 - 20;
            appleRandomY = int(random(18)) * 40 - 20;
        } // prevents the apple from spawning on the snake

        if ((boxX[0] == appleRandomX) && (boxY[0] == appleRandomY)) {

            appleRandomX = int(random(30)) * 40 - 20; // makes new apple
            appleRandomY = int(random(18)) * 40 - 20; // makes new apple

            increaseSize = true;

            if (increaseSize == true) {
                boxcount = boxcount + snakeIncrease;
            } //increases size of snake

        } else {
            increaseSize = false;
        }
    }


    rect(appleRandomX2, appleRandomY2, appleSize, appleSize, appleRandomY2, 3);//2nd apple

    if ((appleRandomY2 < 0) || (appleRandomY2 > height)) {
        appleRandomY2 = int(random(18)) * 40 - 20;
    } //prevents the apple from spawning off screen
    if ((appleRandomX2 < 0) || (appleRandomX2 > width)) {
        appleRandomX2 = int(random(30)) * 40 - 20;
    } //prevents the apple from spawning off screen

    for (int i = 0; i < boxcount; i++) {

        if ((appleRandomX2 == boxX[i + 1]) && (appleRandomY2 == boxY[i + 1])) {
            appleRandomX2 = int(random(30)) * 40 - 20;
            appleRandomY2 = int(random(18)) * 40 - 20;
        } // prevents the apple from spawning on the snake

        if ((boxX[0] == appleRandomX2) && (boxY[0] == appleRandomY2)) {

            appleRandomX2 = int(random(30)) * 40 - 20; // makes new apple
            appleRandomY2 = int(random(18)) * 40 - 20; // makes new apple

            increaseSize = true;

            if (increaseSize == true) {
                boxcount = boxcount + snakeIncrease;
            } //increases size of snake

        } else {
            increaseSize = false;
        }
    }

    rect(appleRandomX3, appleRandomY3, appleSize, appleSize, appleRandomY3, 3);//3rd apple

    if ((appleRandomY3 < 0) || (appleRandomY3 > height)) {
        appleRandomY3 = int(random(18)) * 40 - 20;
    } //prevents the apple from spawning off screen
    if ((appleRandomX3 < 0) || (appleRandomX3 > width)) {
        appleRandomX3 = int(random(30)) * 40 - 20;
    } //prevents the apple from spawning off screen

    for (int i = 0; i < boxcount; i++) {

        if ((appleRandomX3 == boxX[i + 1]) && (appleRandomY3 == boxY[i + 1])) {
            appleRandomX3 = int(random(30)) * 40 - 20;
            appleRandomY3 = int(random(18)) * 40 - 20;
        } // prevents the apple from spawning on the snake

        if ((boxX[0] == appleRandomX3) && (boxY[0] == appleRandomY3)) {

            appleRandomX3 = int(random(30)) * 40 - 20; // makes new apple
            appleRandomY3 = int(random(18)) * 40 - 20; // makes new apple

            increaseSize = true;

            if (increaseSize == true) {
                boxcount = boxcount + snakeIncrease;
            } //increases size of snake

        } else {
            increaseSize = false;
        }
    }

}// please ignore the pure laziness here. I could make this code 30 lines shorter, but I don't want to break it.

