//
//  TestMyGUI.h
//  GUI iOS
//
//  Created by Silvio Fragnani da Silva on 01/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>


@interface TestMyGUI : NSObject

- (void)drawAllObjects:(unsigned int) _program;

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event point:(CGPoint)point;
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event point:(CGPoint)point;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event point:(CGPoint)point;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event point:(CGPoint)point;

@end
