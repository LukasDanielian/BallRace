class Effect
{
  float x, y, z, zMover, size;
  ArrayList<Effect> neighbors = new ArrayList<Effect>();
  public Effect()
  {

    z = -width * 4;
    zMover = 180;

    do
    {
      x = random(-width, width * 2)-terrain.cols/2*terrain.scl;
      y = random(-width, width  * 2);
    }
    while (dist(width/2-terrain.cols/2*terrain.scl, height/2, x, y) <= width || dist(width/2-terrain.cols/2*terrain.scl, height/2, x, y) >= width * 1.01);

    for (Effect e : effects) {
      if (dist(e.x, e.y, e.z, x, y, z) < height/2) {
        neighbors.add(e);
      }
    }

    size = random(40, 75);
  }

  void render()
  {
    strokeWeight(1);
    for (Effect e : neighbors)
    {
      line(x, y, z, e.x, e.y, e.z);
      colorMode(HSB);
      stroke((frameCount * .5) % 255, 255, 200);
      colorMode(RGB);
    }

    pushMatrix();
    translate(width/2, height/2);
    //rotateZ(frameCount * .1);
    translate(-width/2, -height/2);
    translate(x, y, z);
    popMatrix();
  }

  void move()
  {
    z += zMover;
  }
}
