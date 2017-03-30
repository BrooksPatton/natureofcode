class Ball
{
  PVector location, velocity;
  Box box;
  int red, green, blue;

  Ball(PVector location_, PVector velocity_, Box box_)
  {
    location = location_;
    velocity = velocity_;
    box = box_;
    location.x = box.location.x;
    location.y = box.location.y;
    location.z = box.location.z;
    red = int(random(0, 256));
    green = int(random(0, 256));
    blue = int(random(0, 256));
  }

  void render()
  {
    pushMatrix();
    fill(red, green, blue);
    noStroke();
    lights();
    translate(location.x, location.y, location.z);
    sphere(10);
    popMatrix();
  }
  
  void move()
  {
    if(location.x < box.location.x - (box.size.x / 2))
    {
      location.x = box.location.x - (box.size.x / 2);
      velocity.x = -velocity.x;
    }
    else if(location.x > box.location.x + (box.size.x / 2))
    {
      location.x = box.location.x + (box.size.x / 2);
      velocity.x = -velocity.x;
    }
    
    if(location.y < box.location.y - (box.size.y / 2))
    {
      location.y = box.location.y - (box.size.y / 2);
      velocity.y = -velocity.y;
    }
    else if(location.y > box.location.y + (box.size.y / 2))
    {
      location.y = box.location.y + (box.size.y / 2);
      velocity.y = -velocity.y;
    }
    
    if(location.z < box.location.z - (box.size.z / 2))
    {
      location.z = box.location.z - (box.size.z / 2);
      velocity.z = -velocity.z;
    }
    else if(location.z > box.location.z + (box.size.z / 2))
    {
      location.z = box.location.z + (box.size.z / 2);
      velocity.z = -velocity.z;
    }
    
    location.x = location.x + velocity.x;
    location.y = location.y + velocity.y;
    location.z = location.z + velocity.z;
  }
}