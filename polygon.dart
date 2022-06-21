int size = 100;

class Point {
  late int x;
  late int y;

  Point(int x, int y) {
    this.x = x;
    this.y = y;
  }

  bool touche(wall) {
    int x1 = wall.A.x;
    int y1 = wall.A.y;
    int x2 = wall.B.x;
    int y2 = wall.B.y;
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
    }
    return c;
  }
}

class Wall {
  late Point A;
  late Point B;

  Wall(Point A, Point B) {
    this.A = A;
    this.B = B;
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
      Wall w = new Wall(
          this.vertexList[i], this.vertexList[(i + 1) % this.vertexList.length]);
      this.walls.add(w);
    }
  }
}
