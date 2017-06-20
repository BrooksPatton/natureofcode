PVector gravity, wind;
ArrayList<Mover> movers = new ArrayList<Mover>();

void setup()
{
  size(1200, 400);

  for (int i = 0; i < 100; i++)
  {
    float mass = random(0.1, 5.0);
    PVector location = new PVector(0, 0);
    movers.add(new Mover(mass, location));
  }

  gravity = new PVector(0, 0.1);
  wind = new PVector(0.1, 0);
}

void draw()
{
  background(255);

  for (int i = 0; i < movers.size(); i++)
  {
    Mover mover = movers.get(i);
    PVector rightWind = new PVector(mover.location.x * -0.0002, 0);
    
    mover.applyForce(gravity);
    mover.applyForce(wind);
    mover.applyForce(rightWind);
    mover.checkEdges();
    mover.draw();
    mover.update();
  }
}