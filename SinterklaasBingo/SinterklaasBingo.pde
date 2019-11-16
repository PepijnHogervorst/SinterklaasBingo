// IMPORTS 
import processing.video.*;    //For video player 

// BINGO VARIABLES edit to your needs
int bingoHighestNumber = 90;
int historySize = 3; //CANT BE BIGGER THAN 5
color bgColorApp = color(50, 200, 255);
color[] colorBingoBall = {
  color(200, 0 ,0), color(0, 200, 0), color(0, 0, 200), color(200, 0, 200), color(0, 200, 200), color(200, 200, 0)
};

//DONT EDIT BELOW THIS POINT UNLESS YOU KNOW WHAT YOU ARE DOING!
ArrayList<Integer> bingoNumbers = new ArrayList<Integer>();
ArrayList<Integer> numbersDone = new ArrayList<Integer>();

int numberShown = 0; 
float time = 0; float prevTime = 0;
int rectNextX, rectNextY;        // Position of next number button
int rectResetX, rectResetY;      // Position of reset button
int rectPlayX, rectPlayY;
int rectStopX, rectStopY;
int rectSize = 120;     // Diameter of rect
int nrOfVLines = (bingoHighestNumber > 10) ? 11 : bingoHighestNumber + 1 ;
int nrOfHLines = ((bingoHighestNumber + 9) / 10) + 1;

color rectColor, circleColor, bgColor;
color rectHighlight, rectPressed;
color currentColor; 

boolean rectNextOver = false;
boolean rectResetOver = false;
boolean rectPlayOver = false;
boolean rectStopOver = false;
boolean pictureChanged = false;
boolean MovieFlag = true;

PImage imgCircle, imgSint, imgDaken, imgPiet, imgSnoep;
PImage[] slideShow;
PImage imgPlay, imgPause;

Movie myMovie;

//GRID variables
int xStart = 200; int yStart = 20;

void setup() {
  
  for(int i =0; i < bingoHighestNumber; i++)
  {
    bingoNumbers.add(i + 1); 
  }
  
  //IMAGES
  imgSint = loadImage("/Pictures/SinterklaasIcon.png");
  imgDaken = loadImage("/Pictures/daken.png");
  imgPiet = loadImage("/Pictures/piet.png");
  imgSnoep = loadImage("/Pictures/snoep.png");
  imgPlay = loadImage("/Pictures/play.png");
  imgPause = loadImage("/Pictures/pause.png");
  
  myMovie = new Movie(this, "test.mov");
  myMovie.loop();
  myMovie.frameRate(5);
  
  //Create seconds screen
  String[] args = {"Bingo Screen"};
  SecondApplet sa = new SecondApplet();
  PApplet.runSketch(args, sa);
  
  //COLORS
  bgColor = color(32, 32, 32);
  rectColor = color(0);
  rectHighlight = color(51);
  rectPressed = color(100);
  
  //POSITIONS
  rectNextX = 10;  //width/2-rectSize-10;
  rectNextY = 10;  //height/2-rectSize/2;
  rectResetX = rectNextX;
  rectResetY = height - rectSize/2 - rectNextY;
  rectPlayX = rectNextX;
  rectPlayY = rectResetY - (rectSize / 2) - rectNextY;
  rectStopX = rectNextX + (rectSize / 2) + rectNextY;
  rectStopY = rectPlayY;
  // Fill background
  background(bgColor);
  
  //Draw number grid lines
  drawGrid();  
}

void drawGrid()
{
  stroke(160);
  for(int i = 0; i < nrOfHLines; i++)
  { //HORIZONTAL
    line(xStart, yStart + (((height - yStart) /nrOfHLines) * i), xStart + ((width - xStart) / nrOfVLines * (nrOfVLines-1)), yStart + (((height - yStart) /nrOfHLines) * i));
  }
  for(int i = 0; i < nrOfVLines; i++)
  { //VERTICAL
    line(xStart + (((width - xStart) / nrOfVLines) * i), 20, xStart + (((width - xStart) / nrOfVLines) * i), yStart + (height - yStart) / nrOfHLines * (nrOfHLines - 1));
  }
}

