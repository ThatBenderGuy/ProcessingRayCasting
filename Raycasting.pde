ArrayList<Boundary> walls = new ArrayList<Boundary>();
Ray ray;
Particle particle;
boolean mouseControl = true;
float xoff = 0;
float yoff = 50000;

void setup() {

  size(800, 600, P2D);
  for (int i = 0; i < 5; i++) {
    int x1 = (int)random(width);
    int y1 = (int)random(height);
    int x2 = (int)random(width);
    int y2 = (int)random(height);
    walls.add(new Boundary(x1, y1, x2, y2));
  }
  
  walls.add(new Boundary(0, 0, width, 0));
  walls.add(new Boundary(width, 0, width, height));
  walls.add(new Boundary(width, height, 0, height));
  walls.add(new Boundary(0, height, 0, 0));
  
  particle = new Particle();
}

void draw() {

  background(0);
  for (Boundary wall : walls) {
    wall.show();
  }
  if (!mouseControl) {
    particle.update(noise(xoff)*width, noise(yoff)*height, false);
  } else {
    particle.update(mouseX, mouseY, true); 
  }
  particle.show();
  particle.look(walls);

  xoff += 0.005;
  yoff += 0.005;
}

void keyPressed(){
  if(keyCode == 'M'){
    mouseControl = !mouseControl;
  }
}
