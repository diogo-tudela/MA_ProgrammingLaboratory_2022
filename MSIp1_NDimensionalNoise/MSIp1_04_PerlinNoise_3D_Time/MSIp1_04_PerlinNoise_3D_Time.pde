float[][] function;
int res = 5;
int xres, yres; 
float xoff, yoff, toff;

void setup() {
  fullScreen();
  background(0, 0, 255);
  smooth();
  xres = 3*(width/4)/res;
  yres = 3*(height/4)/res;
  loadFunction();
}

void loadFunction() {
  function = new float[xres][yres];
  yoff=0;
  for (int i=0; i<function.length; i++) {
    xoff=0;
    for (int j=0; j<function[i].length; j++) {
      function[i][j] = noise(xoff, yoff);
      xoff+=0.05;
    }
    yoff+=0.05;
  }
}

void draw() {
  background(0, 0, 255);
  updateFunction();
  displayFunction();
}


void updateFunction() {
  yoff=0;
  for (int i=0; i<function.length; i++) {
    xoff=0;
    for (int j=0; j<function[i].length; j++) {
      function[i][j] = noise(xoff, yoff, toff);
      xoff+=0.05;
    }
    yoff+=0.05;
  }
  toff+=0.01;
}

void displayFunction() {
  float posX = width/2-(xres*res/2);
  float posY = height/2-(yres*res/2);
  noStroke();
  beginShape();
  for (int i=0; i<function.length; i++) {
    for (int j=0; j<function[i].length; j++) {
      float val = map(function[i][j], 0, 1, 0, 255);
      fill(255, val);
      rect(posX+i*res, posY+j*res, res, res);
    }
  }
  noFill();
  stroke(255);
  strokeWeight(3);
  rect(posX, posY, xres*res, yres*res);
  endShape();
}
