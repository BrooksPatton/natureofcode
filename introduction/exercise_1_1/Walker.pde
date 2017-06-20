class Walker {
  int x;
  int y;
  
  Walker() {
    x = width / 2;
    y = height / 2;
  }
  
  void display() {
    stroke(0);
    point(x, y);
  }
  
  void step() {
    float randNum = random(1);
    
    if(randNum < 0.4) {
      x++;
    } else if(randNum < 0.7) {
      y++;
    } else if(randNum < 0.9) {
      y--;
    } else {
      x--;
    }
  }
}