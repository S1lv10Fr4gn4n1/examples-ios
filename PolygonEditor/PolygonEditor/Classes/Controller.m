//
//  Controller.m
//  PolygonEditorObjC
//
//  Created by Silvio Fragnani on 18/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Controller.h"
#import "Circle.h"
#import "PolygonOpen.h"
#import "PolygonClose.h"
#import "Spline.h"


@interface Controller(){ //interface privada
    NDC * ndc;
}

- (void)selectObject: (Pointer *) _point;
- (BOOL)inBBox:(ObjectGraph *)object:(Pointer *)point;
- (BOOL)inObject:(ObjectGraph *)object:(Pointer *)point;
- (void)deleteObjetct;
- (void)deletePoint;
- (void)cleanAllObjects;
- (void)nextPointInObject;
- (void)setMovingPoint:(int)x:(int)y;
- (void)showBBox;
@end

@implementation Controller

@synthesize world;
@synthesize currentObjectGraph;
@synthesize maxPoints;
@synthesize totalPoints;
@synthesize modeEdition;

// variaveis responsaveis por pegar a origem do
// inicio das transformacoes
float xSource = 0;
float ySource = 0;
bool editDelePoint = false;
Class graphClass;

- (id)init
{
    self = [super init];
    if (self) {
        maxPoints   = -1;
        totalPoints = 0;
        modeEdition = false;
		
		world = [[World alloc] init];
//        [self.world setTop:0];
//        [self.world setBottom:480];
//        [self.world setLeft:0];
//        [self.world setRight:320];
        
		currentObjectGraph = nil;
        
        ndc = [[NDC alloc] init];
        
        Pointer * maxOrtho = [[Pointer alloc] init:1 :1 :0 :1];
        ndc.maxOrtho = maxOrtho;
        [maxOrtho release];
        
        Pointer * minOrtho = [[Pointer alloc] init:-1 :-1 :0 :1];
        ndc.minOrtho = minOrtho;
        [minOrtho release];
        
        Pointer * maxWindow = [[Pointer alloc] init:728 :1024 :0 :1];
        ndc.maxWindow = maxWindow;
        [maxWindow release];
        
        Pointer * minWindow = [[Pointer alloc] init:0 :0 :0 :1];
        ndc.minWindow = minWindow;
        [minWindow release];
		
		[self newGraphObject: [Line class]: -1];
    }
    
    return self;
}

- (void)dealloc
{
	[currentObjectGraph release];
	[world release];
    [super dealloc];
}

///! metodo responsavel por finalizar o objeto grafico corrente/em construcao
///! chama o metodo init do objeto grafico e adiciona ao mundo
- (void)finalizeConstructionObject
{
	[currentObjectGraph start];
	[world addObjsGraph: currentObjectGraph];
	
	// cria um novo objeto zerado
	[self newGraphObject: [ObjectGraph class]: -1 ];
}

///! metodo responsavel por fazer a finalizacao da edicao do objeto
- (void)finalizeEditionObject
{
	// desativa a trasnformacao, desativa o modo edicao,
	// inicializa a bbox com os novos valores
	//[[currentObjectGraph transform] setTypeTransform: NONE];
	//[currentObjectGraph setModeEdition: false];
	//[currentObjectGraph initBBox: [currentObjectGraph transform]];
    [currentObjectGraph release];
}

///! metodo responsavel por criar o novo objeto grafico e limitando sua
///! quantidade de pontos
- (void)newGraphObject:(Class)clazz:(int)_maxPoints
{
	if (editDelePoint) {
		return;
	}
	
	// caso ja exista um objeto grafico corrente carregado,
	// seta tipo de transformacao para NONE e deixar o modo de
	// edicao false, assim tirando o bbox do objeto e
	// quando carregado novamente nao ter um tipo de transformacao
	// ja carregados
	if (currentObjectGraph != 0) {
        //[self finalizeConstructionObject];
        //[currentObjectGraph start];
		[world addObjsGraph: currentObjectGraph];
        [self finalizeEditionObject];
	}
	
	// inicializacoes do novo objeto grafico
	currentObjectGraph = [[clazz alloc] init];
    
	// inicializacoes de variaveis de controle
	maxPoints = _maxPoints; //sfs talves colocar isso no ObjectGraph
	totalPoints = 0;
	modeEdition = false;	
}

///! metodo responsavel por verificar se o ponto selecionado
///! esta sobre algum objeto grafico.
- (void)selectObject:(Pointer *)point
{
	// itera sobre todos os objetos graficos existentes no mundo
	for (ObjectGraph * o in [world objsGraph]) {
		// verifica se esta dentro da bbox primeiro e caso esteja,
		// verifca com o metodo scan line
		if ([self inBBox: o: point] && [self inObject: o: point]) {
			// se for o mesmo objeto, nao faz nada
			if (currentObjectGraph == o)
				return;
			
			// finaliza o objeto corrente
			[self finalizeEditionObject];
                        
			// atribui o novo objeto e seta o modo de edicao nele
			currentObjectGraph = o;
			[currentObjectGraph setModeEdition: true];
			return;
		}		
	}
}

///! metodo responsavel por ver se o ponto selecionado esta dentro da bbox
- (BOOL)inBBox:(ObjectGraph *)object:(Pointer *)point
{
	// transforma os valores da bbox com a matrix de tranformacao do objeto
	[object initBBox:[object transform]];
	
	// dai consegue verificar se o ponto pertence a bbox
	bool result = [[object bbox]inBBox:point];
	
	// depois retorna os valores originais da bbox
	Transform * t = [[Transform alloc]init];
	[t autorelease];
	[object initBBox:t];
	
	return result;
}

