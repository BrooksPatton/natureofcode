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
    int rand = int(random(4));
    
    if(rand < 2) {
      if(x < mouseX) {
        x++;
      } else if(x > mouseX) {
        x--;
      }
      
      if(y < mouseY) {
        y++;
      } else if(y > mouseY) {
        y--;
      }
    } else {
      if(rand == 0) {
        y--;
      } else if(rand == 1) {
        x++;
      } else if(rand == 2) {
        y++;
      } else {
        x--;
      }
    }
  }
}