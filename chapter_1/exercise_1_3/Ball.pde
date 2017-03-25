class Ball
{
  PVector location, velocity;
  Box box;

  Ball(PVector location_, PVector velocity_, Box box_)
  {
    location = location_;
    velocity = velocity_;
    box = box_;
  }

  void render()
  {
    pushMatrix();
    fill(200);
    noStroke();
    lights();
    translate(location.x, location.y, location.z);
    sphere(50);
    popMatrix();
  }
  
  void move()
  {
    if(location.x > box.location.x)
    {
      location.x = box.location.x;
      velocity.x = -velocity.x;
    }
    else if(location.x < 0)
    {
      location.x = 0;
      velocity.x = -velocity.x;
    }
    
    if(location.y > box.location.y)
    {
      location.y = box.location.y;
      velocity.y = -velocity.y;
    }
    else if(location.y < 0)
    {
      location.y = 0;
      velocity.y = -velocity.y;
    }
    
    if(location.z < -box.size.z + box.location.z)
    {
      location.z = -box.size.z + box.location.z;
      velocity.z = -velocity.z;
    }
    else if(location.z > 0 + box.location.z)
    {
      location.z = 0 + box.location.z;
      velocity.z = -velocity.z;
    }
    
    location.x = location.x + velocity.x;
    location.y = location.y + velocity.y;
    location.z = location.z + velocity.z;
  }
}