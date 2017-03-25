import java.util.Random;

class Walker {
  float x;
  float y;
  Random generator;
  float sd;
  float mean;
  float prevx;
  float prevy;
  
  Walker() {
    x = width / 2;
    y = height / 2;
    generator = new Random();
    sd = 1;
    mean = 2;
    prevx = x;
    prevy = y;
  }
  
  void display() {
    stroke(0);
    point(x, y);
    line(x, y, prevx, prevy);
  }
  
  void step() {
    int direction = int(random(4));
    float randomGaussian = (float) generator.nextGaussian();
    
    float distance = sd * randomGaussian + mean;
    
    prevx = x;
    prevy = y;
    
    if(direction == 0) {
      y -= distance;
    } else if(direction == 1) {
      x += distance;
    } else if(direction == 2) {
      y += distance;
    } else {
      x -= distance;
    }
  }
}