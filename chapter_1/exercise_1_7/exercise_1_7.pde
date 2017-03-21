Walker w;

void setup() {
  size(600, 400);
  w = new Walker();
  background(0);
}

void draw() {
  w.display();
  w.step();
}