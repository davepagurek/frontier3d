# frontier3d
Procedurally generated landscapes in 3D.

https://www.youtube.com/watch?v=VdpMrgS2P3E

<img src="https://github.com/davepagurek/frontier3d/blob/master/screenshots/Screen%20Shot%202016-08-24%20at%209.32.18%20AM.png?raw=true" />

## Setup
This sketch relies on having quickhull3d installed: https://github.com/gotascii/processing/tree/master/libraries/quickhull3d

## About

This is inspired by an earlier project of mine to generate 2D landscapes procedurally. I needed album art for a track I was working on, and wanted to bring landscape generation into the third dimension.

Perlin noise is used to create the landscape, which is then tesselated using a Delaunay algorithm. Trees then grow on surfaces that aren't inclined too much. Houses spawn (on stilts if need be), with extensions climbing upwards.

<img src='http://www.davepagurek.com/content/images/2016/10/view1.png' />
Detail of vertical house sprawl

<img src='http://www.davepagurek.com/content/images/2016/10/view2.png' />
Detail of trees on a mountain

<img src='http://www.davepagurek.com/content/images/2016/10/view3.png' />
Detail of houses on stilts

<img src='http://www.davepagurek.com/content/images/2016/10/view4.png' />
Detail of prime seaside property