///! metodo responsavel por ver se o ponto selecionado esta dentro do poligono
///! atraves do algoritmo scanline
- (BOOL)inObject:(ObjectGraph *)object:(Pointer *)point
{	
	NSArray * points = [object points];
	
	int countObjectsRight = 0;
	unsigned long next = 0;
	float ti = 0;
	float xi = 0;
	Pointer * p1 = 0;
	Pointer * p2 = 0;
	
	for (int i=0; i<[points count]; i++) {
		p1 = [points objectAtIndex:i];
		p1 = [[object transform]transformPoint:p1];
		
		next = (i + 1) % [points count];
		
		p2 = [points objectAtIndex:next];
		p2 = [[object transform]transformPoint:p2];
		
		// equacoes parametrica da reta
		ti = ([point y] - [p1 y]) / ([p2 y] - [p1 y]);
		xi = [p1 x] + ([p2 x] - [p1 x]) * ti;
		
		if ((ti >= 0.0f && ti <= 1.0f) && xi < [point x]) {
			countObjectsRight++;
		}
	}
	
	// caso exista um numero impar de linhas cruzando a scanline a direita
	// do ponto selecionado, entao esta selecionando um objeto.
	if (countObjectsRight % 2 != 0) {
		return true;
	}
	
	return false;
}

///! metodo responsavel por deletar o objeto selecionado
- (void)deleteObjetct
{
	[world deleteObject:currentObjectGraph];
	currentObjectGraph = 0;
	[self newGraphObject:[ObjectGraph class]:-1];
	
//	glutPostRedisplay(); //sfs
}

///! metodo responsavel por deletar um ponto do objeto
- (void)deletePoint
{
	if (!modeEdition)
		return;
	
	[currentObjectGraph deleteActualPoint];
}

///! metodo responsavel pode deletar todos os objetos da mundo
- (void)cleanAllObjects
{
	[world deleteAllObjects];
	[self newGraphObject:[ObjectGraph class]:-1];
	
//	glutPostRedisplay(); //sfs
}

- (void)nextPointInObject
{
	if (!modeEdition)
		return;
	
	[currentObjectGraph nextPointHighlights];	
}

- (void)setMovingPoint:(int)x:(int)y
{/*
	if (currentObjectGraph == 0)
		return;
	
	Pointer * p = [currentObjectGraph getPointHighlights];
	p = [self ndc: [p x]: [p y]];
	p = [[currentObjectGraph transform] transformPoint: p];
	xSource = [p x];
	ySource = [p y];
	
	editDelePoint = !editDelePoint;*/
}

- (void)showBBox
{
	Transform * t = [[Transform alloc]init];
	[t autorelease];
	[currentObjectGraph initBBox:t];
	[currentObjectGraph showBBox];	
}

// metodo responsavel por desenhar todos os objetos graficos do grafo de cena
- (void)drawAllObj:(GLuint)program
{
    glUseProgram(program);
    
    glClearColor(0.5f, 0.5f, 0.5f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT);
    
    if(currentObjectGraph != 0)
        [currentObjectGraph draw];
    
	for (ObjectGraph * object in [world objsGraph]) {
		if (object == currentObjectGraph) {
			continue;
		}
		
		[object draw];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event point:(CGPoint)point
{
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event point:(CGPoint)point
{    
    NSLog(@"1Began -> x: %f, y: %f", point.x, point.y);

    Pointer * p = [[Pointer alloc] init: point.x :point.y :0 :1];
    
    NSLog(@"2Began -> x: %f, y: %f", p.x, p.y);

    
    [ndc calcCoordinates: p ];
    
    if(![currentObjectGraph addPoint: p]){
        [self newGraphObject:graphClass :-1];
    }
    
    [p release];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event point:(CGPoint)point
{
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event point:(CGPoint)point
{
}

- (void)changeTypeObject:(int)indexObject
{
    if (currentObjectGraph != 0) {
        [currentObjectGraph start];
        [world addObjsGraph: currentObjectGraph];
    }

	switch(indexObject){
		case LINE:
			// seleciona para criacao o linhas
			// -1 = sem limites de pontos
			[self newGraphObject:[Line class]:-1];
            graphClass = [Line class];
			break;
			
		case CIRCLE:
			// seleciona para criacao o circulo
			// dando a limitacao de 2 pontos
			[self newGraphObject:[Circle class]:2];
            graphClass = [Circle class];
			break;
			
		case POLYGON_OPEN:
			// seleciona para criacao o poligono aberto
			// -1 = sem limites de pontos
			[self newGraphObject:[PolygonOpen class]:-1];
            graphClass = [PolygonOpen class];
			break;
			
		case POLYGON_CLOSE:
			// seleciona para criacao o poligono fechado
			// -1 = sem limites de pontos
			[self newGraphObject:[PolygonClose class]:-1];
            graphClass = [PolygonClose class];
			break;
			
		case SPLINE:
			// seleciona para criacao o spline
			// dado a limitacao de 4 pontos
			[self newGraphObject:[Spline class]:4];
            graphClass = [Spline class];
			break;
            
        case CONFIRM:
            if (currentObjectGraph != 0) {
                [currentObjectGraph start];
                [world addObjsGraph: currentObjectGraph];
                currentObjectGraph = nil;
            }
            break;
    }
}

@end
