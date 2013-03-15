String pA, cA;
String [] answers = new String [9];  //array to store all of the answers
int tally = 0;  //variable to keep track of how far along the game is
boolean checker;  //error-proofing
CrnrContainer container = new CrnrContainer();
int randy; //computer selection
int times = 0;  //how many times the corners have been selected
int q = 0;   //controls text
String message;

PFont f;  //font for feedback


int [] strat = { 
  1, 3, 5, 7
};  //blocking spot
int [] crnrs = { 
  0, 2, 6, 8
};  //corners
int [] crnrsCheck = new int [2];


int row1_x = 100;
int row1_yMin = 103;
int row1_yMax = 239;

int row1_xMin = 60;
int row1_xMax = 236;
int col2_xMin = 273;
int col2_xMax = 432;
int col3_xMin = 529;
int col3_xMax = 729;

/*
int [] xLoc = {
 row1_x, row1_x*3, row1_x*5+50
 };
 
 int [] yLoc = {
 row1_yMin, row1_yMin*3-25, row1_yMin*3-25, row1_yMin*4+50
 };
 
 Box [][] boxes = new Box [3][3]; // 2D array to hold all the box coordinates
 //Box [] boxes = new Box [9];
 
 
 
 
 int [] [] boxes = {{row1_x, row1_yMin}, {row1_x*3, row1_yMin}, {row1_x*5+50, row1_yMin},
 {row1_x, row1_yMin*3-25}, {row1_x*3, row1_yMin*3-25}, {row1_x*5+50, row1_yMin*3-25},
 {row1_x, row1_yMin*4+50}, {row1_x*3, row1_yMin*4+50}, {row1_x*5+50, row1_yMin*4+50}};
 
 */
//////////////////

/*
problem set:
 1. keeping track of answers between players
 2. check if slot was not already selected
 3. check board to see who won
 4. computer input
 5. player input
 
 */

/*
 current issues:
 - need to tune and fine tune strategies. Working, but only 40-50%
 - get text on screen for winner feedback, and spot taken
 
 To take further:
 - blocking player strategy
 - weighted probablity for corners and sides
 
 */


void setup() {
  //frameRate(30); // slow it down for testing purposes
  f = loadFont("Dialog-48.vlw");
  textFont(f, 36);


  size(800, 800);
  background(255);
  stroke(10);
  line(250, 100, 250, 600);
  line(500, 100, 500, 600);
  line(50, 250, 750, 250);
  line(50, 450, 750, 450);
  /*
  for (int i = 0; i < 3; i++) {  
   for (int j = 0; i < 3; j++) {
   boxes[i][j] = new Box(xLoc[i], yLoc[j]);  // <---- arg
   }
   }
   */
}

void draw() {

  checkWinner();

  
}

void mouseReleased() {
  if (checker == false) {  //make sure user hasn't selected the same spot
    checker = true;  // if they have, re-set and let them select again
  }
  else {
    computerResponse();
  }
}

void computerResponse() {  //computer's turn

  checkCrnrs();
  computerStrat();  //strategy, check it taken, mark the board
}


void computerStrat() {

  if (answers[4] == "X") {  // if player picked center

    if (container.answer == true && times < 3) {  //and they also picked a corner
      randy = container.spot;  //pick the opposite corner
      if (answers[randy] == null) {  //make sure that spot isn't taken
        answers[randy] = "O";  //computer is  O  // the computer can take it, add it to the answers array
        times++;
        placeCompAnswer(randy);  //Mark the answer on the board
      }
    }
    else if (container.answer != true) {   // if they picked center and didn't pick a corner
      randy = int(random(crnrs.length));  // randomly select a value within the range of corners
      randy = crnrs[randy];  //  pick a corner value
      if (answers[randy] == null) {
        answers[randy] = "O";   //computer is  O  // the computer can take it, add it to the answers array
        times++;
        placeCompAnswer(randy);  //Mark the answer on the board
      }
    }
    else if (container.answer == true && times > 3) {  //if the corner was picked and corners have all been checked
      randy = int(random(strat.length));
      randy = strat[randy];
      if (answers[randy] == null) {
        answers[randy] = "O";   //computer is  O  // the computer can take it, add it to the answers array
        print("middler ?    ");
        println(randy);
        placeCompAnswer(randy);  //Mark the answer on the board
      }
    }
  }
  else if (answers[4] != "X" && answers[4] != "O") {  // if they didn't pick the center, pick it!
    randy = 4;  // select the center spot
    println(randy);
    if (answers[randy] == null) {
      answers[randy] = "O";   //computer is  O  // the computer can take it, add it to the answers array
      placeCompAnswer(randy);  //Mark the answer on the board
    }
  }
  else if (answers[4] == "X" || answers[4] == "O") {  // if the center is taken, pick something else
    randy = int(random(strat.length));
    randy = strat[randy];
    if (answers[randy] == null) {
      answers[randy] = "O";   //computer is  O  // the computer can take it, add it to the answers array
      placeCompAnswer(randy);  //Mark the answer on the board
    }
  }

  else {
    randy = int(random(8));  // pick a random value
    //println(randy);
    if (answers[randy] == null) {
      println(randy);
      answers[randy] = "O";   //computer is  O  // the computer can take it, add it to the answers array
      placeCompAnswer(randy);  //Mark the answer on the board
    }
  }
}


