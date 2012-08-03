//
//  PolygonEditorViewController.m
//  PolygonEditor
//
//  Created by Silvio Fragnani on 06/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "PolygonEditorViewController.h"
#import "EAGLView.h"


@interface PolygonEditorViewController ()
@property (nonatomic, retain) EAGLContext *context;
@property (nonatomic, assign) CADisplayLink *displayLink;
- (BOOL)loadShaders;
- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file;
- (BOOL)linkProgram:(GLuint)prog;
- (BOOL)validateProgram:(GLuint)prog;

- (void)createToolBar; 

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
@end

@implementation PolygonEditorViewController

@synthesize context, displayLink;

//variaveis globais
int beforeIndex = 0;

- (void)awakeFromNib
{
    EAGLContext *aContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    if (!aContext)
        NSLog(@"Failed to create ES context");
    else if (![EAGLContext setCurrentContext:aContext])
        NSLog(@"Failed to set ES context current");
    
	self.context = aContext;
	[aContext release];
	
    [(EAGLView *)self.view setContext:context];
    [(EAGLView *)self.view setFramebuffer];
    
    [self createToolBar];
    
    
    if ([context API] == kEAGLRenderingAPIOpenGLES2)
        [self loadShaders];
    
    self.displayLink = nil;
}

- (void)start 
{
    CADisplayLink *aDisplayLink = [[UIScreen mainScreen] displayLinkWithTarget:self selector:@selector(drawFrame)];
    [aDisplayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    self.displayLink = aDisplayLink;
    
    controller = [[Controller alloc] init];
}

- (void)dealloc
{
    if (program) {
        glDeleteProgram(program);
        program = 0;
    }
    
    // Tear down context.
    if ([EAGLContext currentContext] == context)
        [EAGLContext setCurrentContext:nil];
    
    [context release];
    
    [controller release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	
    if (program) {
        glDeleteProgram(program);
        program = 0;
    }
    
    // Tear down context.
    if ([EAGLContext currentContext] == context)
        [EAGLContext setCurrentContext:nil];
	self.context = nil;	
}

- (void)drawFrame
{
    [(EAGLView *)self.view setFramebuffer];
    
    [controller drawAllObj:program];
     
    [(EAGLView *)self.view presentFramebuffer];
}

- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file
{
    GLint status;
    const GLchar *source;
    
    source = (GLchar *)[[NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil] UTF8String];
    if (!source)
    {
        NSLog(@"Failed to load vertex shader");
        return FALSE;
    }
    
    *shader = glCreateShader(type);
    glShaderSource(*shader, 1, &source, NULL);
    glCompileShader(*shader);
    
#if defined(DEBUG)
    GLint logLength;
    glGetShaderiv(*shader, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0)
    {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetShaderInfoLog(*shader, logLength, &logLength, log);
        NSLog(@"Shader compile log:\n%s", log);
        free(log);
    }
#endif
    
    glGetShaderiv(*shader, GL_COMPILE_STATUS, &status);
    if (status == 0)
    {
        glDeleteShader(*shader);
        return FALSE;
    }
    
    return TRUE;
}

- (BOOL)linkProgram:(GLuint)prog
{
    GLint status;
    
    glLinkProgram(prog);
    
#if defined(DEBUG)
    GLint logLength;
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0)
    {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program link log:\n%s", log);
        free(log);
    }
#endif
    
    glGetProgramiv(prog, GL_LINK_STATUS, &status);
    if (status == 0)
        return FALSE;
    
    return TRUE;
}

- (BOOL)validateProgram:(GLuint)prog
{
    GLint logLength, status;
    
    glValidateProgram(prog);
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0)
    {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program validate log:\n%s", log);
        free(log);
    }
    
    glGetProgramiv(prog, GL_VALIDATE_STATUS, &status);
    if (status == 0)
        return FALSE;
    
    return TRUE;
}

