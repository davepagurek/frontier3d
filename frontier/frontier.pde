float[][] points;
float[] heights;
int[][] faces;

int radius = 200;

void setup() {
  size(640, 360, P3D); 
  pixelDensity(displayDensity());
  mouseClicked();
}

void mouseClicked() {
  points = new float[200][2];
  heights = new float[200];
  float offset = random(100,500);
  
  for (int i=0; i<points.length; i++) {
    points[i][0] = random(-radius, radius);
    points[i][1] = random(-radius, radius);
    heights[i] = noise(offset+points[i][0]/100, offset+points[i][1]/100)*400;
  }
  
  faces = delaunayFaces(points);
}

void draw() {
  background(255);
  noStroke();
  ambientLight(40, 112, 184);
  pointLight(126, 204, 194, 0, 200, 100);
  pointLight(237, 215, 114, 0, 0, 200);
  
  translate(width/2, height/2, 0); // - mouseY
  rotateX(-0.5*PI);
  translate(0, radius, -radius*0.75); // - mouseY
  //rotateX((-float(mouseY) / float(height) + 0.5) * PI);
  //translate(-width/2, -height/2, -200);
  //rotateY(float(mouseX) / float(width) * 2*PI);
  //rotateX((-float(mouseY) / float(height) + 0.5) * PI);
  translate(0, (float(mouseY) / float(height) - 0.5) * radius*1.5, 0);
  rotateZ(float(mouseX) / float(width) * 2*PI);
  
  
  for (int i = 0; i < faces.length; i++) {
    fill(#C22F2F);
    beginShape();  
    for (int j = 0; j< faces[i].length; j++) {
      int pt = faces[i][j];
      if ( pt < points.length  )
      {
        vertex( points[pt][0], points[pt][1], heights[pt] );
      }
    }
    endShape(CLOSE);
  }
}
