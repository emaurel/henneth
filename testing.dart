import 'polygon.dart';

void main() {
var polygonPointList = [
    Point(0, 0),
    Point(0, 10),
    Point(10, 0),
    Point(10, 10)
  ];

  
  var pointList = [Point(5, 5), Point(10, 11)];
  Polygon poly = new Polygon(polygonPointList);
  for (Point point in pointList) {
    print(point.isInside(poly));
    
  }
}