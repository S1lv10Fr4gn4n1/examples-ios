//
//  ViewController.m
//  TemplateGame
//
//  Created by Silvio Fragnani da Silva on 27/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

#define DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) / 180.0 * M_PI)

// Uniform index.
enum
{
    UNIFORM_MODELVIEWPROJECTION_MATRIX,
    UNIFORM_NORMAL_MATRIX,
    NUM_UNIFORMS
};
GLint uniforms[NUM_UNIFORMS];

// Attribute index.
enum
{
    ATTRIB_VERTEX,
    ATTRIB_NORMAL,
    ATTRIB_COLOR
};

enum {
	kSound_Thrust = 0,
	kSound_Start,
	kSound_Success,
	kSound_Failure,
	kNumSounds
};

@interface ViewController () {
    GLuint _program;
    
    GLKMatrix4 _modelViewProjectionMatrix;
    
    GLfloat eyeX;
    GLfloat eyeY;
    GLfloat eyeZ;

    GLfloat centerX;
    GLfloat centerY;
    GLfloat centerZ;
    
    CGPoint lastPoint;
    float lastScale;
}
@property (strong, nonatomic) EAGLContext *context;

- (void)setupGL;
- (void)tearDownGL;

- (void)startSound;

- (void)createSphere;
- (void)createLines;
- (void)createBox;
- (void)createText;
- (void)createTriangleWithTriangularBase;
- (void)createTriangleWithSquareBase;

- (BOOL)loadShaders;
- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file;
- (BOOL)linkProgram:(GLuint)prog;
- (BOOL)validateProgram:(GLuint)prog;
@end

@implementation ViewController

@synthesize context = _context;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];

    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    [self setupGL];
    
//    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchDetected:)];
//    [view addGestureRecognizer:pinchRecognizer];
    
//    UITapGestureRecognizer *doubleTapTwoFinger = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapTwoFingerDetected:)];
//    doubleTapTwoFinger.numberOfTapsRequired = 2;
//    doubleTapTwoFinger.numberOfTouchesRequired = 2;
//    [view addGestureRecognizer:doubleTapTwoFinger];

    eyeX = 3.0f;
    eyeY = 1.0f;
    eyeZ = 2.5f;
    
    centerX = 0.0f;
    centerY = 0.0f;
    centerZ = 0.0f;

    [self startSound];
    
    [NSTimer scheduledTimerWithTimeInterval:0.05f
                                     target:self
                                   selector:@selector(startSimulation:)
                                   userInfo:NULL
                                    repeats:YES];

}

- (void)startSimulation:(NSTimer*)theTimer
{
    static int ang = 0;
    const static float radius = 5.0;
    
    eyeX = (radius * cos(M_PI * ang / 180.0f));
    centerX = -eyeX;
    eyeZ = (radius * sin(M_PI * ang / 180.0f));
    centerZ = -eyeZ;
    
    ang+=1;
}

- (IBAction)doubleTapTwoFingerDetected:(UIGestureRecognizer *)sender
{
    eyeX = 0.0f;
    eyeY = 1.0f;
}

- (IBAction)pinchDetected:(UIGestureRecognizer *)sender
{
    float scale = [(UIPinchGestureRecognizer *)sender scale];

    if (scale < lastScale) {
        eyeZ += 0.05f;
    } else {
        eyeZ -= 0.05f;
    }
    
    lastScale = scale;
}

