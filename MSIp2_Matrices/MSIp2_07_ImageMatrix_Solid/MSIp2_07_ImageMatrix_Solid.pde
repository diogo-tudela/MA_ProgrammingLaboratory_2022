import nervoussystem.obj.*;
float[][] function;
float rot = 0;
float res = 2;
int xres = 360;
int yres = 360;
boolean record = false;

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
  lights();//<---------------- !!!
  pushMatrix();
  translate(width/2, height/2);
  rotateX(radians(65));
  rotateZ(radians(rot));
  pushMatrix();
  translate(-(xres*res/2), -(yres*res/2));
  updateFunction();
  if (record)beginRecord("nervoussystem.obj.OBJExport", "model_"+(System.currentTimeMillis()/1000)+".obj");
  displayMesh();
  if (record) {
    endRecord();
    record = false;
  }
  popMatrix();
  popMatrix();
  rot+=1;
}

void keyPressed() {
  if (key=='s'||key=='S')record = true;
}


void updateFunction() {
  float speed = 0.5;
  float maxFreq = 3;
  float minFreq = -maxFreq;
  for (int i=0; i<function.length; i++) {
    for (int j=0; j<function[i].length; j++) {
      function[i][j] = sin(radians(dist(i, j, 10, 10)*map(sin(radians(frameCount*speed)), -1, 1, minFreq, maxFreq)));
      function[i][j]*= sin(radians(dist(i, j, function.length-10, 10)*map(sin(radians(frameCount*speed)), -1, 1, minFreq, maxFreq)));
      function[i][j]*= sin(radians(dist(i, j, 10, function[i].length-10)*map(sin(radians(frameCount*speed)), -1, 1, minFreq, maxFreq)));
      function[i][j]*= sin(radians(dist(i, j, function.length-10, function[i].length-10)*map(sin(radians(frameCount*speed)), -1, 1, minFreq, maxFreq)));
    }
  }
}



void displayMesh() {
  float min = -100;
  float max = 100;
  float modelHeight = -100;
  noStroke();
  fill(255, 0, 65);
  top(min, max);
  bottom(modelHeight, min, max);
  sides(modelHeight, min, max);
}

void top(float min, float max) {
  //TOP
  for (int i=0; i<xres-1; i++) {
    beginShape(QUAD_STRIP);
    for (int j=0; j<yres; j++) {
      float this_z = map(function[i][j], -1, 1, min, max);
      float next_z = map(function[i+1][j], -1, 1, min, max);
      vertex(i*res, j*res, this_z);
      vertex((i+1)*res, j*res, next_z);
    }
    endShape();
  }
}

void bottom(float modelHeight, float min, float max) {
  //BOTTOM
  for (int i=0; i<xres-1; i++) {
    beginShape(QUAD_STRIP);
    for (int j=0; j<yres; j++) {
      vertex(i*res, j*res, modelHeight);
      vertex((i+1)*res, j*res, modelHeight);
    }
    endShape();
  }
}

void sides(float modelHeight, float min, float max) {
  //SIDE
  beginShape(QUAD_STRIP);
  for (int i=0; i<xres; i++) {
    float this_z = map(function[i][0], -1, 1, min, max);
    vertex(i*res, 0, this_z);
    vertex(i*res, 0, modelHeight);
  }
  endShape();
  //SIDE
  beginShape(QUAD_STRIP);
  for (int i=0; i<xres; i++) {
    float this_z = map(function[i][yres-1], -1, 1, min, max);
    vertex(i*res, (yres-1)*res, this_z);
    vertex(i*res, (yres-1)*res, modelHeight);
  }
  endShape();
  //SIDE
  beginShape(QUAD_STRIP);
  for (int j=0; j<yres; j++) {
    float this_z = map(function[0][j], -1, 1, min, max);
    vertex(0, j*res, this_z);
    vertex(0, j*res, modelHeight);
  }
  endShape();
  //SIDE
  beginShape(QUAD_STRIP);
  for (int j=0; j<yres; j++) {
    float this_z = map(function[xres-1][j], -1, 1, min, max);
    vertex((xres-1)*res, j*res, this_z);
    vertex((xres-1)*res, j*res, modelHeight);
  }
  endShape();
}
