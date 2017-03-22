Land land;

void setup() {
  size(600, 400, P3D);
  land = new Land();
  stroke(0);
}

void draw() {
  background(0);
  pushMatrix();
  translate(0, 75, -160);
  rotateX(PI/3);
  land.render();
  popMatrix();
  land.calculate_peaks();
}