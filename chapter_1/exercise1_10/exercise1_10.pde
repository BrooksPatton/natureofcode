Section s;

void setup() {
  size(650, 300);
  s = new Section();
  background(0);
}

void draw() {
  s.render();
}