CrnrContainer checkCrnrs() { // if they have taken the center and a corner, select the remaining corner
  boolean answer;  //did they take a corner?
  int spot = 1;    //the spot the computer will pick

  for (int i = 0; i< crnrs.length; i++) {
    if (answers[crnrs[i]] == "X") {  //if any of the corners are X   
      answer = true;   //making answer true
      if (crnrs[i] == 0) {
        spot = 8;         // computer should select this block
      }
      if (crnrs[i] == 2) {
        spot = 6;        // computer should select this block
      }
      if (crnrs[i] == 6) {
        spot = 2;        // computer should select this block
      }
      if (crnrs[i] == 8) {
        spot = 0;      // computer should select this block
      }
      container.answer = answer;
      container.spot = spot;
    }
    /*
    else {
     container.answer = false;
     container.spot = -1;  //make it larger, out of range
     break;
     }
     */
    break;
  }
  //println("container.answer is  " + container.answer);
  //println("Container.spot is  " + container.spot);
  return container;
}

void checkWinner() {

  if ( "X" == answers[0] || answers[0] == "0") {  //box 0
    String comparer = answers[0];
    //println(comparer);
    if (comparer == answers[1] && comparer == answers[2]) {  //top row
      println(answers[0] + " won the game");
      // noLoop();
      exit();
    }
    else if (comparer == answers[3] && comparer == answers[6]) { // left column
      println(answers[0] + " won the game");
      //noLoop();
      exit();
    }
    else if (comparer == answers[4] && comparer == answers[8]) {  //diagnoal top left to bottom right
      println(answers[0] + " won the game");
      //noLoop();
      exit();
    }
  }


  else if ( "X" == answers[6] || answers[6] == "0") { //bottom left corner
    String comparer = answers[6];
    if (comparer == answers[7] && comparer == answers[8]) { //bottom row
      println(answers[6] +" won the game");
      //noLoop();
      exit();
    }
    else if (comparer == answers[4] && comparer == answers[2]) { //diagnoal bottom left to top right
      println("got here");
      println(answers[6] +" won the game");
      //noLoop();
      exit();
    }
  }

  else if ( "X" == answers[8] || answers[8] == "0") { //bottom right corner
    String comparer = answers[8];
    if (comparer == answers[5] && comparer == answers[2]) { //right column
      println(answers[8] + " won the game");
      //noLoop();
      exit();
    }
  }
  else if ( "X" == answers[4] || answers[4] == "0") { // check from center
    String comparer = answers[4];

    if (comparer == answers[1] && comparer == answers[7]) { //middle column
      println(answers[4] + " won the game");
      //noLoop();
      exit();
    }
    else if (comparer == answers[3] && comparer == answers[5]) { //middle row
      println(answers[4] + " won the game");
      //noLoop();
      exit();
    }
  }
}


/*
    if (tally > 8) {     // if more than 8 turns have been taken
 println("game over");  //otherwise game over
 }
 */


boolean alreadySelected(int compAns) {   //check to see if the player's selection wasn't already selected
  if (answers[compAns] == "O" || answers[compAns] == "X") {
   // message = "Try again, that spot is already taken";
    //fill(58, 201, 58);
    //text(message, 100, 100);
    noFill();
    println("Try again, that spot is already taken");
    checker = false;

    return checker;
  }
  else {
    checker = true;
    return checker;
  }
}




