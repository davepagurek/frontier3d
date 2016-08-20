class Island {
  private float[][] points;
  private float[] heights;
  private int[][] faces;

  private float spikiness;

  public static final int RADIUS = 200;
  private static final int NUM_POINTS = 800;
  private static final int NUM_SURROUNDING = 100;

  Island() {
    points = new float[NUM_POINTS + NUM_SURROUNDING][2];
    heights = new float[NUM_POINTS + NUM_SURROUNDING];
    float offset = random(100,500);

    spikiness = random(0.008, 0.02);
    
    for (int i=0; i<NUM_POINTS; i++) {
      points[i][0] = random(-RADIUS, RADIUS);
      points[i][1] = random(-RADIUS, RADIUS);
      heights[i] = (
        noise(offset+points[i][0]*spikiness, offset+points[i][1]*spikiness)
        + pow(sqrt(pow(points[i][0],2) + pow(points[i][1],2))/(RADIUS*1.5), 2)
      )*400;
    }

    for (int i=0; i<NUM_SURROUNDING; i++) {
      points[NUM_POINTS+i][0] = 2 * RADIUS * cos(float(i)/float(NUM_SURROUNDING) * 2 * PI);
      points[NUM_POINTS+i][1] = 2 * RADIUS * sin(float(i)/float(NUM_SURROUNDING) * 2 * PI);
      heights[NUM_POINTS+i] = WORLD_SIZE;
    }
    
    faces = delaunayFaces(points);
  }

  void draw() {
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
}
