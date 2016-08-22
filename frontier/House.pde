enum HouseSide {
  NORTH,
  EAST,
  SOUTH,
  WEST,
  TOP
}

import java.util.Collections;
import java.util.Arrays;

class House {
  private PVector loc;
  private float w, h, d, elevation, angle;
  private color walls, roof;
  private static final color window = #1C3C70;
  private static final int MAX_DEPTH = 3;
  private ArrayList<House> children;
  
  House(PVector coord, ArrayList<PVector> verts, int depth, HouseSide side) {
    w = random(0.5, 1)*(15-depth*3);
    h = random(0.5, 1)*(15-depth*3);
    d = random(0.5, 1)*(20-depth*3);
    switch (side) {
    case TOP:
      loc = coord.copy();
      angle = random(0, 2*PI);
      break;
    case NORTH:
      loc = new PVector(coord.x, coord.y-h/2, coord.z);
      angle = 0;
      break;
    case SOUTH:
      loc = new PVector(coord.x, coord.y+h/2, coord.z);
      angle = 0;
      break;
    case EAST:
      loc = new PVector(coord.x+w/2, coord.y, coord.z);
      angle = 0;
      break;
    case WEST:
      loc = new PVector(coord.x-w/2, coord.y, coord.z);
      angle = 0;
      break;
    }
    
    if (depth == 0) {
      float dist = abs(maxIn(verts).z - coord.z);
      if (random(0,10)>5 && dist < 10) {
        elevation = dist;
      } else {
        d += dist*0.5;
        loc.set(loc.x, loc.y, loc.z+dist);
      }
    } else {
      elevation = 0;
    }
    
    walls = lerpColor(#BAAB91, #E0CDAB, random(0,1));
    roof = #8A614D;
    
    children = new ArrayList<House>();
    if (depth < MAX_DEPTH) {
      int numChildren = int(random(0, 2));
      ArrayList<HouseSide> sides = new ArrayList<HouseSide>(Arrays.asList(
        HouseSide.NORTH,
        HouseSide.EAST,
        HouseSide.SOUTH,
        HouseSide.WEST,
        HouseSide.TOP
      ));
      for (int i=0; i<numChildren; i++) {
        Collections.shuffle(sides);
        HouseSide s = sides.get(sides.size()-1);
        sides.remove(sides.size()-1);
        PVector childLoc = new PVector();
        switch (s) {
        case TOP:
          childLoc = new PVector(
            random(-w/2, w/2),
            random(-h/2, h/2),
            -elevation-d-2
          );
          break;
        case NORTH:
          childLoc = new PVector(
            random(-w/2,w/2),
            -h/2,
            -random(d/2, d)
          );
          break;
        case SOUTH:
          childLoc = new PVector(
            random(-w/2,w/2),
            h/2,
            -random(d/2, d)
          );
          break;
        case EAST:
          childLoc = new PVector(
            w/2,
            random(-h/2,h/2),
            -random(d/2, d)
          );
          break;
        case WEST:
          childLoc = new PVector(
            -w/2,
            random(-h/2,h/2),
            -random(d/2, d)
          );
          break;
        }
        children.add(new House(childLoc, null, depth+1, s));
      }
    }
  }
  
  void draw() {
    pushMatrix();
    translate(loc.x, loc.y, loc.z);
    rotateZ(angle);
    
    fill(walls);
    pushMatrix();
    translate(0, 0, -elevation);
    rectPrism(w, h, d);
    
    fill(roof);
    translate(0, 0, -d);
    rectPrism(w*1.15, h*1.15, 2);
    
    popMatrix();
    
    if (elevation != 0) {
      fill(#4A3B34);
      for (int i=0; i<4; i++) {
        pushMatrix();
        rotateZ(2*PI*(float(i) + 0.5)/4.0);
        translate(min(w, h)*0.4, 0, elevation);
        rectPrism(1, 1, elevation*2);
        popMatrix();
      }
    }
    
    for (House child : children) {
      child.draw();
    }
    
    popMatrix();
  }
}

PVector maxIn(ArrayList<PVector> vertices) {
  PVector max = vertices.get(0);
  for (int i=1; i<vertices.size(); i++) {
    if (vertices.get(i).z < max.z) {
      max = vertices.get(i);
    }
  }
  return max;
}

void rectPrism(float w, float h, float d) {
  // Base
  beginShape();
  vertex(-w/2, -h/2, 0);
  vertex(w/2, -h/2, 0);
  vertex(w/2, h/2, 0);
  vertex(-w/2, h/2, 0);
  endShape(CLOSE);
  
  // Top
  beginShape();
  vertex(-w/2, -h/2, -d);
  vertex(w/2, -h/2, -d);
  vertex(w/2, h/2, -d);
  vertex(-w/2, h/2, -d);
  endShape(CLOSE);
  
  // Sides
  beginShape();
  vertex(-w/2, -h/2, 0);
  vertex(w/2, -h/2, 0);
  vertex(w/2, -h/2, -d);
  vertex(-w/2, -h/2, -d);
  endShape(CLOSE);
  
  beginShape();
  vertex(-w/2, h/2, 0);
  vertex(w/2, h/2, 0);
  vertex(w/2, h/2, -d);
  vertex(-w/2, h/2, -d);
  endShape(CLOSE);
  
  beginShape();
  vertex(-w/2, -h/2, 0);
  vertex(-w/2, h/2, 0);
  vertex(-w/2, h/2, -d);
  vertex(-w/2, -h/2, -d);
  endShape(CLOSE);
  
  beginShape();
  vertex(w/2, -h/2, 0);
  vertex(w/2, h/2, 0);
  vertex(w/2, h/2, -d);
  vertex(w/2, -h/2, -d);
  endShape(CLOSE);
}