from PIL import Image, ImageDraw
from math import *
size = 100
im = Image.new("RGB",(size,size),"white")

class Mur :
    def __init__(self,pointA,pointB) :
        self.pointA = pointA
        self.pointB = pointB

    def draw(self,im) :
        draw = ImageDraw.Draw(im)
        draw.line((self.pointA,self.pointB),fill = "black")

class Point :
    def __init__(self,x,y) :
        self.x = x
        self.y = y

    def touche(self,mur) :
        x1 = mur.pointA[0]
        y1 = mur.pointA[1]
        x2 = mur.pointB[0]
        y2 = mur.pointB[1]
        x3 = self.x
        y3 = self.y
        x4 = x3 + size
        y4 = y3

        d = ((x1-x2)*(y3-y4))-((y1-y2)*(x3-x4))
        if d == 0 :
            return False
        
        t = (((x1-x3)*(y3-y4))-((y1-y3)*(x3-x4)))/d
        u = (((x1-x3)*(y1-y2))-((y1-y3)*(x1-x2)))/d

        if 0 <= t <= 1 and 0 < u :
            return True
        return False

    def isInside(self,polygon) :
        c = False
        for wall in polygon.walls :
            if self.touche(wall) :
                c = not c
        return c


    def draw(self,im,poly) :
        draw = ImageDraw.Draw(im)
        if self.isInside(poly) :
            draw.point((self.x,self.y),fill = "green")
        else :
            draw.point((self.x,self.y),fill = "red")


class Polygon :
    def __init__(self,pointList) :
        self.pointList = pointList
        self.walls = []
        self.createWall()

    def createWall(self) :
        for i in range(len(self.pointList)) :
            self.walls.append(Mur(self.pointList[i],self.pointList[(i+1)%len(self.pointList)]))

    def draw(self,im) :
        for wall in self.walls :
            wall.draw(im)


polygone = Polygon([(0,0),(0,10),(10,10),(10,0)])
#polygone.draw(im)
pointList = [Point(5,5),Point(10,11),Point(12,5),Point(20,20),Point(3,45)]

polygone2 = Polygon([(0,0),(10,0),(10,10),(15,10),(15,0),(25,0),(25,25),(0,25)])

polygone3 = Polygon([(5,17),(21,12),(43,60),(3,1),(24,74),(100,20),(31,95)])

polygone2.draw(im)
for point in pointList :
    point.draw(im,polygone2)

im.save("test.png", 'PNG')