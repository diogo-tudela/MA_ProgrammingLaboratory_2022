PImage img;
float rot = 0;
int res = 2;

void setup() {
  fullScreen(P3D);
  background(0, 0, 255);
  smooth();
  loadImage();
}

void loadImage() {
  img = loadImage("img.jpeg");
  img.loadPixels();
}

void draw() {
  background(0, 0, 255);
  pushMatrix();
  translate(width/2, height/2);
  rotateY(radians(rot));
  pushMatrix();
  translate(-(img.width*res/2), -(img.height*res/2));
  displayMesh();
  popMatrix();
  popMatrix();
  rot+=1;
}

void displayMesh() {
  float min = -50;
  float max = 50;
  noStroke();
  for (int i=0; i<img.width-1; i++) {
    beginShape(QUAD_STRIP);
    for (int j=0; j<img.height; j++) {
      float this_Bright = brightness(img.get(i, j));
      float next_bright = brightness(img.get(i+1, j));
      float this_z = map(this_Bright, 255, 0, min, max);
      float next_z = map(next_bright, 255, 0, min, max);
      fill(img.get(i, j));
      vertex(i*res, j*res, this_z);
      vertex((i+1)*res, j*res, next_z);
    }
    endShape();
  }
}