void mousePressed() {  // player's turn
  //row 1
  if (mouseX > row1_xMin && mouseX < row1_xMax && mouseY > row1_yMin && mouseY < row1_yMax) {  //box 0
    X x_char = new X(row1_x, row1_yMin);
    if (alreadySelected(0)) {  // check to see if spot isn't already taken
      x_char.init();  //draw it
      answers[0] = "X";  //add it to the array, keeping track of answers
      println(" zero = " + answers[0]);
      //O o_char = new O(row1_x, row1_yMin);
      //o_char.init();
      tally++;  //add a turn to the tally
    }
  }

  if (mouseX > col2_xMin && mouseX < col2_xMax && mouseY > row1_yMin && mouseY < row1_yMax) {  //box 1
    X x_char = new X(row1_x*3, row1_yMin);
    if (alreadySelected(1)) {  // check to see if spot isn't already taken
      x_char.init();  //draw it
      answers[1] = "X";  //add it to the array, keeping track of answers
      println( " one = " + answers[1]);
      //O o_char = new O(row1_x*3, row1_yMin);
      //o_char.init();
      tally++;  //add a turn to the tally
    }
  }
  if (mouseX > col3_xMin && mouseX < col3_xMax && mouseY > row1_yMin && mouseY < row1_yMax) {  // box 2
    X x_char = new X(row1_x*5+50, row1_yMin);
    if (alreadySelected(2)) {  // check to see if spot isn't already taken
      x_char.init();   //draw it
      answers[2] = "X"; //add it to the array, keeping track of answers
      println( " two = " + answers[2]);
      //O o_char = new O(row1_x*5+50, row1_yMin);
      //o_char.init();
      tally++;  //add a turn to the tally
    }
  }


  //column 1

  if (mouseX > row1_xMin && mouseX < row1_xMax && mouseY > row1_yMin*2 + 30 && mouseY < row1_yMin*4 + 30) {  //box 3
    X x_char = new X(row1_x, row1_yMin*3-25);
    if (alreadySelected(3)) {  // check to see if spot isn't already taken
      x_char.init();   //draw it
      answers[3] = "X";  //add it to the array, keeping track of answers
      println( " three = " + answers[3]);
      //O o_char = new O(row1_x, row1_yMin*3-25);
      //o_char.init();
      tally++;  //add a turn to the tally
    }
  }

  if (mouseX > row1_xMin && mouseX < row1_xMax && mouseY > row1_yMin*4 && mouseY < row1_yMin*7) { // box 6
    X x_char = new X(row1_x, row1_yMin*4+50);
    if (alreadySelected(6)) {  // check to see if spot isn't already taken
      x_char.init();  //draw it
      answers[6] = "X";  //add it to the array, keeping track of answers
      println( " six = " + answers[6]);
      //O o_char = new O(row1_x, row1_yMin*4+50);
      //o_char.init();
      tally++;   //add a turn to the tally
    }
  }


  //column 2

  if (mouseX > col2_xMin && mouseX < col2_xMax  && mouseY > row1_yMin*2+60 && mouseY < row1_yMax*2) {  //box 4
    X x_char = new X(row1_x*3, row1_yMin*3-25);
    if (alreadySelected(4)) {  // check to see if spot isn't already taken
      x_char.init();  //draw it
      answers[4] = "X";  //add it to the array, keeping track of answers
      println(" four = " + answers[4]);
      //O o_char = new O(row1_x*3, row1_yMin*3-25);
      //o_char.init();
      tally++;  //add a turn to the tally
    }
  }


  if (mouseX > col2_xMin && mouseX < col2_xMax  && mouseY >  row1_yMin*4 && mouseY < row1_yMin*6 -15) {  // box 7
    X x_char = new X(row1_x*3, row1_yMin*4+50);
    if (alreadySelected(7)) {  // check to see if spot isn't already taken
      x_char.init();   //draw it 
      answers[7] = "X";  //add it to the array, keeping track of answers
      println( " seven = " + answers[7]);
      //O o_char = new O(row1_x*3, row1_yMin*4+50);
      //o_char.init();
      tally++;  //add a turn to the tally
    }
  }


  //column 3

  if (mouseX > col3_xMin && mouseX < col3_xMax && mouseY > row1_yMin*2+60 && mouseY < row1_yMax*2) {  // box 5
    X x_char = new X(row1_x*5+50, row1_yMin*3-25);
    if (alreadySelected(5)) {  // check to see if spot isn't already taken
      x_char.init();  //draw it 
      answers[5] = "X";  //add it to the array, keeping track of answers
      println( " five = " + answers[5]);
      //O o_char = new O(row1_x*5+50, row1_yMin*3-25);
      //o_char.init();
      tally++;  //add a turn to the tally
    }
  }

  if (mouseX > col3_xMin && mouseX < col3_xMax && mouseY >  row1_yMin*4 && mouseY < row1_yMin*6 -15) {  // box 8
    X x_char = new X(row1_x*5+50, row1_yMin*4+50);
    if (alreadySelected(8)) {  // check to see if spot isn't already taken
      x_char.init();  //draw it 
      answers[8] = "X";  //add it to the array, keeping track of answers
      println(" eight = " + answers[8]);
      //O o_char = new O(row1_x*5+50, row1_yMin*4+50);
      //o_char.init();
      tally++;  //add a turn to the tally
    }
  }
}

void placeCompAnswer(int response) {
  if (response == 0) {
    O o_char = new O(row1_x, row1_yMin);
    o_char.init();
    tally++;
  }
  else if (response == 1) {
    O o_char = new O(row1_x*3, row1_yMin);
    o_char.init();
    tally++;
  }

  else if (response == 2) {
    O o_char = new O(row1_x*5+50, row1_yMin);
    o_char.init();
    tally++;
  }
  else if (response == 3) {
    O o_char = new O(row1_x, row1_yMin*3-25);
    o_char.init();
    tally++;
  }
  else if (response == 4) {
    O o_char = new O(row1_x*3, row1_yMin*3-25);
    o_char.init();
    tally++;
  }
  else if (response == 5) {
    O o_char = new O(row1_x*5+50, row1_yMin*3-25);
    o_char.init();
    tally++;
  }
  else if (response == 6) {
    O o_char = new O(row1_x, row1_yMin*4+50);
    o_char.init();
    tally++;
  }
  else if (response == 7) {
    O o_char = new O(row1_x*3, row1_yMin*4+50);
    o_char.init();
    tally++;
  }
  else if (response == 8) {
    O o_char = new O(row1_x*5+50, row1_yMin*4+50);
    o_char.init();
    tally++;
  }
}

