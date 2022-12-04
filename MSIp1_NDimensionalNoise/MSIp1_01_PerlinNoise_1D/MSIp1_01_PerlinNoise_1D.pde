float[] function;
float xoff;

void setup() {
  fullScreen();
  background(0, 0, 255);
  smooth();
  loadFunction();
}

void loadFunction() {
  function = new float[100];
  for (int i=0; i<function.length; i++) {
    function[i] = noise(xoff);
    xoff+=0.05;
  }
}


void draw() {
  background(0, 0, 255);
  displayFunction();
  displayData();
}

void displayFunction() {
  noFill();
  stroke(255);
  strokeWeight(5);
  beginShape();
  for (int i=0; i<function.length; i++) {
    float x = map(i, 0, function.length-1, 0, width);
    float y = map(function[i], 0, 1, height, 0);
    vertex(x, y);
  }
  endShape();
}

void displayData() {
  strokeWeight(1);
  for (int i=0; i<function.length; i++) {
    float x = map(i, 0, function.length-1, 0, width);
    float y = map(function[i], 0, 1, height, 0);
    stroke(255, 0, 64);
    line(x, y, x, height);
    noStroke();
    fill(255, 0, 64);
    ellipse(x, y, 10, 10);
    fill(255);
    pushMatrix();
    translate(x,y);
    rotate(-HALF_PI);
    textAlign(LEFT,CENTER);
    text("["+i+"] "+function[i], 30, 0);
    popMatrix();
  }
}
