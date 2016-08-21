public enum SurfaceType {
  BLUFF,
  GRASS
};

class Surface {
  private ArrayList<PVector> vertices;
  public PVector normal;
  public PVector centroid; 
  public SurfaceType type;
  color col;
  Tree tree;

  Surface(int[] corners, float[][] points, float[] heights) {
    vertices = new ArrayList<PVector>();
    for (int corner : corners) {
      vertices.add(new PVector(
        points[corner][0],
        points[corner][1],
        heights[corner]
      ));
    }
    centroid = new PVector(
      (vertices.get(0).x + vertices.get(1).x + vertices.get(2).x)/3,
      (vertices.get(0).y + vertices.get(1).y + vertices.get(2).y)/3,
      (vertices.get(0).z + vertices.get(1).z + vertices.get(2).z)/3
    );
    
    PVector e1 = vertices.get(0).copy();
    e1.sub(vertices.get(2));

    PVector e2 = vertices.get(1).copy();
    e2.sub(vertices.get(2));

    normal = e1.cross(e2);

    float angle = PVector.angleBetween(normal, new PVector(0, 0, 1));
    if (abs(angle) < PI*0.65) {
      type = SurfaceType.BLUFF;
      //col = lerpColor(#782A44, #6B1B36, random(0,1));
      col = #8A717A;
    } else {
      type = SurfaceType.GRASS;
      //col = lerpColor(#B03030, #CF5959, random(0,1));
      col = #DB5656;
      if (random(0,10)>8) {
        tree = new Tree(centroid, 0);
      }
    }
    col = lerpColor(#A14D4D, #DB4242, (abs(angle) - 0.6)*(1.0/0.6)/PI);
  }

  void draw() {
    fill(col);
    beginShape();
    for (PVector v : vertices) {
      vertex(v.x, v.y, v.z);
    }
    endShape(CLOSE);
    if (tree != null) {
      tree.draw();
    }
  }
}