float[][] function;
float rot = 0;
float res = 2;
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
      function[i][j] = sin(radians(dist(i,j,function.length/2,function[i].length/2)*map(sin(radians(frameCount)),-1,1,0,10)));
    }
  }
}



void displayMesh() {
  float min = -100;
  float max = 100;
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
  popStyle();
}
