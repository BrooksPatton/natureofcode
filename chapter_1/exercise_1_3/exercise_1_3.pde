PVector ballLocation, ballVelocity, boxLocation, boxSize;
Ball ball;
Box box;

void setup()
{
  size(600, 400, P3D);
  background(255);
  ballLocation = new PVector(width / 2, height / 2, 0.0);
  ballVelocity = new PVector(-3.0, -1.0, -2.0);
  boxLocation = new PVector(width / 2, height / 2, -200);
  boxSize = new PVector(100, 100, 500);

  box = new Box(boxLocation, boxSize);
  ball = new Ball(ballLocation, ballVelocity, box);
}

void draw()
{
  background(255);
  ball.move();
  ball.render();
  box.render();

  beginCamera();
  camera();
  rotateX(-PI/-6);
  rotateY(-PI/-6);
  endCamera();
}