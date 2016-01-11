// https://github.com/rspt/processing-pointillisme.git

PImage img;
int i = 0, j = 0;
boolean overlap;
color baseColor = color(255, 255, 255);
ArrayList<Ball> balls = new ArrayList<Ball>();

// Parameters
String imageName = "octopus.png";
boolean inverted = false; // false -> white background, true -> black background
int gutter = 2;
int[] pointSizes = { 5, 10, 15, 20, 30, 40, 50 };

void setup() {
  size(1920, 1280);
  img = loadImage("images/base/" + imageName);
  imageMode(CENTER);
  noStroke();
  background(255);
  noLoop();

  if (inverted) {
    background(0);
    baseColor = color(0, 0, 0);
  }
}

void draw() {
  
  for (j = 0; j < img.height; j += pointSizes[0]) {
    for (i = 0; i < img.width; i += pointSizes[0]) {
  
      int index = int(random(pointSizes.length));
      int size = pointSizes[index] - gutter;
      
      Ball ball = new Ball(i, j, size);
      
      if (ball.collide()){
        balls.add(ball);
        color pix = img.get(i, j);
        if (pix != baseColor) {
          fill(pix, 140);
          ellipse(i, j, size, size);
        }
      }
    }
  }
  
  saveFrame("images/export/" + imageName);
}


class Ball{
  float x, y;
  float diameter;
  int id;
  
  Ball(float xin, float yin, int diameterin){
    x = xin;
    y = yin;
    diameter = diameterin;
  }
  
  boolean collide(){
    overlap = false;
    
    for (int i = 0; i < balls.size(); i++) {
      Ball part = balls.get(i);
      
      float dx = part.x - this.x;
      float dy = part.y - this.y;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = part.diameter/2 + this.diameter/2;
      if (distance < minDist){
        overlap = true;
      }
    }
    
    return !overlap;
  }
  
  void display(){
    fill(255,200);
    ellipse(x, y, diameter, diameter);
  }
}