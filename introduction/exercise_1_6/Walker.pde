class Walker {
  float x;
  float y;
  float prevX;
  float prevY;

  Walker() {
    x = width / 2;
    y = height / 2;
    prevX = x;
    prevY = y;
  }

  void display() {
    stroke(0);
    point(x, y);
    line(x, y, prevX, prevY);
  }

  void step() {
    float stepSize = customRandom() * 10;

    float stepX = random(-stepSize, stepSize);
    float stepY = random(-stepSize, stepSize);
    
    prevX = x;
    prevY = y;

    x += stepX;
    y += stepY;
  }

  float customRandom() {
    while(true) {
      float r1 = random(1);
      float probability = pow(1 - r1, 10);
      float r2 = random(1);

      if(r2 < r1) {
        return r1;
      }
    }
  }
}