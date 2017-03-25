Land land;

void setup() {
  size(600, 400, P3D);
  land = new Land();
  stroke(0);
}

void draw() {
  background(0);
  pushMatrix();
  translate(100, 60, -190);
  rotateX(PI/3);
  land.render();
  popMatrix();
  land.calculate_peaks();
}