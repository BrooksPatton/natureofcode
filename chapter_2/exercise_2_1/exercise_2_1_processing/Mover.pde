class Mover
{
  PVector location, velocity, acceleration;
  float w, h;
  boolean atTop;

  Mover(PVector _location)
  {
    location = _location;
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    w = 15;
    h = 25;
    atTop = false;
  }

  void draw()
  {
    stroke(0);
    fill(100);

    ellipse(location.x, location.y, w, h);
  }

  void update()
  {
    setAtTop();
    //if(atTop)
    //{
    //  location.y = h / 2;
    //}
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    velocity.mult(0);
  }

  void applyForce(PVector force)
  {
    acceleration.add(force);
  }

  void setAtTop()
  {
    if (location.y - (h / 2) - 10 <= 0)
    {
      atTop = true;
    } else
    {
      atTop = false;
    }
  }
}