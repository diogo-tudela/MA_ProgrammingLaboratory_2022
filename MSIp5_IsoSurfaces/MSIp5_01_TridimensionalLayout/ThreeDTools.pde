void ijkspace(float pitch, float speed, float w, float h, float r) {
  float rot = radians(frameCount*speed);
  rotateX(radians(pitch));
  rotateZ(rot);
  grid(w, h, r);
  origin(w/2, rot);
}

void origin(float axis, float rot) {
  color red = color(255, 0, 0);
  float arrow = axis/20;
  float arrowWidthRatio = 4; 
  stroke(red);
  //X Axis
  line(0, 0, 0, axis, 0, 0);
  //Y Axis
  line(0, 0, 0, 0, axis, 0);
  //Z Axis
  line(0, 0, 0, 0, 0, axis);
  noStroke();
  fill(red);
  //X Arrow
  beginShape();
  vertex(axis-arrow, -arrow/arrowWidthRatio, 0);
  vertex(axis, 0, 0);
  vertex(axis-arrow, +arrow/arrowWidthRatio, 0);
  endShape(CLOSE);
  //Y Arrow
  beginShape();
  vertex(-arrow/arrowWidthRatio, axis-arrow, 0);
  vertex(0, axis, 0);
  vertex(arrow/arrowWidthRatio, axis-arrow, 0);
  endShape(CLOSE);
  //Z Arrow
  pushMatrix();
  rotateZ(-rot+HALF_PI);
  beginShape();
  vertex(0, -arrow/arrowWidthRatio, axis-arrow);
  vertex(0, 0, axis);
  vertex(0, arrow/arrowWidthRatio, axis-arrow);
  endShape(CLOSE);
  popMatrix();
}


void grid(float w, float h, float s) {
  pushStyle();
  noFill();
  stroke(255,64);
  float cellWidth = w/s;
  float cellHeight= h/s; 
  float xOffSet = -(w/2);
  float yOffSet = -(h/2);
  for (float x=0; x<s; x++) {
    float ox = xOffSet+lerp(0, w, x/s);
    for (float y=0; y<s; y++) {
      float oy = yOffSet+lerp(0, h, y/s);
      rect(ox, oy, cellWidth, cellHeight);
    }
  }
  popStyle();
}
