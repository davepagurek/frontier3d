float[][] points;
float[] heights;
int[][] faces;

void setup() {
  size(640, 360, P3D); 
  pixelDensity(displayDensity());
  mouseClicked();
}

void mouseClicked() {
  points = new float[100][2];
  heights = new float[100];
  
  for (int i=0; i<points.length; i++) {
    points[i][0] = random(0, width);
    points[i][1] = random(0, height);
    heights[i] = noise(points[i][0]/100, points[i][1]/100)*400;
  }
  
  faces = delaunayFaces(points);
}

void draw() {
  background(255);
  
  translate(width/2, height/2, 0); // - mouseY
  rotateX((-float(mouseY) / float(height) + 0.5) * PI);
  translate(-width/2, -height/2, -200);
  //rotateY(float(mouseX) / float(width) * 2*PI);
  
  
  for (int i = 0; i < faces.length; i++) {
     fill(#FFFFFF);
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
  
  
  //for(int i=0; i<links.length; i++) {
  //  int last = -1;
  //  for (int j=i+1; j<links[i].length; j++) {
  //    if (!links[i][j]) continue;
  //    if (last != -1) {
  //      fill(#FFFFFF);
  //      beginShape();
  //      vertex(points[i][0], points[i][1], 0);
  //      vertex(points[last][0], points[last][1], 0);
  //      vertex(points[j][0], points[j][1], 0);
  //      endShape(CLOSE);
  //      println(i + " --> " + last + " --> " + j);
  //      last = -1;
  //    } else {
  //      last = j;
  //    }
  //  }
  //}
  
  //for (int i = 0; i < points.length; i++) {
  //  float[][] coords = regions[i].getCoords();
  //  beginShape();
  //  for (int point = 0; point < coords.length; point++) {
  //    vertex(coords[point][0], coords[point][1], points[i][2]);
  //  }
  //  endShape(CLOSE);
  //  //fill(0);
  //  //ellipse(points[i][0], points[i][1], 10, 10);
  //  //fill(255);
  //  //regions[i].draw(this);
  //}
}