- (BOOL)loadShaders
{
    GLuint vertShader, fragShader;
    NSString *vertShaderPathname, *fragShaderPathname;
    
    // Create shader program.
    program = glCreateProgram();
    
    // Create and compile vertex shader.
    vertShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"vsh"];
    if (![self compileShader:&vertShader type:GL_VERTEX_SHADER file:vertShaderPathname])
    {
        NSLog(@"Failed to compile vertex shader");
        return FALSE;
    }
    
    // Create and compile fragment shader.
    fragShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"fsh"];
    if (![self compileShader:&fragShader type:GL_FRAGMENT_SHADER file:fragShaderPathname])
    {
        NSLog(@"Failed to compile fragment shader");
        return FALSE;
    }
    
    // Attach vertex shader to program.
    glAttachShader(program, vertShader);
    
    // Attach fragment shader to program.
    glAttachShader(program, fragShader);
    
    // Bind attribute locations.
    // This needs to be done prior to linking.
    glBindAttribLocation(program, ATTRIB_VERTEX, "position");
    glBindAttribLocation(program, ATTRIB_COLOR, "color");
    
    // Link program.
    if (![self linkProgram:program])
    {
        NSLog(@"Failed to link program: %d", program);
        
        if (vertShader)
        {
            glDeleteShader(vertShader);
            vertShader = 0;
        }
        if (fragShader)
        {
            glDeleteShader(fragShader);
            fragShader = 0;
        }
        if (program)
        {
            glDeleteProgram(program);
            program = 0;
        }
        
        return FALSE;
    }
    
    // Release vertex and fragment shaders.
    if (vertShader)
        glDeleteShader(vertShader);
    if (fragShader)
        glDeleteShader(fragShader);
    
    return TRUE;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint p = [[touches anyObject] locationInView: self.view]; 
    [controller touchesBegan:touches withEvent:event point:p];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint p = [[touches anyObject] locationInView: self.view]; 
    [controller touchesEnded:touches withEvent:event point:p];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint p = [[touches anyObject] locationInView: self.view]; 
    [controller touchesMoved:touches withEvent:event point:p];
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint p = [[touches anyObject] locationInView: self.view]; 
    [controller touchesCancelled:touches withEvent:event point:p];
}

- (void)createToolBar
{
	segmentedControl = [[UISegmentedControl alloc] initWithItems:
											[NSArray arrayWithObjects:
                                             [UIImage imageNamed:@"linha.png"],
                                             [UIImage imageNamed:@"circulo.png"],
                                             [UIImage imageNamed:@"poligono_aberto.png"],
                                             [UIImage imageNamed:@"poligono_fechado.png"],
                                             [UIImage imageNamed:@"spline.png"],
                                             [UIImage imageNamed:@"confirm.png"],
                                             @"hidden",
                                             nil]];

    float kPaletteHeight = 40;        
    float kLeftMargin  = 10.0;
    float kTopMargin   = 10.0;
    float kRightMargin = 10.0;
    
    
    // pega o tamanho da window
    CGRect rect = [[UIScreen mainScreen] applicationFrame];
    
	// criar um retangulo para colocar os componentes de desenho
    CGRect toolsFrame = CGRectMake(rect.origin.x + kLeftMargin, 
                                   rect.size.height - kPaletteHeight - kTopMargin, 
                                   rect.size.width - (kLeftMargin + kRightMargin), 
                                   kPaletteHeight);
    
    segmentedControl.frame = toolsFrame;
	
    // quando mudar de tipo de desenho, o metodo changeTypeDraw será chamado
	[segmentedControl addTarget:self action:@selector(changeTypeDraw:) forControlEvents: UIControlEventValueChanged];

	segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
	// cor do componente
	segmentedControl.tintColor = [UIColor darkGrayColor];
	// primeiro controle selecionado
	segmentedControl.selectedSegmentIndex = 0;
	
	// adiciona o segmentedControl na sub view no window
	[self.view addSubview:segmentedControl];
	// como o segmentedControl foi adicionado ao window, pode/deve ser dado release
	[segmentedControl release];
    
        
    
    openTools = [[UISegmentedControl alloc] init];
    [openTools insertSegmentWithTitle:@"open" atIndex:5 animated:FALSE];
    
	// criar um retangulo para colocar os componentes de desenho
    CGRect openToolsframe = CGRectMake(rect.size.width - 60, 
                                       rect.size.height - kPaletteHeight - kTopMargin, 
                                       50, 
                                       kPaletteHeight);
    
    openTools.frame = openToolsframe;
	
    // quando mudar de tipo de desenho, o metodo changeTypeDraw será chamado
	[openTools addTarget:self action:@selector(openSegmentControl:) forControlEvents: UIControlEventValueChanged];
	openTools.segmentedControlStyle = UISegmentedControlStyleBar;
    
    // cor do componente
	openTools.tintColor = [UIColor darkGrayColor];
	// primeiro controle selecionado
	
	// adiciona o segmentedControl na sub view no window
	[self.view addSubview:openTools];
    [openTools setHidden:TRUE];
    
	// como o segmentedControl foi adicionado ao window, pode/deve ser dado release
	[openTools release];
}

- (void)openSegmentControl:(id)sender
{
    [segmentedControl setHidden:FALSE];
    [openTools setHidden:TRUE];
}

- (void)changeTypeDraw:(id)sender
{
    [controller changeTypeObject: [sender selectedSegmentIndex]];
    
    if ([sender selectedSegmentIndex] == 5) {
        [sender setSelectedSegmentIndex:beforeIndex];
        [controller changeTypeObject: [sender selectedSegmentIndex]];
    }
    else if ([sender selectedSegmentIndex] == 6) {
        [openTools setHidden:FALSE];
        [segmentedControl setHidden:TRUE];
        [openTools setSelectedSegmentIndex:-1];
        [segmentedControl setSelectedSegmentIndex:0];
        [sender setSelectedSegmentIndex:beforeIndex];
    }
    beforeIndex = [sender selectedSegmentIndex];
    
}

@end
