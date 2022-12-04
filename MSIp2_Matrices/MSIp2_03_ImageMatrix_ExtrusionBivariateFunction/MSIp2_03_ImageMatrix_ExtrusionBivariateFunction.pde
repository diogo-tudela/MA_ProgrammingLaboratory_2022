PImage img;
float[][] function;
float rot = 0;
int res = 2;

void setup() {
  fullScreen(P3D);
  background(0, 0, 255);
  smooth();
  loadFunction();
}



void loadFunction() {
  img = loadImage("img.jpeg");
  img.loadPixels();
  function = new float[img.width][img.height];
}

void draw() {
  background(0, 0, 255);
  pushMatrix();
  translate(width/2, height/2);
  rotateY(radians(rot));
  pushMatrix();
  translate(-(img.width*res/2), -(img.height*res/2));
  updateFunction();
  displayMesh();
  popMatrix();
  popMatrix();
  rot+=1;
}


void updateFunction() {
  float sineWave = sin(radians(frameCount))*((360)*2);
  float cosWave = cos(radians(frameCount))*((360)*3);
  for (int i=0; i<function.length; i++) {
    for (int j=0; j<function[i].length; j++) {
      function[i][j] = saturation(img.get(i, j)) * ((sin(radians(i+sineWave))) * (cos(radians(j+cosWave))));
    }
  }
}



void displayMesh() {
  float min = -200;
  float max = 200;
  noStroke();
  for (int i=0; i<img.width-1; i++) {
    beginShape(QUAD_STRIP);
    for (int j=0; j<img.height; j++) {
      float this_z = map(function[i][j], -255, 255, min, max);
      float next_z = map(function[i+1][j], -255, 255, min, max);
      fill(img.get(i, j));
      vertex(i*res, j*res, this_z);
      vertex((i+1)*res, j*res, next_z);
    }
    endShape();
  }
}
