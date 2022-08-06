//import 'package:henneth/henneth.dart';

import 'dart:html';

class MouseMode {
  String mode;
  MouseMode(this.mode);
}

void main() {
  var pos = [100, 100];
  var linePos = [];
  var polyList = [];
  var pointList = [];
  MouseMode mouse = MouseMode("click");
  var placePoint = (querySelector('#placePoint') as ButtonInputElement);
  var placePoly = (querySelector('#placePoly') as ButtonInputElement);
  var canvas = (querySelector('#myCanvas') as CanvasElement);
  var ctx = (canvas.getContext('2d') as CanvasRenderingContext2D);
  var clear = (querySelector('#clear') as ButtonInputElement);
  var run = (querySelector('#run') as ButtonInputElement);

  bool clickOnOffPoint = true;
  bool clickOnOffPoly = true;

  clear.onClick.listen((event) {
    ctx.beginPath();
    ctx.setFillColorRgb(255, 255, 255);
    ctx.rect(0, 0, 1000, 600);
    ctx.fill();
    ctx.stroke();
    pos = [100, 100];
    linePos = [];
    polyList = [];
    pointList = [];
  });

  placePoint.onClick.listen((_) {
    if (clickOnOffPoint) {
      mouse.mode = "point";
      clickOnOffPoint = false;
      placePoint.value = "stop";
      placePoly.style.display = "none";
      run.style.display = "none";
      clear.style.display = "none";
    } else {
      mouse.mode = "click";
      clickOnOffPoint = true;
      placePoint.value = "place point";
      placePoly.style.display = "block";
      run.style.display = "block";
      clear.style.display = "block";
    }
    print(mouse.mode);
  });

  placePoly.onClick.listen((_) {
    if (clickOnOffPoly) {
      mouse.mode = "poly";
      clickOnOffPoly = false;
      placePoly.value = "stop";
      placePoint.style.display = "none";
      run.style.display = "none";
      clear.style.display = "none";
    } else {
      mouse.mode = "click";
      clickOnOffPoly = true;
      placePoly.value = "place polygon";
      placePoint.style.display = "block";
      run.style.display = "block";
      clear.style.display = "block";
      ctx.moveTo(linePos[0][0], linePos[0][1]);
      ctx.lineTo(polyList[0][0], polyList[0][1]);
      ctx.stroke();
    }
    print(mouse.mode);
  });
  void findCoordinates(evt) {
    var x = evt.offset.x;
    var y = evt.offset.y;
    pos = [x, y];
  }

  canvas.onClick.listen((event) {
    if (mouse.mode == 'point') {
      findCoordinates(event);
      print(pos);
      pointList.add(pos);
      ctx.beginPath();
      ctx.setFillColorRgb(255, 0, 0);
      ctx.ellipse(pos[0], pos[1], 5, 5, 0, 0, 360, false);
      ctx.fill();
      ctx.stroke();
    }
    if (mouse.mode == 'poly') {
      findCoordinates(event);
      polyList.add(pos);
      if (linePos.length < 2) {
        linePos.add(pos);
      }
      if (linePos.length == 2) {
        ctx.moveTo(linePos[0][0], linePos[0][1]);
        ctx.lineTo(linePos[1][0], linePos[1][1]);
        ctx.stroke();
        linePos.remove(linePos[0]);
        print(linePos);
      }
    }
  });

  run.onClick.listen((event) {
    print(pointList);});
}
