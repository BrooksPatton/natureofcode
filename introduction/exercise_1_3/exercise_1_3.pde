Walker w;

void setup() {
  size(640, 340);
  background(255);
  w = new Walker();
}

void draw() {
  w.display();
  w.step();
}