- (void)startSound
{
//    NSBundle * bundle = [NSBundle mainBundle];
//    
//    #define kListenerDistance			1.0  // Used for creating a realistic sound field
//    UInt32					_sounds[kNumSounds];
//    
//    // Note that each of the Sound Engine functions defined in SoundEngine.h return an OSStatus value.
//	// Although the code in this application does not check for errors, you'll want to add error checking code
//	// in your own application, particularly during development.
//	//Setup sound engine. Run  it at 44Khz to match the sound files
//	SoundEngine_Initialize(44100);
//	// Assume the listener is in the center at the start. The sound will pan as the position of the rocket changes.
//	SoundEngine_SetListenerPosition(0.0, 0.0, kListenerDistance);
//	// Load each of the four sounds used in the game.
//	SoundEngine_LoadEffect([[bundle pathForResource:@"Start" ofType:@"caf"] UTF8String], &_sounds[kSound_Start]);
//	SoundEngine_LoadEffect([[bundle pathForResource:@"Success" ofType:@"caf"] UTF8String], &_sounds[kSound_Success]);
//	SoundEngine_LoadEffect([[bundle pathForResource:@"Failure" ofType:@"caf"] UTF8String], &_sounds[kSound_Failure]);
//	SoundEngine_LoadLoopingEffect([[bundle pathForResource:@"Thrust" ofType:@"caf"] UTF8String], NULL, NULL, &_sounds[kSound_Thrust]);
//
//	//Play start sound
//	SoundEngine_StartEffect( _sounds[kSound_Start]);
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint currentPoint = [[touches anyObject] locationInView: self.view];

    if (currentPoint.x > lastPoint.x) {
    	eyeX += 0.005;
    } else {
        eyeX -= 0.005;
    }
    
    if (currentPoint.y > lastPoint.y) {
    	eyeY += 0.05f;
    } else {
        eyeY -= 0.05f;
    }
    
    lastPoint = currentPoint;
}

