import 'dart:math';
import 'dart:convert';

num size = 100;

class Point {
  final num x;
  final num y;

  Point(this.x, this.y);

  num distance(Point a) {
    num d = pow((pow((a.x - this.x), 2) + pow((a.y - this.y), 2)), 0.5);
    return d;
  }

  bool isBetween(Point a, Point b) {
    return this.distance(a) + this.distance(b) == a.distance(b);
  }

  bool touche(wall) {
    num x1 = wall.a.x;
    num y1 = wall.a.y;
    num x2 = wall.b.x;
    num y2 = wall.b.y;
    num x3 = this.x;
    num y3 = this.y;
    num x4 = x3 + size;
    num y4 = y3;

    num d = ((x1 - x2) * (y3 - y4)) - ((y1 - y2) * (x3 - x4));

    if (d == 0) {
      return false;
    }
    double t = (((x1 - x3) * (y3 - y4) - ((y1 - y3) * (x3 - x4)))) / d;
    double u = (((x1 - x3) * (y1 - y2)) - ((y1 - y3) * (x1 - x2))) / d;

    if (0 < t && t < 1 && 0 < u) {
      Point intersection = Point(x1 + t * (x2 - x1), y1 + t * (y2 - y1));
      if (intersection.x == x1 || intersection.x == x2) {
        return false;
      } else {
        return true;
      }
    }
    return false;
  }

  bool isInside(Polygon polygon) {
    bool c = false;
    for (_Wall wall in polygon.walls) {
      if (this.touche(wall)) {
        c = !c;
      } else if (this.isBetween(wall.a, wall.b)) {
        return true;
      }
    }

    return c;
  }
}

class _Wall {
  final Point a;
  final Point b;

  _Wall(this.a, this.b);
}

class Polygon {
  late var vertexList;
  var walls = [];

  Polygon(var vertexListt) {
    vertexList = vertexListt;
    createWalls();
  }

  Polygon.fromList(List<List<double>> lst) {
    this.vertexList = [];
    for (var i = 0; i < lst.length; i++) {
      this.vertexList.add(Point(lst[i][0], lst[i][1]));
    }
    this.createWalls();
  }

  List<List<double>> toList() {
    var l = <List<double>>[];
    for (var i = 0; i < vertexList.length; i++) {
      print(vertexList[i]);
      l.add([vertexList[i].x.toDouble(), vertexList[i].y.toDouble()]);
    }
    return l;
  }

  toJsonList() {
    return json.encode(this.toList());
  }

  num distance(a, b) {
    num d = pow((pow((a[0] - b[0]), 2) + pow((a[1] - b[1]), 2)), 0.5);
    return d;
  }

  bool isBetween(a, b, c) {
    return distance(a, c) + distance(c, b) == distance(a, b);
  }

  bool touche(pt, wall) {
    num x1 = wall.a.x;
    num y1 = wall.a.y;
    num x2 = wall.b.x;
    num y2 = wall.b.y;
    num x3 = pt[0];
    num y3 = pt[1];
    num x4 = x3 + size;
    num y4 = y3;

    num d = ((x1 - x2) * (y3 - y4)) - ((y1 - y2) * (x3 - x4));

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

  bool contains(pt) {
    bool c = false;
    for (_Wall wall in this.walls) {
      if (touche(pt, wall)) {
        c = !c;
      } else if (isBetween([wall.a.x, wall.a.y], [wall.b.x, wall.b.y], pt)) {
        return true;
      }
    }

    return c;
  }

  void createWalls() {
    for (var i = 0; i < this.vertexList.length; i++) {
      _Wall w = new _Wall(this.vertexList[i],
          this.vertexList[(i + 1) % this.vertexList.length]);
      this.walls.add(w);
    }
  }

  containsPoints(lstPointsx, lstPointsy) {
    var l = [];
    for (var i = 0; i < lstPointsx.length; i++) {
      if (contains([lstPointsx[i], lstPointsy[i]])) {
        l.add(i);
      }
    }
    return l;
  }
}
