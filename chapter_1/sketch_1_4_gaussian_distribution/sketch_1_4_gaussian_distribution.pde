import java.util.Random;

Random generator;

void setup() {
  size(640, 360);
  generator = new Random();
  background(0);
}

void draw() {
  float numx = (float) generator.nextGaussian();
  float numy = (float) generator.nextGaussian();
  float sd = 60;
  float meanx = 320;
  float meany = 180;
  float x = sd * numx + meanx;
  float y = sd * numy + meany;
  
  noStroke();
  fill(255);
  ellipse(x, y, 16, 16);
}