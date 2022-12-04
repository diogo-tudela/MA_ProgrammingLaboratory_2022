import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.volume.*;
import toxi.math.waves.*;
import toxi.processing.*;

float brushSize = 20;
float density= 0.01;
float ISO_THRESHOLD = 0.005;

ToxiclibsSupport gfx;

int DIMX = 100;
int DIMY = 100;
int DIMZ = 100;
Vec3D SCALE= new Vec3D(1, 1, 1).scaleSelf(900);

Vec3D brushPos;
VolumetricSpace volume;
VolumetricBrush brush;
IsoSurface surface;
TriangleMesh mesh;



void setup() {  
  fullScreen(P3D);
  background(0, 0, 255);
  smooth(64);
  gfx=new ToxiclibsSupport(this);
  float bx = random(-SCALE.x/2, SCALE.x/2); 
  float by = random(-SCALE.y/2, SCALE.y/2);
  float bz = -SCALE.z/2;
  brushPos = new Vec3D(bx, by, bz);
  volume= new VolumetricSpaceArray(SCALE, DIMX, DIMY, DIMZ);
  brush= new RoundBrush(volume, brushSize);
  surface= new ArrayIsoSurface(volume);
  mesh= new TriangleMesh();
}

void draw() {
  background(0, 0, 255);
  pushMatrix();
  translate(width/2, height/2);
  ijkspace(65, 0.5, SCALE.x, SCALE.y, 90);
  lighting();
  updateBrush();
  displayBrush();
  isoSurface();
  popMatrix();
}

void keyPressed() {
  if (key=='s' || key=='S')makeSTL();
}

void lighting() {
  directionalLight(255, 0, 65, 0, 1, 0);
}

void updateBrush() {

  float speed = 4;
  brushPos.setZ(brushPos.z()+speed);
  brushSize = map(sin(radians(frameCount*2)),-1,1,10,100);
  brush.setSize(brushSize);
  if (brushPos.z()>SCALE.z/2) {
    brushPos.setX(random(-SCALE.x/2, SCALE.x/2)); 
    brushPos.setY(random(-SCALE.y/2, SCALE.y/2));
    brushPos.setZ(-SCALE.z/2);
  }
}

void displayBrush() {
  noStroke();
  fill(255, 0, 65);
  pushMatrix();
  translate(brushPos.x(), brushPos.y(), brushPos.z());
  sphere(brushSize);
  popMatrix();
}

void isoSurface() {
  brush.drawAtAbsolutePos(brushPos, density);
  volume.closeSides();  
  surface.reset();
  surface.computeSurfaceMesh(mesh, ISO_THRESHOLD);
  noStroke();
  fill(255);
  beginShape(TRIANGLES);
  gfx.mesh(mesh);
}

void makeSTL() {
  mesh.saveAsSTL(sketchPath("isoSurface_"+(System.currentTimeMillis()/1000)+".stl"));
}
