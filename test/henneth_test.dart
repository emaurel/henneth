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

    test('U shape', () {
      var polygonPointList = [
        Point(0, 0),
        Point(10, 0),
        Point(10, 20),
        Point(20, 20),
        Point(20,0),
        Point(30,0),
        Point(30,30),
        Point(0,30)
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
  });
}