void settings()
{
  size(1000, 600);
}

void draw() {
  update();
   
  //Draw elements, Button next number
  drawButton(rectNextX, rectNextY, rectSize, rectSize / 2, rectNextOver);
  // Button reset
  drawButton(rectResetX, rectResetY, rectSize, rectSize / 2, rectResetOver);
  // Button play
  drawButton(rectPlayX, rectPlayY, rectSize / 2, rectSize / 2, rectPlayOver);
  // Button stop
  drawButton(rectStopX, rectStopY, rectSize / 2, rectSize / 2, rectStopOver);
  //Draw text in btn next
  drawText("Volgende nr", rectNextX + rectSize/2, rectNextY + (rectSize / 4));
  drawText("Nieuw spel", rectResetX + rectSize/2, rectResetY + (rectSize / 4));  
  
  fill(bgColor);
  stroke(bgColor);
  rect(rectPlayX, rectPlayY - 60, rectSize, 57);
  drawText((MovieFlag ? "Film actief" : "Bingo actief"), rectPlayX + rectSize / 2 , rectPlayY - 40);
  
  // Draw play and pause icons
  image(imgPlay, rectPlayX + 3, rectPlayY + 3, rectSize / 2 - 6, rectSize / 2 - 6);
  image(imgPause, rectStopX + 3, rectStopY + 3, rectSize / 2 - 6, rectSize / 2 - 6);
}   

void update()
{
  if ( overRect(rectNextX, rectNextY, rectSize, rectSize / 2) ) {
    rectNextOver = true;
  } else {
    rectNextOver = false;
  }
  if( overRect(rectResetX, rectResetY, rectSize, rectSize / 2) ) {
    rectResetOver = true;
  }
  else {
    rectResetOver = false;
  }
  rectPlayOver = overRect(rectPlayX, rectPlayY, rectSize / 2, rectSize / 2);
  rectStopOver = overRect(rectStopX, rectStopY, rectSize / 2, rectSize / 2);
}

void drawButton(int x, int y, int _width, int _height, boolean mouseOverObject)
{
  if(mouseOverObject)
  {
    if(mousePressed)
    {
      fill(rectPressed);
    }
    else
    {
      fill(rectHighlight);
    }
  }
  else
  {
    fill(rectColor);
  }
  stroke(255);
  rect(x, y, _width, _height);
}

void movieEvent(Movie m) {
  m.read();
}

void drawText(String text, int x, int y)
{
  fill(255);
  textSize(16);
  textAlign(CENTER, CENTER);
  text(text, x, y);
}

boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}


void mousePressed() {
  if (rectNextOver) {
    btnNext_Pressed();
  }
  else if(rectResetOver) {
    btnReset_Pressed();
  }
  else if(rectPlayOver) {
    btnPlay_Pressed();
  }
  else if(rectStopOver) {
    btnStop_Pressed();
  }
}

void btnNext_Pressed()
{
    NextNr();
}

void btnReset_Pressed()
{
  //Fill rectangle
  fill(rectPressed);
  stroke(255);
  rect(rectResetX, rectResetY, rectSize, rectSize / 2);
  
  numberShown = 0;
  background(bgColor);
  drawGrid();
  
  bingoNumbers.clear();
  numbersDone.clear();
  
  //Fill bingo list with all number up to highest number
  for(int i =0; i < bingoHighestNumber; i++)
  {
    bingoNumbers.add(i + 1); 
  }
}

void btnPlay_Pressed()
{
  //Play movie
  MovieFlag = true;
  myMovie.play();
}

void btnStop_Pressed()
{
  //Pauze movie
  MovieFlag = false;
  myMovie.pause();
}

void drawPicture()
{
  time = second();
  if(time % 10 == 0)
  {
    if(!pictureChanged)
    {
      //Change picture here
      
      pictureChanged = true;
    }
  }
}

