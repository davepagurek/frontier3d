import quickhull3d.*;

int[][] delaunayFaces(float[][] points) {
  double qPoints[] = new double[ points.length*3 + 9 ];
  for(int i=0; i<points.length; i++)
  {
    qPoints[i*3] = points[i][0];
    qPoints[i*3+1] = points[i][1];
    qPoints[i*3+2] = -(points[i][0]*points[i][0] + points[i][1]*points[i][1]); // standard half-squared eucledian distance
  }
  
  // 1
  qPoints[ qPoints.length-9 ] = -2000;
  qPoints[ qPoints.length-8 ] = 0;
  qPoints[ qPoints.length-7 ] = -4000000;
  // 2
  qPoints[ qPoints.length-6 ] = 2000;
  qPoints[ qPoints.length-5 ] = 2000;
  qPoints[ qPoints.length-4 ] = -8000000;
  // 3
  qPoints[ qPoints.length-3 ] = 2000;
  qPoints[ qPoints.length-2 ] = -2000;
  qPoints[ qPoints.length-1 ] = -8000000;
  
  QuickHull3D quickHull = new QuickHull3D(qPoints);
  quickHull.triangulate();
  return quickHull.getFaces(QuickHull3D.POINT_RELATIVE + QuickHull3D.CLOCKWISE);
}