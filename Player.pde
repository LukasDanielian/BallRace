class Player
{
  float x, y, yVel, xVel, z;
  float hue;
  public Player()
  {
    x = random(3*width/8, 5*width/8);
    y = height / 2;
    z = random(25, 75);
    yVel = 0;
    xVel = 0;
    hue = map(x, 3*width/8, 5*width/8, 0, 255);
  }

  void render()
  {
    pushMatrix();
    translate(-x+width-terrain.cols/2*terrain.scl, y+30, 1050-z*terrain.scl-10);
    colorMode(HSB);
    stroke(hue, 255, 255);
    strokeWeight(5);
    point(0,0,0);
    colorMode(RGB);
    //box(5);
    point(0, 0);
    popMatrix();

    if (x > width/4 && x < 3 * width/4)
    {
      if (y >= terrain.terrain[(int)map(x, width/4, 3*width/4, 0, terrain.terrain.length-1)][ceil(z)] + height/1.45)
      {
        float py = y;
        y = terrain.terrain[(int)map(x, width/4, 3*width/4, 0, terrain.terrain.length-1)][ceil(z)] + height/1.45;
        yVel = -1*terrain.speed*10*(py-y)*5;
        z += (py-y)*.1;
        xVel += (terrain.terrain[min((int)map(x, width/4, 3*width/4, 0, terrain.terrain.length-1)+1, terrain.cols-1)][ceil(z)]-terrain.terrain[max((int)map(x, width/4, 3*width/4, 0, terrain.terrain.length-1)-1, 0)][ceil(z)])/5;
      } else
      {
        yVel += 1;
        y += yVel;
      }
      x += xVel;
      //xVel *= .8;
    } else
    {
      yVel += 1;
      y += yVel;
      x += xVel;
    }
    zChange += z;
  }
}
