class Walker {
  PVector location, velocity;

  Walker(PVector velocity_, PVector location_)
  {
    location = location_;
    velocity = velocity_;
  }

  void step()
  {
    int randomNum = int(random(0, 4));

    if (randomNum == 0)
    {
      location.y = location.y - velocity.y;
    } else if (randomNum == 1)
    {
      location.x = location.x + velocity.x;
    } else if (randomNum == 2)
    {
      location.y = location.y + velocity.y;
    } else
    {
      location.x = location.x - velocity.x;
    }
  }

  void render()
  {
    point(location.x, location.y);
  }
}