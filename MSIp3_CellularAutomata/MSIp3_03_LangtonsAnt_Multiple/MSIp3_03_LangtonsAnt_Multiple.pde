int side = 4;
boolean[][] grid;
PVector[] ants;
PShader blur;


void setup() {
  fullScreen();
  background(0,0,255);
  int cols = width/side;
  int rows = height/side;
  grid = new boolean[cols][rows];
  boolean state;
  for (int i=0; i<grid.length; i++) {
    for (int j=0; j<grid[i].length; j++) {
      float pick = random(0, 20);
      state = false;
      if (pick>20)state = true;
      grid[i][j] = state;
    }
  }

  ants = new PVector[1000];
  for (int i=0; i<ants.length; i++) {
    ants[i] = new PVector(cols/2+i, rows/2);
  }
}


void draw() {
  background(0,0,255);
  for (int i=0; i<ants.length; i++) {
    int posX = int(ants[i].x);
    int posY = int(ants[i].y);
    int dir = int(ants[i].z);
    updateCA(i, posX, posY, dir);
  }
  displayCA();
}




void updateCA(int index, int i, int j, int d) {
  //WRAP
  if (i<0)i=grid.length-1;
  if (i>grid.length-1)i=0;
  if (j<0)j=grid[i].length-1;
  if (j>grid[i].length-1)j=0;
  
  grid[i][j] = !grid[i][j];

  if (grid[i][j]) {
    d++;
    d = d%4;
  } else {
    d--;
    d = d%4;
  }

  if (d<0)d=3;

  switch(d) {
  case 0:
    j--;
    break;
  case 1:
    i++;
    break;
  case 2:
    j++;
    break;
  case 3:
    i--;
    break;
  }

  ants[index].x = i;
  ants[index].y = j;
  ants[index].z = d;
}



void displayCA() {
  noStroke();
  for (int i=0; i<grid.length; i++) {
    for (int j=0; j<grid[i].length; j++) {
      noFill();
      if(grid[i][j])fill(255);
      rect(i*side, j*side, side, side);
    }
  }
}
