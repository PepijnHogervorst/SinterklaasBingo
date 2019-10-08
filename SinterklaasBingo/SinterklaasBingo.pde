//BINGO VARIABLES edit to your needs
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
int rectNextX, rectNextY;      // Position of square button
int rectResetX, rectResetY;      // Position of square button
int circleX, circleY;  // Position of circle button
int rectSize = 120;     // Diameter of rect
int circleSize = 93;   // Diameter of circle
int nrOfVLines = (bingoHighestNumber > 10) ? 11 : bingoHighestNumber + 1 ;
int nrOfHLines = ((bingoHighestNumber + 9) / 10) + 1;

color rectColor, circleColor, bgColor;
color rectHighlight, rectPressed;
color currentColor; 

boolean rectNextOver = false;
boolean rectResetOver = false;
boolean pictureChanged = false;

PImage imgCircle, imgSint, imgDaken, imgPiet, imgSnoep;
PImage[] slideShow;

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
   
  //Draw elements
  if (rectNextOver) {
    if(mousePressed)
    {
      fill(rectPressed);
    }
    else
    {
      fill(rectHighlight);
    }
  } else {
    fill(rectColor);
  }
  stroke(255);
  rect(rectNextX, rectNextY, rectSize, rectSize / 2);
  if (rectResetOver)
  {
    if(mousePressed)
    {
      fill(rectPressed);
    }
    else
    {
      fill(rectHighlight);
    }
  } else {
    fill(rectColor);
  }
  rect(rectResetX, rectResetY, rectSize, rectSize / 2);
  
  //Draw text in btn next
  fill(255);
  textSize(16);
  textAlign(CENTER, CENTER);
  text("Volgende nr", rectNextX + rectSize/2, rectNextY + (rectSize / 4));
  
  //Draw text in btn reset
  fill(255);
  textSize(16);
  textAlign(CENTER, CENTER);
  text("Nieuw spel", rectResetX + rectSize/2, rectResetY + (rectSize / 4));
  
  
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
}

void btnNext_Pressed()
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




public class SecondApplet extends PApplet {
  
  int prevNumber = 0;
  color currentBingoColor = colorBingoBall[0];
  
  public void setup() {
    background(bgColorApp);
    fill(0);
    ellipse(100, 50, 10, 10);
    
  }
  
  public void settings() {
    //size(800, 480);
    fullScreen();
  }
  public void draw() {
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
}
