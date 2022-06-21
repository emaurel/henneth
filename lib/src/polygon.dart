import 'dart:math';

int size = 100;

class Point {
  late int x;
  late int y;

  Point(int x, int y) {
    this.x = x;
    this.y = y;
  }

  num distance(Point a) {
    num d = pow((pow((a.x - this.x), 2) + pow((a.y - this.y), 2)), 0.5);
    return d;
  }

  bool isBetween(Point a, Point b) {
    return this.distance(a) + this.distance(b) == a.distance(b);
  }

  bool touche(wall) {
    int x1 = wall.a.x;
    int y1 = wall.a.y;
    int x2 = wall.b.x;
    int y2 = wall.b.y;
    int x3 = this.x;
    int y3 = this.y;
    int x4 = x3 + size;
    int y4 = y3;

    int d = ((x1 - x2) * (y3 - y4)) - ((y1 - y2) * (x3 - x4));

    if (d == 0) {
      return false;
    }
    double t = (((x1 - x3) * (y3 - y4) - ((y1 - y3) * (x3 - x4)))) / d;
    double u = (((x1 - x3) * (y1 - y2)) - ((y1 - y3) * (x1 - x2))) / d;

    if (0 <= t && t <= 1 && 0 < u) {
      return true;
    }
    return false;
  }

  bool isInside(Polygon polygon) {
    bool c = false;
    for (Wall wall in polygon.walls) {
      if (this.touche(wall)) {
        c = !c;
      }
      else if (this.isBetween(wall.a, wall.b)) {
        return true;
      }
    }

    return c;
  }
}

class Wall {
  late Point a;
  late Point b;

  Wall(Point a, Point b) {
    this.a = a;
    this.b = b;
  }
}

class Polygon {
  late var vertexList;
  var walls = [];

  Polygon(var vertexList) {
    this.vertexList = vertexList;
    this.createWalls();
  }

  void createWalls() {
    for (var i = 0; i < this.vertexList.length; i++) {
      Wall w = new Wall(this.vertexList[i],
          this.vertexList[(i + 1) % this.vertexList.length]);
      this.walls.add(w);
    }
  }
}
