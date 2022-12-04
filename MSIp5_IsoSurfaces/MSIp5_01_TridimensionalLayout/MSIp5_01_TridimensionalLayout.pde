void setup() {  
  fullScreen(P3D);
  background(0, 0, 255);
  smooth(64);
}

void draw() {
  background(0, 0, 255);
  pushMatrix();
  translate(width/2, height/2);
  ijkspace(65, 0.1, 900, 900, 90);
  popMatrix();
}
