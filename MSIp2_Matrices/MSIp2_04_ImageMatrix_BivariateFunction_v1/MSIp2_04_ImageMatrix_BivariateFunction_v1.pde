float[][] function;
float rot = 0;
float res = 1.5;
int xres = 360;
int yres = 360;

void setup() {
  fullScreen(P3D);
  background(0, 0, 255);
  smooth();
  loadFunction();
}



void loadFunction() {
  function = new float[xres][yres];
}

void draw() {
  background(0, 0, 255);
  lights();
  pushMatrix();
  translate(width/2, height/2);
  rotateY(radians(rot));
  pushMatrix();
  translate(-(xres*res/2), -(yres*res/2));
  updateFunction();
  displayMesh();
  popMatrix();
  popMatrix();
  rot+=1;
}


void updateFunction() {
  for (int i=0; i<function.length; i++) {
    for (int j=0; j<function[i].length; j++) {
      function[i][j] = sin(radians(frameCount*2+i*2))*cos(radians(frameCount*2+j*2));
    }
  }
}



void displayMesh() {
  float min = -200;
  float max = 200;
  noStroke();
  pushStyle();
  colorMode(HSB);
  for (int i=0; i<xres-1; i++) {
    beginShape(QUAD_STRIP);
    for (int j=0; j<yres; j++) {
      float this_z = map(function[i][j], -1, 1, min, max);
      float next_z = map(function[i+1][j], -1, 1, min, max);
      float mapVal = map(function[i][j], -1, 1, 0, 255);
      fill(mapVal, mapVal, mapVal);
      vertex(i*res, j*res, this_z);
      vertex((i+1)*res, j*res, next_z);
    }
    endShape();
  }


  stroke(255);
  strokeWeight(3);
  for (int i=0; i<xres-1; i++) {
    for (int j=0; j<yres; j++) {
      if (function[i][j]==1)line(i*res, j*res, max+50, i*res, j*res, max+100);
      if (function[i][j]==-1)line(i*res, j*res, min-50, i*res, j*res, min-100);

    }
  }


  popStyle();
}
