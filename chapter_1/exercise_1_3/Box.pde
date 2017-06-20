class Box
{
  PVector location, size;

  Box(PVector location_, PVector size_)
  {
    location = location_;
    size = size_;
  }

  void render()
  {
    pushMatrix();
    translate(location.x, location.y, location.z);
    noFill();
    stroke(0);
    box(size.x, size.y, size.z);
    popMatrix();
  }
}