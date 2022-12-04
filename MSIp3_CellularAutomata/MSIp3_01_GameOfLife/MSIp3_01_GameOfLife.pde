int side = 4;
boolean run = false;
boolean[][] grid, bufferGrid;

void setup() {
  fullScreen();
  int cols = width/side;
  int rows = height/side;
  grid = new boolean[cols][rows];
  bufferGrid = new boolean[cols][rows];
  boolean life;
  for (int i=0; i<grid.length; i++) {
    for (int j=0; j<grid[i].length; j++) {
      float pick = random(0, 100);
      life = false;
      if (pick>65)life = true;
      grid[i][j] = life;
    }
  }
}


void draw() {
  updateCA();
  displayCA();
}


void updateCA() {
  for (int i=0; i<grid.length; i++) {
    for (int j=0; j<grid[i].length; j++) {
      checkCA(i, j);
    }
  }  

  for (int i=0; i<grid.length; i++) {
    for (int j=0; j<grid[i].length; j++) {
      grid[i][j] = bufferGrid[i][j];
    }
  }
}

void checkCA(int i, int j) {

  int count = 0;
  for (int ni=i-1; ni<=i+1; ni++) {
    for (int nj=j-1; nj<=j+1; nj++) { 
      int check_ni = ni;
      int check_nj = nj;    
      if (ni<0)check_ni = grid.length-1;
      if (ni>grid.length-1)check_ni = 0;
      if (nj<0)check_nj = grid[i].length-1;
      if (nj>grid[i].length-1)check_nj = 0;       
      if (grid[check_ni][check_nj] && !(ni==i && nj==j)) {
        count++;
      }
    }
  }
  narrativeCA(i, j, count);
}

void narrativeCA(int i, int j, int count) {
  boolean bufferLife = false;
  if (grid[i][j] && count<2)bufferLife = false;
  if (grid[i][j] && count>3)bufferLife = false;
  if (grid[i][j] && count==2)bufferLife = true;
  if (grid[i][j] && count==3)bufferLife = true;
  if (grid[i][j]==false && count==3)bufferLife = true;
  bufferGrid[i][j] = bufferLife;
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
