import 'package:henneth/henneth.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    final awesome = Awesome();

    setUp(() {
      // Additional setup goes here.
    });
    test('square', () {
      var polygonPointList = [
        Point(0, 0),
        Point(0, 10),
        Point(10, 0),
        Point(10, 10)
      ];
      var point1 = Point(10, 11);
      var point2 = Point(5, 5);
      var point3 = Point(0, 0);
      var point4 = Point(0, 5);
      Polygon poly = new Polygon(polygonPointList);
      expect(point1.isInside(poly), isFalse);
      expect(point2.isInside(poly), isTrue);
      expect(point3.isInside(poly), isTrue);
      expect(point4.isInside(poly), isTrue);
    });

    test('point_alligned', () {
      var polygonPointList = [
        Point(200, 0),
        Point(200, 10),
        Point(1, 5),
      ];
      var point = Point(0, 5);
      Polygon poly = new Polygon(polygonPointList);
      expect(point.isInside(poly), isFalse);

    });



    test('U shape', () {
      var polygonPointList = [
        Point(0, 0),
        Point(10, 0),
        Point(10, 20),
        Point(20, 20),
        Point(20, 0),
        Point(30, 0),
        Point(30, 30),
        Point(0, 30)
      ];
      var point1 = Point(15, 0);
      var point2 = Point(15, 25);
      var point3 = Point(0, 0);
      var point4 = Point(25, 10);
      Polygon poly = new Polygon(polygonPointList);
      expect(point1.isInside(poly), isFalse);
      expect(point2.isInside(poly), isTrue);
      expect(point3.isInside(poly), isTrue);
      expect(point4.isInside(poly), isTrue);
    });

    test('no polygon', () {
      var polygonPointList = [];
      var point1 = Point(10, 11);
      var point2 = Point(5, 5);
      var point3 = Point(0, 0);
      var point4 = Point(0, 5);
      Polygon poly = new Polygon(polygonPointList);
      expect(point1.isInside(poly), isFalse);
      expect(point2.isInside(poly), isFalse);
      expect(point3.isInside(poly), isFalse);
      expect(point4.isInside(poly), isFalse);
    });

    test('one vertex polygon', () {
      var polygonPointList = [Point(5, 5)];
      var point1 = Point(10, 11);
      var point2 = Point(5, 5);
      var point3 = Point(0, 0);
      var point4 = Point(0, 5);
      Polygon poly = new Polygon(polygonPointList);
      expect(point1.isInside(poly), isFalse);
      expect(point2.isInside(poly), isTrue);
      expect(point3.isInside(poly), isFalse);
      expect(point4.isInside(poly), isFalse);
    });

    test('point list in square', () {
      var polygonPointList = [
        Point(0, 0),
        Point(0, 10),
        Point(10, 0),
        Point(10, 10)
      ];
      var lstx = [5, 0, 20, 0];
      var lsty = [5, 0, 0, 5];
      Polygon poly = new Polygon(polygonPointList);
      var lf = poly.containsPoints(lstx, lsty);
      print(lf);
      expect(lf[0], 0);
    });

    test('point list in U shape', () {
      var polygonPointList = [
        Point(0, 0),
        Point(10, 0),
        Point(10, 20),
        Point(20, 20),
        Point(20, 0),
        Point(30, 0),
        Point(30, 30),
        Point(0, 30)
      ];
      var lstx = [15, 15, 0, 25, 10];
      var lsty = [0, 25, 0, 10, 35];
      Polygon poly = new Polygon(polygonPointList);
      var lf = poly.containsPoints(lstx, lsty);
      print(lf);
    });

    test('convert', () {
      var polygonPointList = [
        Point(0, 0),
        Point(10, 0),
        Point(10, 20),
        Point(20, 20),
        Point(20, 0),
        Point(30, 0),
        Point(30, 30),
        Point(0, 30)
      ];
      Polygon poly = new Polygon(polygonPointList);
      var lst = poly.toList();
      print(lst);
      Polygon poly2 = Polygon.fromList(lst);
      var lst2 = poly2.toList();
      expect(lst2, lst);
    });
  });
}
