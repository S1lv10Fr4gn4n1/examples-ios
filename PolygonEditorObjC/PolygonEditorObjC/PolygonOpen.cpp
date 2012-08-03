#include <GLUT/glut.h>
#include <iostream>
#include "PolygonOpen.h"

using namespace std;

PolygonOpen::PolygonOpen() {
}

PolygonOpen::~PolygonOpen() {
}

void PolygonOpen::init() {
	ObjectGraph::init();
}

void PolygonOpen::draw() {
	ObjectGraph::draw();

	glBegin(GL_LINE_STRIP);
		size_t totalPoints = points.size();
		for (int i = 0; i < totalPoints; i++) {
			Point* point = points.at(i);
			glVertex2f(point->getX(), point->getY());
		}
	glEnd();
}
