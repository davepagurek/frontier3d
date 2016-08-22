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
  House house;

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
    } else {
      type = SurfaceType.GRASS;
      float rand = random(0, 20);
      if (rand>17.5 && rand<=19.5 && centroid.z < Water.waterHeight) {
        tree = new Tree(centroid, normal, 0);
      } else if (rand > 19.5  && centroid.z < Water.waterHeight) {
        house = new House(centroid, vertices, 0, HouseSide.TOP);
      }
    }
    //col = lerpColor(#A14D4D, #DB4242, (abs(angle) - 0.6)*(1.0/0.6)/PI);
    col = lerpColor(#913D3D, #DB4242, (abs(angle) - 0.7)*(1.0/0.7)/PI);
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
    if (house != null) {
      house.draw();
    }
  }
}