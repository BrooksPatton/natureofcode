class Walker {
  float y, x, prevX, prevY, tx, ty, tz;
  
  Walker() {
    y = height / 2;
    x = width / 2;
    prevX = x;
    prevY = y;
    tx = 0;
    ty = 10000;
    tz = 100000000;
  }
  
  void display() {
    int r = int(map(noise(tx), 0, 1, 0, 255));
    int g = int(map(noise(ty), 0, 1, 0, 255));
    int b = int(map(noise(tz), 0, 1, 0, 255));
    
    stroke(r, g, b);
    point(x, y);
    line(x, y, prevX, prevY);
  }
  
  void step() {
    prevX = x;
    prevY = y;
    int direction = int(random(0, 4));
    float stepSizeX = map(noise(tx), 0, 1, 0, 5);
    float stepSizeY = map(noise(ty), 0, 1, 0, 5);
    tx += 0.01;
    ty += 0.01;
    
    if(direction == 0) {
      y -= stepSizeY;
    } else if(direction == 1) {
      x += stepSizeX;
    } else if(direction == 2) {
      y += stepSizeY;
    } else {
      x -= stepSizeX;
    }
  }
}