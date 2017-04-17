Mover mover;
PVector gravity, bounce, ceiling;
float xoff;

void setup()
{
  size(600, 400);

  PVector location = new PVector(width / 2, height / 1.2);
  gravity = new PVector(0, -3);
  mover = new Mover(location);
  bounce = new PVector(0, gravity.y * -2);
  ceiling = new PVector(0, gravity.y * -1);
  xoff = 0.0;
}

void draw()
{
  background(255);
  PVector wind = new PVector(map(noise(xoff), 0, 1, -1, 1), 0);
    mover.applyForce(gravity);
    mover.applyForce(wind);
    if(mover.atTop)
    {
      mover.applyForce(bounce);
      mover.applyForce(ceiling);
      bounce.mult(0.5);
    }
  mover.update();
  mover.draw();
  
  xoff += 0.01;
}