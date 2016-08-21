class Tree {
  private static final int MAX_DEPTH = 3;
  private PVector location;
  private PVector end;
  private float thickness;
  private ArrayList<Tree> children;
  private Leaf leaf;
  
  Tree(PVector coord, PVector normal, int depth) {
    thickness = 1;
    location = coord;
    if (depth == 0) {
      PVector n = normal.copy();
      n.setMag(random(1,20));
      n.add(PVector.random3D());
      end = coord.copy();
      end.add(n);
    } else {
      end = new PVector(
        coord.x + random(-1, 1)*(10-depth*1.5),
        coord.y + random(-1, 1)*(10-depth*1.5),
        coord.z - random(0, 2)*(10-depth*1.5)
      );
    }
    
    children = new ArrayList<Tree>();
    if (depth < MAX_DEPTH) {
      int numChildren = int(random(0,3));
      for (int i=0; i<numChildren; i++) {
        children.add(new Tree(end, end, depth+1));
      }
    }
    if (children.size() == 0) {
      leaf = new Leaf(end);
    }
  }
  
  void draw() {
    fill(#6B4848);
    for (int i=0; i<4; i++) {
      beginShape();
      vertex(
        location.x + thickness*cos(PI * float(i)/2),
        location.y + thickness*sin(PI * float(i)/2),
        location.z
      );
      vertex(
        location.x + thickness*cos(PI * float(i+1)/2),
        location.y + thickness*sin(PI * float(i+1)/2),
        location.z
      );
      vertex(
        end.x + thickness*cos(PI * float(i+1)/2),
        end.y + thickness*sin(PI * float(i+1)/2),
        end.z
      );
      vertex(
        end.x + thickness*cos(PI * float(i)/2),
        end.y + thickness*sin(PI * float(i)/2),
        end.z
      );
      endShape(CLOSE);
    }
    for (Tree child : children) {
      child.draw();
    }
    if (leaf != null) leaf.draw();
  }
}

class Leaf {
  private PVector location;
  private float size;
  
  Leaf(PVector coord) {
    location = coord;
    size = random(2,10);
  }
  
  void draw() {
    pushMatrix();
    translate(location.x, location.y, location.z);
    fill(#FFB5B5);
    sphere(size);
    popMatrix();
  }
}