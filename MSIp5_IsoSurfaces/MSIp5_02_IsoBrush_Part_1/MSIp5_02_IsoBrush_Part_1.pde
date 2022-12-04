int DIMX = 900;
int DIMY = 900;
int DIMZ = 900;

PVector brush;
float xoff = random(100); 
float yoff = random(100);
float zoff = random(100);


void setup() {  
  fullScreen(P3D);
  background(0, 0, 255);
  smooth(64);
  brush = new PVector(0, 0, 0);
}

void draw() {
  background(0, 0, 255);
  pushMatrix();
  translate(width/2, height/2);
  ijkspace(65, 0.1, DIMX, DIMZ, 90);
  lights();
  updateBrush();
  displayBrush();
  popMatrix();
}

void updateBrush() {
  float x = map(noise(xoff), 0, 1, -DIMX/2, DIMX/2);
  float y = map(noise(yoff), 0, 1, -DIMY/2, DIMY/2);
  float z = map(noise(zoff), 0, 1, -DIMZ/2, DIMZ/2);
  xoff+=0.01;
  yoff+=0.01;
  zoff+=0.01;
  brush.set(x, y, z);
}

void displayBrush(){
  noStroke();
  fill(255,0,65);
  pushMatrix();
  translate(brush.x,brush.y,brush.z);
  sphere(20);
  popMatrix();
}
