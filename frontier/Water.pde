class Water {
  public static final color waterColor = #4C3D75;
  public static final color waterHeight = 300;
  Water() { }
  void draw() {
    fill(waterColor);
    beginShape();
    vertex(-WORLD_SIZE, -WORLD_SIZE, waterHeight);
    vertex(-WORLD_SIZE, WORLD_SIZE, waterHeight);
    vertex(WORLD_SIZE, WORLD_SIZE, waterHeight);
    vertex(WORLD_SIZE, -WORLD_SIZE, waterHeight);
    endShape(CLOSE);
  }
}