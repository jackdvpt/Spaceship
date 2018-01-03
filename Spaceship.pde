float x =300;
float y =300;
float direction =0;
float increment =1;
float speed = 5;

int ShipSize = 20; //the size of the ships ellipse

boolean PlayerIsAlive = true; //boolean for controlling the game over state of the game, Controlling if the game acatually runs

boolean SpaceShipFlipDirection = true; //Boolean controlls the directoin of the spaceship

//Worm Hole varaibles
boolean WormHoleSizeGrow = false; //states if the wormhole is growing or shrinking
float WormHoleSize = 0; //The size of the wormhole
float WormHolePosX ; //Wormholes X Position
float WormHolePosY ;  //Wormholes Y Position

// Star Varaibles - The X & Y cordinates for the stars, two Array to store the random location of the stars. This could have been a 2Dimensional array, but i desided against it in the end.
int [] StarPosX = new int [100];
int [] StarPosY = new int [100];


int PlayerScore = 0; //Player Score Varaibles

// The function from the assignemtn used to determine if the spaceship has collided with the wormhole
boolean warp() {
  float WormholeDistance = dist(x, y, WormHolePosX, WormHolePosY); //This varaible is the distance between the X & Y location of the wormhole and Spaceship
  if (WormholeDistance < ShipSize /2 + WormHoleSize / 2) { //If they collide, or the distance is zero then the function returns true, which causes everything to refresh
    return true; //Returning true makes the stars and wormholes location refres
  } else {
    return false; //Returning false just makes the spaceship continue to fly
  }
}

void blackHoleAt (float holeX, float holeY) {
  stroke(255); //Makes the blackholes white, with a black background
  fill(0);
  ellipse(holeX, holeY, 40, 40); //Draws the black hole at the X & Y location given to the function
  float BlackHoleCollision = dist(x, y, holeX, holeY);  //Does the colision in the same way as the warp function
  if (BlackHoleCollision < ShipSize /2 + 40 / 2) {
    PlayerIsAlive = false; //Instead of returning false though, it makes PlayerIsAlive False, which termintes the game and shows the game over screen
  }
}

void setup () {
  size (600, 600);
  
  //Loop and Arrays for the stars
  for (int StarNum =0; StarNum <StarPosX.length; StarNum ++ ) { //gives every position in the arrays a random number, which represents the stars X & Y Positions
    StarPosX [StarNum] = int(random(0, width));  
    StarPosY [StarNum] = int(random(0, height));
  }
  WormHolePosX = int(random(0, width));
  WormHolePosY = int(random(0, height)); //Creaats an initial random number that is where the wormhole first spawns in

}

void draw () {
  if (PlayerIsAlive) { // PlayerIsAlive is a boolean that is always true, unless the player collides with a black hole. Then it shows the game over screen
    
    //Code for making the ship appear on the other side of the screen when it goes off one side. It appears on the other
    if ( x< 0 )  x = width;   //LEFT SIDE
    if ( x > width ) x = 0;   // RIGHT SIDE
    if ( y < 0 ) y = height;  //TOP
    if ( y > height )  y = 0; //BOTTOM
  
    background (#0A0A0A); //Makes the background a slightly off black, simulating the darkness of space

    //Drawing the Stars
    for (int StarArrayNum = 0; StarArrayNum <StarPosX.length; StarArrayNum ++) {
      fill(255);
      point(StarPosX[StarArrayNum], StarPosY[StarArrayNum]);//Draws each star as a point in there random positions
    }

    //Starting Code provided in the assignemtn specs
    x = x + speed * cos ( direction );
    y = y + speed * sin ( direction );

    if (warp()) { //If the space craft collides with the wormhole than this if is implemented
      PlayerScore ++; //increases the player's score
      for (int StarNum =0; StarNum <StarPosX.length; StarNum ++ ) { //gives the stars all new positions
        StarPosX [StarNum] = int(random(0, width));  
        StarPosY [StarNum] = int(random(0, height));
      }
      WormHolePosY = int(random(0, height)); //Gives the wormhole new cordinates
      WormHolePosX = int(random(0, width));
    } 

    if (SpaceShipFlipDirection) { // flips the spaceship 
      direction = direction - increment * 0.03; //Makes the spaceship travel in a clockwise direction
    } else {
      direction = direction + increment * 0.03; //Makes the spaceship travel in an anti-clockwise direction
    } 

    fill(155); //Colour for the spaceship
    noStroke();
    ellipse (x, y, ShipSize, ShipSize); //Draws the Space craft

    if (WormHoleSize >=80) { //If the wormhole hits its max size then the boolean is set to false, and the wormhole starts to shrink
      WormHoleSizeGrow = false;
    } else if (WormHoleSize < 1) { //If the wormhole hits 1, then the boolean is set to true and it begins to grow again. 
      WormHoleSizeGrow = true;
    }
    if (WormHoleSizeGrow == true) {
      WormHoleSize ++; //Makes the wormhole grow, until it hits its max size
    } else if (WormHoleSizeGrow == false) {
      WormHoleSize --; //Makes the wormhole shrink until it hits ist minimum size
    }

    fill(240); //Makes the Wormhole white
    ellipse (WormHolePosX, WormHolePosY, WormHoleSize, WormHoleSize); //Draws the wormhole, with the random positions set before

      textSize(16); //Properties for the Player Score text
    fill(255);
    text("Score : " + PlayerScore, 20, height - 20); //Writing the score on the screen

    blackHoleAt(100, 40); //The two calls for the black hole
    blackHoleAt(400, 500);
  } else { //The game over screen, for when the player collides with the black hole
    background(0); //Text properties
    fill(255);
    textAlign(CENTER);
    textSize(20);
    text("GAME OVER", width/2, height/2); //Prints Game Over in the center of the screen
    text("Score : " + PlayerScore, width/2, height/2 +25); //Shows the players score just underneath the game over message
  }
}

void keyPressed() {
  if (SpaceShipFlipDirection) { //This Boolean controls the direction of the space craft
    SpaceShipFlipDirection = false; //If the boolean was already true this switches it to false, so it rotates in the opposite direction
  } else {
    SpaceShipFlipDirection = true ; //If the boolean was fals it switches it to true, allowing the craft to rotate in the opposite direction
  }
  //The keys for moving the paralx stars. 
  if (key == 'w') {
    for (int StarNum = 0; StarNum <StarPosX.length; StarNum ++) {
      StarPosY[StarNum] ++; //Moves the Y position of all the stars down on the screen
    }
  }
  if (key == 's') {
    for (int StarNum = 0; StarNum <StarPosX.length; StarNum ++) {
      StarPosY[StarNum] --;//Moves the Y position of all the stars up on the screen
    }
  }
  if (key == 'd') {
    for (int StarNum = 0; StarNum <StarPosX.length; StarNum ++) {
      StarPosX[StarNum] --;//Moves the X position of all the stars down on the screen
    }
  }
  if (key == 'a') {
    for (int StarNum = 0; StarNum <StarPosX.length; StarNum ++) {
      StarPosX[StarNum] ++;//Moves the X position of all the stars down on the screen
    }
  }
}

