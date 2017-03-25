Walker walker;
PVector location, velocity;

void setup()
{
  size(600, 400);
  background(255);
  velocity = new PVector(1, 1);
  location = new PVector(width / 2, height / 2);
  walker = new Walker(velocity, location);
}

void draw()
{
  walker.step();
  walker.render();
}