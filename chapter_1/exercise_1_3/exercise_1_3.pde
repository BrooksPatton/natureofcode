PVector boxLocation, boxSize;
Box box;
ArrayList<Ball> balls = new ArrayList<Ball>();

void setup()
{
  int numBalls = 500;
  
  size(600, 400, P3D);
  background(255);
  boxLocation = new PVector(width / 2, height / 2, -200);
  boxSize = new PVector(100, 100, 500);
  box = new Box(boxLocation, boxSize);
  
  for (int i = 0; i < numBalls; i++)
  {
    float rx = random(-5, 5);
    float ry = random(-5, 5);
    float rz = random(-5, 5);
    PVector ballLocation = new PVector(width / 2, height / 2, 0.0);
    PVector ballVelocity = new PVector(rx, ry, rz);

    balls.add(new Ball(ballLocation, ballVelocity, box));
  }
}

void draw()
{
  background(255);

  for (Ball ball : balls)
  {
    ball.move();
    ball.render();
  }

  box.render();

  beginCamera();
  camera();
  rotateX(-PI/-6);
  rotateY(-PI/-6);
  endCamera();
}