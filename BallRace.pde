Terrain terrain;
ArrayList<Player> players;
ArrayList<Effect> effects;
boolean gameOver;
float zChange = 0;
boolean winScreen = false;
void setup()
{
  winScreen = false;
  fullScreen(P3D);
  shapeMode(CENTER);
  textAlign(CENTER, CENTER);
  strokeJoin(ROUND);
  terrain = new Terrain();
  players = new ArrayList<Player>();
  effects = new ArrayList<Effect>();

  gameOver = false;
  for (int i = 0; i < 10000; i++)
  {
    players.add(new Player());
  }

  perspective(PI/1.5, float(width)/height, 0.01, 4 * width);
}

void draw()
{
  if (winScreen) 
  {
    delay(2500);
    setup();
  }
  
  background(0);
  colorMode(RGB);
  pushMatrix();
  
  if (!gameOver) 
  {
    translate(terrain.cols/2*terrain.scl, -terrain.terrain[terrain.terrain.length/2][10] - 100, 0);
    rotateZ(atan2((terrain.terrain[0][50]-terrain.terrain[terrain.cols-1][50])/2, terrain.scl*terrain.cols) * 2);
  }

  directionalLight(255, 255, 255, 0, 1, -1);
  lights();

  if (!gameOver)
  {
    noStroke();
    fill(255);
    textSize(75);
    text("Balls Left: " + players.size(), width/4, height/2);
    
    //MAP
    terrain.render();

    //PLAYER
    zChange = 0;
    for (int i = 0; i < players.size(); i++)
    {
      if (players.get(i).y > height || players.get(i).z < 1)
      {
        players.remove(i);
        i--;
      } else {
        players.get(i).render();
      }
    }
    for (int i = 0; i < players.size(); i++)
    {
      players.get(i).z -= (zChange-players.size()*50)/players.size();
    }
    if (players.size() <= 1)
    {
      gameOver = true;
    }

    for (int i = 0; i < 25; i++)
    {
      effects.add(new Effect());
    }

    for (int i = 0; i < effects.size(); i++)
    {
      effects.get(i).render();
      if (effects.get(i).z > width)
      {
        effects.remove(i);
        i--;
      }
    }

    for (int i = 0; i < effects.size(); i++)
    {
      effects.get(i).move();
    }
  } else
  {
    if (players.size() == 1) {
      pushMatrix();
      translate(width/2, height/2);
      noStroke();
      colorMode(HSB);
      fill(players.get(0).hue, 255, 255);
      sphere(400);

      hint(DISABLE_DEPTH_TEST);
      textSize(200);
      fill(255);
      text("Winner!", 0, height * .75);
      hint(ENABLE_DEPTH_TEST);
      popMatrix();
      winScreen = true;
    }
  }

  popMatrix();
}
