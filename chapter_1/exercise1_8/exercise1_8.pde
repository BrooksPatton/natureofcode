float xoff, yoff, zoff;

void setup() {
  size(600, 400);
  loadPixels();
  xoff = 0;
  zoff = 100000;
}

void draw() {
  float xoff = 0.0;
 
  for (int x = 0; x < width; x++) {
    yoff = 1000;
   
    for (int y = 0; y < height; y++) {
      float bright = map(noise(xoff, yoff, zoff),0,1,0,255);
      pixels[x+y*width] = color(bright);
      yoff += 0.02;
    }
    xoff += 0.02;
  }
  updatePixels();
  zoff += 0.02;
}