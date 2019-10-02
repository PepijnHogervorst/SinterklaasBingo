//BINGO VARIABLES
int bingoHighestNumber = 90;


int[] bingoNumbers;
int rectNextX, rectNextY;      // Position of square button
int circleX, circleY;  // Position of circle button
int rectSize = 120;     // Diameter of rect
int circleSize = 93;   // Diameter of circle
color rectColor, circleColor, bgColor;
color rectHighlight, rectPressed;
color currentColor;
boolean rectOver = false;
boolean circleOver = false;



void setup() {
  bingoNumbers = new int[bingoHighestNumber];
  for(int i =0; i < bingoNumbers.length; i++)
  {
    bingoNumbers[i] = i + 1;    //Place 0 is 1 etc. etc. 
  }
  String[] args = {"Bingo Screen"};
  SecondApplet sa = new SecondApplet();
  PApplet.runSketch(args, sa);
  
  //  COLORS
  bgColor = color(32, 32, 32);
  rectColor = color(0);
  rectHighlight = color(51);
  rectPressed = color(100);
  
  //POSITIONS
  rectNextX = 10;  //width/2-rectSize-10;
  rectNextY = 10;  //height/2-rectSize/2;
  
  // Fill background
  background(bgColor);

}
void settings()
{
  size(1000, 600);
}

void draw() {
  update();
   
  //Draw elements
  if (rectOver) {
    fill(rectHighlight);
  } else {
    fill(rectColor);
  }
  stroke(255);
  rect(rectNextX, rectNextY, rectSize, rectSize / 2);
  fill(255);
  text("Volgende nummer", rectNextX + 10, rectNextY + (rectSize / 4) + 5);
}     

void update()
{
  if ( overCircle(circleX, circleY, circleSize) ) {
    circleOver = true;
    rectOver = false;
  } else if ( overRect(rectNextX, rectNextY, rectSize, rectSize) ) {
    rectOver = true;
    circleOver = false;
  } else {
    circleOver = rectOver = false;
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

boolean overCircle(int x, int y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}

void mousePressed() {
  if (circleOver) {
    currentColor = circleColor;
  }
  if (rectOver) {
    fill(rectPressed);
  }
  stroke(255);
  rect(rectNextX, rectNextY, rectSize, rectSize / 2);
}







public class SecondApplet extends PApplet {
  
  public void setup() {
    background(50, 200, 255);
    fill(0);
    ellipse(100, 50, 10, 10);
    
  }
  
  public void settings() {
    //size(800, 480);
    fullScreen();
  }
  public void draw() {
    
  }
}
