float WORLD_SIZE = 10000;
color skyColor = #9CF7D3;
color ambient = #6337AD;
color main = #FAE8B6;
color bg = #4E85DE;

Island island;
Water water;

void setup() {
  size(640, 360, P3D); 
  pixelDensity(displayDensity());
  mouseClicked();
}

void mouseClicked() {
  island = new Island();
  water = new Water();
}

void draw() {
  background(skyColor);
  noStroke();
  
  translate(width/2, height/2, 0); // - mouseY
  rotateX(-0.5*PI);
  
  translate(0, (float(mouseY) / float(height) - 0.5) * Island.RADIUS*1.5, 0);
  translate(0, Island.RADIUS, -Island.RADIUS*0.75); // - mouseY
  rotateZ(float(mouseX) / float(width) * 2*PI);
  
  /*ambientLight(red(ambient), green(ambient), blue(ambient));
  pointLight(red(main), green(main), blue(main), 0, 300, -100);
  pointLight(red(bg), green(main), blue(main), 0, -300, -400);*/

  island.draw();
  water.draw();
}