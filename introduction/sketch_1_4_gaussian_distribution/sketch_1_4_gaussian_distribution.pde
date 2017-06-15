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
  float numRed = (float) generator.nextGaussian();
  float numBlue = (float) generator.nextGaussian();
  float numGreen = (float) generator.nextGaussian();
  float sd = 60;
  float sdcolor = 100;
  float meanx = 320;
  float meany = 180;
  float meancolor = 255 / 2;
  float x = sd * numx + meanx;
  float y = sd * numy + meany;
  float red = sdcolor * numRed + meancolor;
  float blue = sdcolor * numBlue + meancolor;
  float green = sdcolor * numGreen + meancolor;
  
  noStroke();
  fill(red, blue, green);
  ellipse(x, y, 16, 16);
}