- (void)viewDidUnload
{    
    [super viewDidUnload];
    
    [self tearDownGL];
    
    if ([EAGLContext currentContext] == self.context) {
        [EAGLContext setCurrentContext:nil];
    }
	self.context = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc. that aren't in use.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)setupGL
{
    [EAGLContext setCurrentContext:self.context];
    
    [self loadShaders];
    
    glEnable(GL_DEPTH_TEST); //TODO
}

- (void)tearDownGL
{
    [EAGLContext setCurrentContext:self.context];
    
    if (_program) {
        glDeleteProgram(_program);
        _program = 0;
    }
}

- (void)createSphere
{
    const float degreeIncrement = 10; // 10 degrees between
    const int sphereVertexCount = (180 / degreeIncrement) * (360 / degreeIncrement) * 4;

    GLfloat sphereVertex3f   [sphereVertexCount][3];
//    GLfloat sphereTexCoord2f [sphereVertexCount][2];


    // Based on http://www.swiftless.com/tutorials/opengl/sphere.html
    const float M_PI_Divided_By_180 = M_PI/180;
    int vertNum = 0;
    float radius = 0.3f;
    
    // Iterate through height of sphere of Z
    for (float z = 0; z <= 180 - degreeIncrement; z += degreeIncrement) {
        // Each point of the circle X, Y of "C"
        for (float c = 0; c <= 360 - degreeIncrement; c += degreeIncrement) {
            sphereVertex3f[vertNum][0] = radius * sinf( (c) * M_PI_Divided_By_180 ) * sinf( (z) * M_PI_Divided_By_180 );
            sphereVertex3f[vertNum][1] = radius * cosf( (c) * M_PI_Divided_By_180 ) * sinf( (z) * M_PI_Divided_By_180 );
            sphereVertex3f[vertNum][2] = radius * cosf( (z) * M_PI_Divided_By_180 );
//            sphereTexCoord2f [vertNum][0] = (c)     / 360;
//            sphereTexCoord2f [vertNum][1] = (2 * z) / 360;
//            printf("x: %f, y: %f, z: %f\n", sphereVertex3f[vertNum][0], sphereVertex3f[vertNum][2], sphereVertex3f[vertNum][2]);
            vertNum ++; // ^ Top Left

            sphereVertex3f[vertNum][0] = radius * sinf( (c) * M_PI_Divided_By_180 ) * sinf( (z + degreeIncrement) * M_PI_Divided_By_180 );
            sphereVertex3f[vertNum][1] = radius * cosf( (c) * M_PI_Divided_By_180 ) * sinf( (z + degreeIncrement) * M_PI_Divided_By_180 );
            sphereVertex3f[vertNum][2] = radius * cosf( (z + degreeIncrement) * M_PI_Divided_By_180 );
//            sphereTexCoord2f [vertNum][0] = (c)               / 360;
//            sphereTexCoord2f [vertNum][1] = (2 * (z + degreeIncrement)) / 360;
//            printf("x: %f, y: %f, z: %f\n", sphereVertex3f[vertNum][0], sphereVertex3f[vertNum][2], sphereVertex3f[vertNum][2]);
            vertNum ++; // ^ Top Right

            sphereVertex3f[vertNum][0] = radius * sinf( (c + degreeIncrement) * M_PI_Divided_By_180 ) * sinf( (z) * M_PI_Divided_By_180 );
            sphereVertex3f[vertNum][1] = radius * cosf( (c + degreeIncrement) * M_PI_Divided_By_180 ) * sinf( (z) * M_PI_Divided_By_180 );
            sphereVertex3f[vertNum][2] = radius * cosf( (z) * M_PI_Divided_By_180 );
//            printf("x: %f, y: %f, z: %f\n", sphereVertex3f[vertNum][0], sphereVertex3f[vertNum][2], sphereVertex3f[vertNum][2]);
//            sphereTexCoord2f [vertNum][0] = (c + degreeIncrement) / 360;
//            sphereTexCoord2f [vertNum][1] = (2 * z)     / 360;
            vertNum ++; // ^ Bottom Left

            sphereVertex3f[vertNum][0] = radius * sinf( (c + degreeIncrement) * M_PI_Divided_By_180 ) * sinf( (z + degreeIncrement) * M_PI_Divided_By_180 );
            sphereVertex3f[vertNum][1] = radius * cosf( (c + degreeIncrement) * M_PI_Divided_By_180 ) * sinf( (z + degreeIncrement) * M_PI_Divided_By_180 );
            sphereVertex3f[vertNum][2] = radius * cosf( (z + degreeIncrement) * M_PI_Divided_By_180 );
//            printf("x: %f, y: %f, z: %f\n", sphereVertex3f[vertNum][0], sphereVertex3f[vertNum][2], sphereVertex3f[vertNum][2]);
//            sphereTexCoord2f [vertNum][0] = (c + degreeIncrement)       / 360;
//            sphereTexCoord2f [vertNum][1] = (2 * (z + degreeIncrement)) / 360;
            vertNum ++; // ^ Bottom Right
        }
    }

    int total = vertNum * 4;
    unsigned char * color = new unsigned char[total];

    for (int i = 0; i < total; i += 4) {
		color[i]   = 0;
		color[i+1] = 0;
		color[i+2] = 255;
        color[i+3] = 0;
	}
    
    glVertexAttribPointer(ATTRIB_COLOR, 4, GL_UNSIGNED_BYTE, 1, 0, color);
    glEnableVertexAttribArray(ATTRIB_COLOR);
    
    glVertexAttribPointer(ATTRIB_VERTEX, 3, GL_FLOAT, 0, 0, &sphereVertex3f[0]);
    glEnableVertexAttribArray(ATTRIB_VERTEX);
    
    GLuint modelViewMatrix = glGetUniformLocation(_program, "modelViewProjectionMatrix");
    GLKMatrix4 matrix = GLKMatrix4Multiply(_modelViewProjectionMatrix, GLKMatrix4MakeTranslation(-1.0f, 0.3f, 1.0f));
    glUniformMatrix4fv(modelViewMatrix, 1, 0, &matrix.m[0]);
    
    glDrawArrays(GL_TRIANGLE_STRIP, 0, sphereVertexCount);
}

- (void)createLines
{
    GLfloat line[6];
    
    unsigned char lineColor[8] =
    {
        0, 0, 0, 0,
        0, 0, 0, 0,
    };
    
    GLuint modelViewMatrix = glGetUniformLocation(_program, "modelViewProjectionMatrix");
    float x = 3.0f;
    float y = 0.0f;
    float z = 3.0f;
    float inc = 0;
    int lines = 31;
    
    for (int i=0; i<lines; i++) {
        line[0] = x - inc;
        line[1] = y;
        line[2] = z;
        line[3] = x - inc;
        line[4] = y;
        line[5] = -z;
        inc+=0.2;
        glVertexAttribPointer(ATTRIB_COLOR, 4, GL_UNSIGNED_BYTE, 1, 0, &lineColor[0]);
        glEnableVertexAttribArray(ATTRIB_COLOR);
        
        // Update attribute values.
        glVertexAttribPointer(ATTRIB_VERTEX, 3, GL_FLOAT, 0, 0, &line[0]);
        glEnableVertexAttribArray(ATTRIB_VERTEX);
        
        glUniformMatrix4fv(modelViewMatrix, 1, 0, &_modelViewProjectionMatrix.m[0]);
        glDrawArrays(GL_LINES, 0, 2);
    }
    
    inc = 0;
    for (int i=0; i<lines; i++) {
        line[0] = x;
        line[1] = y;
        line[2] = z - inc;
        line[3] = -x;
        line[4] = y;
        line[5] = z - inc;
        
        inc+=0.2;
        glVertexAttribPointer(ATTRIB_COLOR, 4, GL_UNSIGNED_BYTE, 1, 0, &lineColor[0]);
        glEnableVertexAttribArray(ATTRIB_COLOR);
        
        // Update attribute values.
        glVertexAttribPointer(ATTRIB_VERTEX, 3, GL_FLOAT, 0, 0, &line[0]);
        glEnableVertexAttribArray(ATTRIB_VERTEX);
        
        glUniformMatrix4fv(modelViewMatrix, 1, 0, &_modelViewProjectionMatrix.m[0]);
        glDrawArrays(GL_LINES, 0, 2);
    }
}

- (void)createBox
{
    GLfloat cube[] =
    {
        // Data layout for each line below is:
        // positionX, positionY, positionZ,     normalX, normalY, normalZ,
        0.5f, -0.5f, -0.5f,
        0.5f, 0.5f, -0.5f,
        0.5f, -0.5f, 0.5f,
        0.5f, -0.5f, 0.5f,
        0.5f, 0.5f, -0.5f,
        0.5f, 0.5f, 0.5f,
        
        0.5f, 0.5f, -0.5f,
        -0.5f, 0.5f, -0.5f,
        0.5f, 0.5f, 0.5f,
        0.5f, 0.5f, 0.5f,
        -0.5f, 0.5f, -0.5f,
        -0.5f, 0.5f, 0.5f,
        
        -0.5f, 0.5f, -0.5f,
        -0.5f, -0.5f, -0.5f,
        -0.5f, 0.5f, 0.5f,
        -0.5f, 0.5f, 0.5f,
        -0.5f, -0.5f, -0.5f,
        -0.5f, -0.5f, 0.5f,
        
        -0.5f, -0.5f, -0.5f,
        0.5f, -0.5f, -0.5f,
        -0.5f, -0.5f, 0.5f,
        -0.5f, -0.5f, 0.5f,
        0.5f, -0.5f, -0.5f,
        0.5f, -0.5f, 0.5f,
        
        0.5f, 0.5f, 0.5f,
        -0.5f, 0.5f, 0.5f,
        0.5f, -0.5f, 0.5f,
        0.5f, -0.5f, 0.5f,
        -0.5f, 0.5f, 0.5f,
        -0.5f, -0.5f, 0.5f,
        
        0.5f, -0.5f, -0.5f,
        -0.5f, -0.5f, -0.5f,
        0.5f, 0.5f, -0.5f,
        0.5f, 0.5f, -0.5f,
        -0.5f, -0.5f, -0.5f,
        -0.5f, 0.5f, -0.5f,
    };
    
//    GLfloat normalCube[] = {
//        1.0f, 0.0f, 0.0f,
//        1.0f, 0.0f, 0.0f,
//        1.0f, 0.0f, 0.0f,
//        1.0f, 0.0f, 0.0f,
//        1.0f, 0.0f, 0.0f,
//        1.0f, 0.0f, 0.0f,
//        0.0f, 1.0f, 0.0f,
//        0.0f, 1.0f, 0.0f,
//        0.0f, 1.0f, 0.0f,
//        0.0f, 1.0f, 0.0f,
//        0.0f, 1.0f, 0.0f,
//        0.0f, 1.0f, 0.0f,
//        -1.0f, 0.0f, 0.0f,
//        -1.0f, 0.0f, 0.0f,
//        -1.0f, 0.0f, 0.0f,
//        -1.0f, 0.0f, 0.0f,
//        -1.0f, 0.0f, 0.0f,
//        -1.0f, 0.0f, 0.0f,
//        0.0f, -1.0f, 0.0f,
//        0.0f, -1.0f, 0.0f,
//        0.0f, -1.0f, 0.0f,
//        0.0f, -1.0f, 0.0f,
//        0.0f, -1.0f, 0.0f,
//        0.0f, -1.0f, 0.0f,
//        0.0f, 0.0f, 1.0f,
//        0.0f, 0.0f, 1.0f,
//        0.0f, 0.0f, 1.0f,
//        0.0f, 0.0f, 1.0f,
//        0.0f, 0.0f, 1.0f,
//        0.0f, 0.0f, 1.0f,
//        0.0f, 0.0f, -1.0f,
//        0.0f, 0.0f, -1.0f,
//        0.0f, 0.0f, -1.0f,
//        0.0f, 0.0f, -1.0f,
//        0.0f, 0.0f, -1.0f,
//        0.0f, 0.0f, -1.0f
//    };

    
    int total = 36 * 4;
    unsigned char * color1 = new unsigned char[total];
    
    for (int i = 0; i < total; i += 4) {
		color1[i]   = 0;
		color1[i+1] = 100;
		color1[i+2] = 100;
        color1[i+3] = 0;
	}

    GLuint modelViewMatrix = glGetUniformLocation(_program, "modelViewProjectionMatrix");
//    GLuint normalMatrix = glGetUniformLocation(_program, "normalMatrix");
    
    glVertexAttribPointer(ATTRIB_VERTEX, 3, GL_FLOAT, 0, 0, &cube[0]);
    glEnableVertexAttribArray(ATTRIB_VERTEX);

    glVertexAttribPointer(ATTRIB_COLOR, 4, GL_UNSIGNED_BYTE, 1, 0, color1);
    glEnableVertexAttribArray(ATTRIB_COLOR);
    
//    glVertexAttribPointer(ATTRIB_NORMAL, 3, GL_FLOAT, 0, 0, &normalCube[0]);
//    glEnableVertexAttribArray(ATTRIB_NORMAL);
    
    GLKMatrix4 matrixModel = GLKMatrix4MakeTranslation(1.0f, 0.25f, 0.0f);
    matrixModel = GLKMatrix4Multiply(matrixModel, GLKMatrix4MakeScale(0.5f, 0.5f, 0.5f));

//    GLKMatrix3 _normalMatrix = GLKMatrix3InvertAndTranspose(GLKMatrix4GetMatrix3(matrixModel), NULL);
//    glUniformMatrix3fv(normalMatrix, 1, 0, _normalMatrix.m);

    GLKMatrix4 matrix = GLKMatrix4Multiply(_modelViewProjectionMatrix, matrixModel);
    glUniformMatrix4fv(modelViewMatrix, 1, 0, matrix.m);

    glDrawArrays(GL_TRIANGLES, 0, 36);
    

}

- (void)createText
{
// draw text
//    glEnable(GL_TEXTURE_2D);
//    glEnable(GL_BLEND);
//    glBlendFunc (GL_ONE, GL_ONE);
//    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
////    glColor4f(1.0, 1.0, 1.0, 1.0);
////    glLoadIdentity();
//    Texture2D * textTex = [[Texture2D alloc] initWithString:@"Silvio"
//                                                 dimensions:CGSizeMake(1., 40.0)
//                                                  alignment:UITextAlignmentCenter
//                                                   fontName:@"Arial"
//                                                   fontSize:14];
//    [textTex drawAtPoint: CGPointMake( 0.052083, -0.052083)]; // CGPointMake(160.0, 440.0)
//    glDisable(GL_BLEND);
//    glDisable(GL_TEXTURE_2D);
//    glDisableClientState(GL_TEXTURE_COORD_ARRAY);
}

- (void)createTriangleWithTriangularBase
{
    GLfloat triangle [] =
    {
         0.5f, 0.0f, 0.0f,
        -0.5f, 0.0f, 0.0f,
         0.0f, 0.0f, 0.5f,
         0.5f, 0.0f, 0.0f,
        
         0.5f, 0.0f, 0.0f,
        -0.5f, 0.0f, 0.0f,
         0.0f, 0.5f, 0.0f,
         0.5f, 0.0f, 0.0f,
        
         0.5f, 0.0f, 0.0f,
         0.0f, 0.0f, 0.5f,
         0.0f, 0.5f, 0.0f,
         0.5f, 0.0f, 0.0f,
        
         0.0f, 0.0f, 0.5f,
        -0.5f, 0.0f, 0.0f,
         0.0f, 0.5f, 0.0f,
         0.0f, 0.0f, 0.5f,
    };
    
    int vertices = 16;
    unsigned char * color = new unsigned char[vertices * 4];
    
    for (int i = 0; i < vertices * 4; i += 4) {
		color[i]   = 100;
		color[i+1] = 100;
		color[i+2] = 90;
        color[i+3] = 0;
	}
    
    glVertexAttribPointer(ATTRIB_COLOR, 4, GL_UNSIGNED_BYTE, 1, 0, color);
    glEnableVertexAttribArray(ATTRIB_COLOR);
    
    glVertexAttribPointer(ATTRIB_VERTEX, 3, GL_FLOAT, 0, 0, &triangle[0]);
    glEnableVertexAttribArray(ATTRIB_VERTEX);
    
    GLuint modelViewMatrix = glGetUniformLocation(_program, "modelViewProjectionMatrix");
    GLKMatrix4 matrix = GLKMatrix4Multiply(_modelViewProjectionMatrix, GLKMatrix4MakeTranslation(0.5f, 0.0f, 1.0f));
    glUniformMatrix4fv(modelViewMatrix, 1, 0, &matrix.m[0]);
    
    glDrawArrays(GL_TRIANGLE_STRIP, 0, vertices);
}

- (void)createTriangleWithSquareBase
{
    GLfloat triangle [] =
    {
        0.25f, 0.0f, -0.25f,
        0.25f, 0.0f, 0.25f,
        -0.25f, 0.0f, 0.25f,
        -0.25f, 0.0f, -0.25f,
        0.25f, 0.0f, -0.25f,
        
        0.25f, 0.0f, -0.25f,
        0.25f, 0.0f, 0.25f,
        0.0f, 0.5f, 0.0f,
        0.25f, 0.0f, -0.25f,
        
        0.25f, 0.0f, 0.25f,
        -0.25f, 0.0f, 0.25f,
        0.0f, 0.5f, 0.0f,
        0.25f, 0.0f, 0.25f,

        -0.25f, 0.0f, 0.25f,
        -0.25f, 0.0f, -0.25f,
        0.0f, 0.5f, 0.0f,
        -0.25f, 0.0f, 0.25f,
        
        -0.25f, 0.0f, -0.25f,
        0.25f, 0.0f, -0.25f,
        0.0f, 0.5f, 0.0f,
        -0.25f, 0.0f, -0.25f,

    };
    
    int vertices = 19;
    unsigned char * color = new unsigned char[vertices * 4];
    
    for (int i = 0; i < vertices * 4; i += 4) {
		color[i]   = 0;
		color[i+1] = 255;
		color[i+2] = 255;
        color[i+3] = 0;
	}
    
    glVertexAttribPointer(ATTRIB_COLOR, 4, GL_UNSIGNED_BYTE, 1, 0, color);
    glEnableVertexAttribArray(ATTRIB_COLOR);
    
    glVertexAttribPointer(ATTRIB_VERTEX, 3, GL_FLOAT, 0, 0, &triangle[0]);
    glEnableVertexAttribArray(ATTRIB_VERTEX);
    
    GLuint modelViewMatrix = glGetUniformLocation(_program, "modelViewProjectionMatrix");
    GLKMatrix4 matrix = GLKMatrix4Multiply(_modelViewProjectionMatrix, GLKMatrix4MakeTranslation(0.5f, 0.0f, -1.0f));
    glUniformMatrix4fv(modelViewMatrix, 1, 0, &matrix.m[0]);
    
    glDrawArrays(GL_TRIANGLE_STRIP, 0, vertices);

}


#pragma mark - GLKView and GLKViewController delegate methods
- (void)update
{
    float aspect = fabsf(self.view.frame.size.height / self.view.frame.size.width);
    
    GLKMatrix4 _perspectiveMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(60.0f), aspect, 0.5f, 10.0f);;
    GLKMatrix4 _lookAtMatrix = GLKMatrix4MakeLookAt(eyeX, eyeY, eyeZ, centerX, centerY, centerZ, 0.0f, 1.0f, 0.0f);

    _modelViewProjectionMatrix = GLKMatrix4Identity;
    _modelViewProjectionMatrix = GLKMatrix4Multiply(_modelViewProjectionMatrix, _perspectiveMatrix);
    _modelViewProjectionMatrix = GLKMatrix4Multiply(_modelViewProjectionMatrix, _lookAtMatrix);
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClearColor(0.65f, 0.65f, 0.65f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
        
    // Render the object again with ES2
    glUseProgram(_program);
    
    [self createLines];
    [self createBox];
    [self createSphere];
    [self createTriangleWithTriangularBase];
    [self createTriangleWithSquareBase];
}

#pragma mark -  OpenGL ES 2 shader compilation

- (BOOL)loadShaders
{
    GLuint vertShader, fragShader;
    NSString *vertShaderPathname, *fragShaderPathname;
    
    // Create shader program.
    _program = glCreateProgram();
    
    // Create and compile vertex shader.
    vertShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"vsh"];
    if (![self compileShader:&vertShader type:GL_VERTEX_SHADER file:vertShaderPathname]) {
        NSLog(@"Failed to compile vertex shader");
        return NO;
    }
    
    // Create and compile fragment shader.
    fragShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"fsh"];
    if (![self compileShader:&fragShader type:GL_FRAGMENT_SHADER file:fragShaderPathname]) {
        NSLog(@"Failed to compile fragment shader");
        return NO;
    }
    
    // Attach vertex shader to program.
    glAttachShader(_program, vertShader);
    
    // Attach fragment shader to program.
    glAttachShader(_program, fragShader);
    
    // Bind attribute locations.
    // This needs to be done prior to linking.
    glBindAttribLocation(_program, ATTRIB_VERTEX, "position");
    glBindAttribLocation(_program, ATTRIB_COLOR, "color");
