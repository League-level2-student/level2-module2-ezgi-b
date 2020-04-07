//*
// ***** SEGMENT CLASS *****
// This class will be used to represent each part of the moving snake.
//*

class Segment {
  int x;
  int y;
  
  Segment(int x, int y){
    this.x = x;
    this.y = y;
    
  }

//Add x and y member variables. They will hold the corner location of each segment of the snake.


// Add a constructor with parameters to initialize each variable.



}


//*
// ***** GAME VARIABLES *****
// All the game variables that will be shared by the game methods are here
//*
Segment snek;
int foodX;
int foodY;
int foodEaten;
int direction;
ArrayList<Segment> segments = new ArrayList<Segment>();


//*
// ***** SETUP METHODS *****
// These methods are called at the start of the game.
//*

void setup() {
  size(500,500);
  background(90,60,40);
  snek = new Segment(100,100);
  frameRate(8);
  dropFood();
  direction = UP;
  foodEaten = 1;
}

void dropFood() {
  //Set the food in a new random location
    foodX = ((int)random(50)*10);
    foodY = ((int)random(50)*10);
}



//*
// ***** DRAW METHODS *****
// These methods are used to draw the snake and its food 
//*

void draw() {
  background(90,60,40);
  move();
  checkBoundaries();
  drawFood();
  drawSnake();
  eat();
}

void drawFood() {
  //Draw the food
  noStroke();
  fill(150,150,150);
  rect(foodX,foodY,10,10);
  fill(0,0,0);
  circle(foodX+1,foodY+1,3);
  circle(foodX+9,foodY+1,3);
  fill(250,150,170);
  circle(foodX+5,foodY-1,3);
  stroke(250,150,170);
  strokeWeight(3);
  line(foodX+5,foodY+8,foodX+5,foodY+10);
}

void drawSnake() {
  //Draw the head of the snake followed by its tail
    noStroke();
    fill(0,200,70);
    rect(snek.x,snek.y,10,10);
   manageTail();
}


//*
// ***** TAIL MANAGEMENT METHODS *****
// These methods make sure the tail is the correct length.
//*

void drawTail() {
  //Draw each segment of the tail 
  for(Segment i: segments){
    fill(0,200,70);
    rect(i.x,i.y,10,10);
  }
}

void manageTail() {
  //After drawing the tail, add a new segment at the "start" of the tail and remove the one at the "end" 
  //This produces the illusion of the snake tail moving.
  if(foodEaten>1){
    checkTailCollision();
    drawTail();
    segments.remove(segments.size()-1);
    segments.add(new Segment(snek.x,snek.y));
  }
  
}

void checkTailCollision() {
  //If the snake crosses its own tail, shrink the tail back to one segment
  for(Segment i: segments){
    if(i.x==snek.x && i.y==snek.y){
      foodEaten = 1;
      segments = new ArrayList<Segment>();
    }
  }
}



//*
// ***** CONTROL METHODS *****
// These methods are used to change what is happening to the snake
//*

void keyPressed() {
  //Set the direction of the snake according to the arrow keys pressed
  if(keyCode == UP && direction != DOWN){
    direction = UP;
  }
  
  if(keyCode == DOWN && direction != UP){
    direction = DOWN;
  }
  
  if(keyCode == RIGHT && direction != LEFT){
    direction = RIGHT;
  }
  
  if(keyCode == LEFT && direction != RIGHT){
    direction = LEFT;
  }
}

void move() {
  //Change the location of the Snake head based on the direction it is moving.
  
  if(direction==UP){
    snek.y-=10;
  } else if(direction==DOWN){
    snek.y+=10;
  } else if(direction==LEFT){
    snek.x-=10;
  } else if(direction==RIGHT){
    snek.x+=10;
  }
    /*
  switch(direction) {
  case UP:
    // move head up here 
    break;
  case DOWN:
    // move head down here 
    break;
  case LEFT:
   // figure it out 
    break;
  case RIGHT:
    // mystery code goes here 
    break;
  }
  */
}

void checkBoundaries() {
 //If the snake leaves the frame, make it reappear on the other side
 if(snek.x<0){
   snek.x=500;
 }
 if(snek.x>500){
   snek.x=0;
 }
 if(snek.y<0){
   snek.y=500;
 }
 if(snek.y>500){
   snek.y=0;
 }
 

 
}



void eat() {
  //When the snake eats the food, its tail should grow and more food appear
  
  if(snek.x==foodX && snek.y==foodY){
    foodEaten+=1;
    dropFood();
    segments.add(new Segment(snek.x,snek.y));
  }
  
 

}
