String testString = "Hello world on both monitors";

void setup() {
  String[] args = {"TwoFrameTest"};
  SecondApplet sa = new SecondApplet();
  PApplet.runSketch(args, sa);
  //fullScreen();
  //size(800, 480);
  
  background(0, 10, 0);
  ellipse(50, 50, 10, 10);
  text(testString, 10,10);
}
void settings()
{
  size(800, 480);
}

void draw() {
  
}     

public class SecondApplet extends PApplet {

  public void settings() {
    //size(800, 480);
    fullScreen();
  }
  public void draw() {
    background(50, 200, 255);
    fill(0);
    ellipse(100, 50, 10, 10);
    text(testString, 10,10);
  }
}