void keyPressed()
{
  if(key == ' ')
  {
    NextNr();
  }
  else if(key == 'p')
  {
    MovieFlag = !MovieFlag;
    if(MovieFlag)
      myMovie.play(); 
    else 
      myMovie.pause();
  }
  else if(keyCode == ENTER || keyCode == RETURN)
  {
    MovieFlag = !MovieFlag;
    if(MovieFlag)
      myMovie.play(); 
    else 
      myMovie.pause();
  }
}

void NextNr()
{
  //Fill rectangle
  fill(rectPressed);
  stroke(255);
  rect(rectNextX, rectNextY, rectSize, rectSize / 2);
  
  //Update number to new random from array
  float number = random(bingoNumbers.size());
  if(bingoNumbers.size() > 0)
  {
    int intNumber = floor(number);
    numberShown = bingoNumbers.get(intNumber);
    //Remove
    bingoNumbers.remove(intNumber);
    numbersDone.add(numberShown);
    //Show and place number
    fill(255);
    textSize(20);
    textAlign(CENTER, CENTER);
    text(str(numberShown), 
      xStart + ((width - xStart) / nrOfVLines * ((numberShown - 1) % 10)) + (width - xStart) / (nrOfVLines * 2) ,
      yStart + ((height - yStart) /nrOfHLines * ((numberShown - 1) / 10)) + (height - yStart) / (nrOfHLines* 2));
      
    //Update history
    //clear old history
    fill(bgColor);
    stroke(bgColor);
    rect(rectNextX, rectNextY  + 100, rectSize + 30, height);
    
    fill(255);
    textAlign(CENTER, TOP);
    for(int i =0; i < ((historySize + 1) < numbersDone.size() ? (historySize + 1) : numbersDone.size()); i++)
      {
        textSize(70 - (i * 10));
        text(str(numbersDone.get(numbersDone.size() - i - 1)), rectNextX + rectSize / 2, rectNextY + 100 + (i * 60));
      }
  }
}


/***SECONDS SCREEN***/

public class SecondApplet extends PApplet {
  
  int prevNumber = 0;
  color currentBingoColor = colorBingoBall[0];
  
  public void setup() {
    background(bgColorApp);
    fill(0);
  }
  
  public void settings() {
    //size(800, 480);
    fullScreen();
  }
  public void draw() {
    // Depending on movie flag show bingo screen or show movie:
    
    if(MovieFlag)
    {
      //Resolution of movie here: PLEASE CALCULATE THE X AND Y COORDS YOURSELF
      fill(0);
      rect(0,0, width, height);
      image(myMovie, 0, 0);
      return;
    }
    
    background(50, 200, 255);
    
    image(imgSint, 10, 10, width / 8, width / 8);
    image(imgSnoep, width - 1100, height / 2 -50, 1000, 645);
    image(imgPiet, width - 300 , height / 4, 256, 256);
    int x = -1;
    while(x < width)
    {
      image(imgDaken, x, height - 410, 963, 500);
      x += 962;
    }
    
    
    
    if(numberShown != 0)
    {
      //Draw circle (bingo ball), USER NEEDS TO DEFINE NUMBER OF COLORS
      if(prevNumber != numberShown)
      {
        float number = random(6);
        currentBingoColor = colorBingoBall[floor(number)];
        prevNumber = numberShown;
      }
      fill(currentBingoColor);
      
      ellipse(width / 2, height / 2, width / 4, width / 4);
      //Draw text 
      fill(255);
      textSize(300);
      textAlign(CENTER, CENTER);
      text(str(numberShown), width / 2, height / 2 - 40);
      
      for(int i =0; i < (historySize < (numbersDone.size() - 1) ? historySize : (numbersDone.size() - 1)); i++)
      {
        textSize(150 - (i * 20));
        text(str(numbersDone.get(numbersDone.size() - i - 2)), (width / (historySize + 1)) * (i + 1), 100);
      }
      
    }
    
    //Draw picture here
    drawPicture();
    
    
  }
  
  // Called when new frame is available
  void movieEvent(Movie m) {
    m.read();
  }
}


// Icon: Video-player Button made by SmashIcons from www.flaticon.com
// Icon: Pauze Button made by SmashIcons from www.flaticon.com
