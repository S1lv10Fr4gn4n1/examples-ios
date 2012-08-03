//
//  main.m
//  PolygonEditorObjC
//
//  Created by Silvio Fragnani on 11/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLUT/GLUT.h>
#import "Controller.h"

Controller * controller;

void display(void) {
	glMatrixMode (GL_PROJECTION);
	glLoadIdentity ();
	gluOrtho2D([controller getOrtho2DLeft], [controller getOrtho2DRight], [controller getOrtho2DBottom], [controller getOrtho2DTop]);
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity ();
	
	glClearColor(0.8, 0.8, 0.8, 0.8);
	glClear (GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	
	[controller drawAllObj];
	
	glutSwapBuffers();
}

void reshape(int _w, int _h) {
	[controller reshape: _w: _h];
}

void keyboard(unsigned char _key, int x, int y) {
	[controller keyboard: _key: x: y];
}

void special(int _key, int x, int y) {
	[controller special: _key: x: y];
}

void motion(int _x, int _y) {
	[controller motion: _x: _y];
}

void mouse(int _button, int _state, int _x, int _y) {
	[controller mouse: _button: _state: _x: _y];
}

void passive(int _x, int _y) {
	[controller passive: _x: _y];
}


//int main (int argc, const char * argv[])
int main(int _argc, char **_argv)
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	controller = [[Controller alloc] init];
	
	glutInit(&_argc, _argv);
	
  	glutInitDisplayMode(GLUT_DEPTH | GLUT_DOUBLE | GLUT_RGBA);
  	glutInitWindowPosition(400,100);
	glutInitWindowSize (500, 500);
  	glutCreateWindow("N3");
  	glutDisplayFunc(display);
  	glutReshapeFunc(reshape);
  	glutMotionFunc(motion);
	glutMouseFunc(mouse);
	glutKeyboardFunc(keyboard);
	glutSpecialFunc(special);
	glutPassiveMotionFunc(passive);
	
    glutMainLoop();
	
    [controller release];
	
    [pool drain];
	
    return 0;
}



