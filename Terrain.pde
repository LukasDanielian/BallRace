class Terrain
{
  int cols, rows, scl, w, d;
  float flying, speed;
  float[][] terrain;

  public Terrain()
  {
    flying  = 0;
    speed = .02;
    scl = 10;
    w = width/2;
    d = height*2;
    cols = w/scl;
    rows = d/scl;
    terrain = new float[cols][rows];
  }

  void render()
  {
    noStroke();
    pushMatrix();
    flying += speed;

    float yOff = flying;
    for (int y = 0; y < rows; y++)
    {
      float xOff = 0;
      for (int x = 0; x < cols; x++)
      {
        terrain[x][y] = map(noise(xOff, yOff), 0, 1, -200, 400) -pow(x-cols/2, 2)/15;
        xOff += .01;
      }
      yOff += .005;
    }

    translate(width/2, height * .65);
    rotateY(PI);
    translate(-w/2, 100, -d+1100); //(-d/2));
    for (int y = 0; y < rows-1; y++)
    {
      beginShape(TRIANGLE_STRIP);
      for (int x = 0; x < cols; x++)
      {
        colorMode(HSB);
        fill((frameCount * .5) % 255, 100, 255);
        colorMode(RGB);
        vertex((x+cols/2)*scl, terrain[x][y], y*scl);
        vertex((x+cols/2)*scl, terrain[x][y+1], (y+1)*scl);
      }
      endShape();
    }
    popMatrix();
  }
}
