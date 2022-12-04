float[][] function;
int res = 5;
int xres, yres; 
float xoff, yoff, toff;

void setup() {
  fullScreen(P3D);
  background(0, 0, 255);
  smooth();
  xres = 100;
  yres = 100;
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
  pushMatrix();
  translate(width/2, height/2);
  rotateX(radians(75));
  rotateZ(QUARTER_PI);
  updateFunction();
  displayFunction();
  displayMesh();
  popMatrix();
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
  toff+=0.005;
}

void displayFunction() {
  noStroke();
  beginShape();
  for (int i=0; i<function.length; i++) {
    for (int j=0; j<function[i].length; j++) {
      float val = map(function[i][j], 0, 1, 0, 255);
      fill(255, val);
      rect(i*res, j*res, res, res);
    }
  }
  noFill();
  stroke(255);
  strokeWeight(3);
  rect(0, 0, xres*res, yres*res);
  endShape();
}


void displayMesh() {
  float min = 50;
  float max = 200;
  noStroke();
  for (int i=0; i<function.length-1; i++) {
    beginShape(QUAD_STRIP);
    for (int j=0; j<function[i].length; j++) {
      float this_z = map(function[i][j], 0, 1, min, max);
      float next_z = map(function[i+1][j], 0, 1, min, max);
      float R = map(this_z, min, max, 0, 255);
      float G = map(this_z, min, max, 0, 0);
      float B = map(this_z, min, max, 255, 65);
      fill(R, G, B);
      vertex(i*res, j*res, this_z);
      vertex((i+1)*res, j*res, next_z);
    }
    endShape();
  }
}