//    glBindAttribLocation(_program, ATTRIB_NORMAL, "normal");
    
    // Link program.
    if (![self linkProgram:_program]) {
        NSLog(@"Failed to link program: %d", _program);
        
        if (vertShader) {
            glDeleteShader(vertShader);
            vertShader = 0;
        }
        if (fragShader) {
            glDeleteShader(fragShader);
            fragShader = 0;
        }
        if (_program) {
            glDeleteProgram(_program);
            _program = 0;
        }
        
        return NO;
    }
    
    // Release vertex and fragment shaders.
    if (vertShader) {
        glDetachShader(_program, vertShader);
        glDeleteShader(vertShader);
    }
    if (fragShader) {
        glDetachShader(_program, fragShader);
        glDeleteShader(fragShader);
    }
    
    return YES;
}

- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file
{
    GLint status;
    const GLchar *source;
    
    source = (GLchar *)[[NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil] UTF8String];
    if (!source) {
        NSLog(@"Failed to load vertex shader");
        return NO;
    }
    
    *shader = glCreateShader(type);
    glShaderSource(*shader, 1, &source, NULL);
    glCompileShader(*shader);
    
#if defined(DEBUG)
    GLint logLength;
    glGetShaderiv(*shader, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetShaderInfoLog(*shader, logLength, &logLength, log);
        NSLog(@"Shader compile log:\n%s", log);
        free(log);
    }
#endif
    
    glGetShaderiv(*shader, GL_COMPILE_STATUS, &status);
    if (status == 0) {
        glDeleteShader(*shader);
        return NO;
    }
    
    return YES;
}

- (BOOL)linkProgram:(GLuint)prog
{
    GLint status;
    glLinkProgram(prog);
    
#if defined(DEBUG)
    GLint logLength;
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program link log:\n%s", log);
        free(log);
    }
#endif
    
    glGetProgramiv(prog, GL_LINK_STATUS, &status);
    if (status == 0) {
        return NO;
    }
    
    return YES;
}

- (BOOL)validateProgram:(GLuint)prog
{
    GLint logLength, status;
    
    glValidateProgram(prog);
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program validate log:\n%s", log);
        free(log);
    }
    
    glGetProgramiv(prog, GL_VALIDATE_STATUS, &status);
    if (status == 0) {
        return NO;
    }
    
    return YES;
}

@end
