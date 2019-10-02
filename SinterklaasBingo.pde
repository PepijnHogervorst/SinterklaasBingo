int rectX, rectY;      // Position of square button
int circleX, circleY;  // Position of circle button
int rectSize = 90;     // Diameter of rect
int circleSize = 93;   // Diameter of circle
color rectColor, circleColor, baseColor;
color rectHighlight, circleHighlight;
color currentColor;
boolean rectOver = false;
boolean circleOver = false;

String testString = "Hello world on both monitors";

void setup() {
  String[] args = {"TwoFrameTest"};
  SecondApplet sa = new SecondApplet();
  PApplet.runSketch(args, sa);
  //fullScreen();
  //size(800, 480);
  
  background(32, 32, 32);
  ellipse(50, 50, 10, 10);
  text(testString, 10,10);

}
void settings()
{
  size(1000, 600);
}

void draw() {
  update(mouseX, mouseY);
  //Draw background
  
  //Draw elements
  
}     

void update(int x, int y)
{
  if ( overCircle(circleX, circleY, circleSize) ) {
    circleOver = true;
    rectOver = false;
  } else if ( overRect(rectX, rectY, rectSize, rectSize) ) {
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









public class SecondApplet extends PApplet {
  
  public void setup() {
    background(50, 200, 255);
    fill(0);
    ellipse(100, 50, 10, 10);
    text(testString, 10,10);
  }
  
  public void settings() {
    //size(800, 480);
    fullScreen();
  }
  public void draw() {
    
  }
}
