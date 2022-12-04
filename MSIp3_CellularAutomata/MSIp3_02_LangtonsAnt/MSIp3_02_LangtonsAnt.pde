int side = 8;
boolean run = false;
boolean[][] grid;
int anti, antj, antd;

void setup() {
  fullScreen();
  int cols = width/side;
  int rows = height/side;
  grid = new boolean[cols][rows];
  for (int i=0; i<grid.length; i++) {
    for (int j=0; j<grid[i].length; j++) {
      grid[i][j] = false;
    }
  }
  anti = int(cols/2);
  antj = int(rows/2);
  antd = 0;
}


void draw() {
  updateCA(anti, antj);
  displayCA();
  displayAnt();
}

void displayAnt() {
  noStroke();
  fill(255, 0, 64);
  rect(anti*side, antj*side, side, side);
}



void updateCA(int i, int j) {
  
  //WRAP
  if(i<0)i=grid.length-1;
  if(i>grid.length-1)i=0;
  if(j<0)j=grid[i].length-1;
  if(j>grid[i].length-1)j=0;

  if (grid[i][j]) {
    antd++;
    antd = antd%4;
  } else {
    antd--;
    antd = antd%4;
  }

  if (antd<0)antd=3;

  switch(antd) {
  case 0:
    antj--;
    break;
  case 1:
    anti++;
    break;
  case 2:
    antj++;
    break;
  case 3:
    anti--;
    break;
  }

  grid[i][j] = !grid[i][j];
}



void displayCA() {
  noStroke();
  for (int i=0; i<grid.length; i++) {
    for (int j=0; j<grid[i].length; j++) {
      fill(0,0,255);
      if (grid[i][j])fill(255);
      rect(i*side, j*side, side, side);
    }
  }
}
