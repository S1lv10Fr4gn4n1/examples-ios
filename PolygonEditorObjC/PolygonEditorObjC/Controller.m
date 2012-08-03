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

- (id)init
{
    self = [super init];
    if (self) {
		self.maxPoints   = -1;
		self.totalPoints = 0;
		self.modeEdition = false;
		
		self.world = [[World alloc] init];
		self.currentObjectGraph = nil;
		
		[self newGraphObject: [ObjectGraph class]: -1];
    }
    
    return self;
}

- (void)dealloc
{
	[self.currentObjectGraph release];
	[self.world release];
    [super dealloc];
}

- (void) displayMenu
{
	NSLog(@"option '1'  Circle");
	NSLog(@"option '2'  Polygon Close");
	NSLog(@"option '3'  Polygon Open");
	NSLog(@"option '4'  Spline");
	NSLog(@"option 'F1' Translate Object");
	NSLog(@"option 'F2' Scale Object");
	NSLog(@"option 'F3' Rotate Object");
	NSLog(@"option 'i'  ZOOM In");
	NSLog(@"option 'o'  ZOOM Out");
	NSLog(@"option 'w'  PAN North");
	NSLog(@"option 'a'  PAN West");
	NSLog(@"option 'd'  PAN East");
	NSLog(@"option 's'  PAN South");
	NSLog(@"option 'r'  Back Matrix Identity");
	NSLog(@"option 'c'  Clear all objects");
	NSLog(@"option 'del'  Delete object select");
	NSLog(@"option 'x'  Move point select");
	NSLog(@"option 'tab'  Select point for move");
	NSLog(@"option 'tab'  Select point for move");
	NSLog(@"option 'space' finalize object");
	NSLog(@"option 'q' Exit");
	NSLog(@"option 'm' Display menu");
}

// metodo responsavel por retornar uma cor aleatoria para o objeto grafico
- (Color *) getRandomColor
{
	Color * color = [[Color alloc] init];
	[color autorelease];
	
	unsigned char byte;
	
	byte = (rand() % 256);
	[color setR: byte];

	byte = (rand() % 256);
	[color setG: byte];
	
	byte = (rand() % 256);
	[color setB: byte];
	
	return color;
	
}

// metodo responsavel por finalizar o objeto grafico corrente/em construcao
// chama o metodo init do objeto grafico e adiciona ao mundo
- (void) finalizeConstructionObject
{
	[currentObjectGraph start];
	[world addObjsGraph: currentObjectGraph];
	
	// cria um novo objeto zerado
	[self newGraphObject: [ObjectGraph class]: -1 ];
}

// metodo responsavel por fazer a finalizacao da edicao do objeto
- (void) finalizeEditionObject
{
	// desativa a trasnformacao, desativa o modo edicao,
	// inicializa a bbox com os novos valores
	//[[currentObjectGraph transform] setTypeTransform: NONE];
	//[currentObjectGraph setModeEdition: false];
	//[currentObjectGraph initBBox: [currentObjectGraph transform]];
    [currentObjectGraph release];
}

// metodo responsavel por criar o novo objeto grafico e limitando sua
// quantidade de pontos
- (void) newGraphObject: (Class) _class: (int) _maxPoints
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
		[self finalizeEditionObject];
	}
	
	// inicializacoes do novo objeto grafico
	currentObjectGraph = [[_class alloc] init];
    
	[currentObjectGraph setColor: [self getRandomColor]];
	[[currentObjectGraph transform] setTypeTransform: NONE];
	
	// inicializacoes de variaveis de controle
	maxPoints = _maxPoints;
	totalPoints = 0;
	modeEdition = false;	
}

// metodo responsavel por fazer o NDC (Coordenadas de Dispositivos Normalizados) / normalizacao
- (Pointer *) ndc: (float) _x: (float) _y
{
	float x = _x * (([world right] - [world left]) / [world width]) + [world left];
	float y = _y * (([world bottom] - [world top]) / [world height]) + [world top];
	
	Pointer * point = [[Pointer alloc] init:x :y :0 :1];
	[point autorelease];
	return point;
	
}

// metodo responsavel por verificar se o ponto selecionado
// esta sobre algum objeto grafico.
- (void) selectObject: (Pointer *) _point
{
	// itera sobre todos os objetos graficos existentes no mundo
	for (ObjectGraph * o in [world objsGraph]) {
		// verifica se esta dentro da bbox primeiro e caso esteja,
		// verifca com o metodo scan line
		if ([self inBBox: o: _point] && [self inObject: o: _point]) {
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

// metodo responsavel por ver se o ponto selecionado esta dentro da bbox
- (BOOL) inBBox: (ObjectGraph *) _object: (Pointer *) _point
{
	// transforma os valores da bbox com a matrix de tranformacao do objeto
	[_object initBBox: [_object transform]];
	
	// dai consegue verificar se o ponto pertence a bbox
	bool result = [[_object bbox] inBBox: _point];
	
	// depois retorna os valores originais da bbox
	Transform * t = [[Transform alloc] init];
	[t autorelease];
	[_object initBBox: t];
	
	return  result;
}

// metodo responsavel por ver se o ponto selecionado esta dentro do poligono
// atraves do algoritmo scanline
- (BOOL) inObject: (ObjectGraph *) _object: (Pointer *) _point
{
	
	NSArray * points = [_object points];
	
	int countObjectsRight = 0;
	unsigned long next = 0;
	float ti = 0;
	float xi = 0;
	Pointer * p1 = 0;
	Pointer * p2 = 0;
	
	for (int i=0; i<[points count]; i++) {
		p1 = [points objectAtIndex: i];
		p1 = [[_object transform] transformPoint: p1];
		
		next = (i + 1) % [points count];
		
		p2 = [points objectAtIndex: next];
		p2 = [[_object transform] transformPoint: p2];
		
		// equacoes parametrica da reta
		ti = ([_point y] - [p1 y]) / ([p2 y] - [p1 y]);
		xi = [p1 x] + ([p2 x] - [p1 x]) * ti;
		
		if ((ti >= 0.0f && ti <= 1.0f) && xi < [_point x]) {
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

// metodo responsavel por deletar o objeto selecionado
- (void) deleteObjetct
{
	[world deleteObject: currentObjectGraph];
	currentObjectGraph = 0;
	[self newGraphObject: [ObjectGraph class]: -1];
	
	glutPostRedisplay();
}

// metodo responsavel por deletar um ponto do objeto
- (void) deletePoint
{
	if (!modeEdition)
		return;
	
	[currentObjectGraph deleteActualPoint];
}

// metodo responsavel pode deletar todos os objetos da mundo
- (void) cleanAllObjects
{
	[world deleteAllObjects];
	[self newGraphObject: [ObjectGraph class]: -1];
	
	glutPostRedisplay();
}

- (void) nextPointInObject
{
	if (!modeEdition)
		return;
	
	[currentObjectGraph nextPointHighlights];	
}

- (void) setMovingPoint: (int) _x: (int) _y
{
	if (currentObjectGraph == 0)
		return;
	
	Pointer * p = [currentObjectGraph getPointHighlights];
	p = [self ndc: [p x]: [p y]];
	p = [[currentObjectGraph transform] transformPoint: p];
	xSource = [p x];
	ySource = [p y];
	
	editDelePoint = !editDelePoint;
}

- (void) showBBox
{
	Transform * t = [[Transform alloc] init];
	[t autorelease];
	[currentObjectGraph initBBox: t];
	[currentObjectGraph showBBox];	
}

// metodo responsavel por desenhar todos os objetos graficos do grafo de cena
- (void) drawAllObj
{
	// para todos os objetos desenhados abaixo:
	// - guardar a matrix interna atual do opengl
	// - setar a matrix com as transformacoes(se existirem) do objeto atual
	// - desenha o objeto
	// - volta a matrix que foi empilhada
	
	glPushMatrix();
	glMultMatrixf([[currentObjectGraph transform] getMatrix]);
	[currentObjectGraph draw];
	glPopMatrix();
	
	for (ObjectGraph * object in [world objsGraph]) {
		if (object == currentObjectGraph) {
			continue;
		}
		
		glPushMatrix();
		glMultMatrixf([[object transform] getMatrix]);
		[object draw];
		glPopMatrix();
	}
}

// metodo responsavel por fazer os controles necessarios quando a tela
// for redimencionada
- (void) reshape: (int) _width: (int) _heigth
{
	[world recalculateWorldDimension: _width: _heigth];
	glViewport(0, 0, _width, _heigth);
	
}

// metodo responsavel por pegar os eventos do teclado.
// utilizado para pegar as opcoes que o usuario quer fazer
// com o sistema
- (void) keyboard: (unsigned char) _key: (int) _x: (int) _y
{
	switch (_key) {
		case '1':
			// seleciona para criacao o circulo
			// dando a limitacao de 2 pontos
			[self newGraphObject: [Circle class]: 2];
			break;
			
		case '2':
			// seleciona para criacao o poligono fechado
			// -1 = sem limites de pontos
			[self newGraphObject: [PolygonClose class]: -1];
			break;
			
		case '3':
			// seleciona para criacao o poligono aberto
			// -1 = sem limites de pontos
			[self newGraphObject: [PolygonOpen class]: -1];
			break;
			
		case '4':
			// seleciona para criacao o spline
			// dado a limitacao de 4 pontos
			[self newGraphObject: [Spline class]: 4];
			break;
			
		case 32:
			// finaliza a criacao do objeto grafico, no caso dos poligonos
			if (maxPoints > 0)
				return;
			
			[self finalizeConstructionObject];
			break;
			
		case 'R':
		case 'r':
			// volta a matriz identidade do objeto grafico selecionado/corrente
			[[currentObjectGraph transform] makeIdentity ];
			break;
			
		case 'M':
		case 'm':
			// imprime o menu no prompt
			[self displayMenu];
			break;
			
		case 'Q':
		case 'q':
			// mata o programa
			exit(0);
			break;
			
		case 'E':
		case 'e':
			// ENTRA EM MODO EDICAO
			modeEdition = true;
			break;
			
		case 'G':
		case 'g':
			// deleta um ponto do objeto
			[self deletePoint];
			break;
			
		case 'B':
		case 'b':
			// mostra a bbox
			[self showBBox];
			break;
			
			// PAN
		case 'W':
		case 'w':
			// direcao norte
			[world northPAN];
			break;
			
		case 'A':
		case 'a':
			// direcao oeste
			[world westPAN];
			break;
			
		case 'S':
		case 's':
			// direcao sul
			[world southPAN];
			break;
			
		case 'D':
		case 'd':
			// direcao leste
			[world eastPAN];
			break;
			
			// ZOOM
		case 'I':
		case 'i':
			// zoom in
			[world zoomIn];
			break;
			
		case 'O':
		case 'o':
			// zoom out
			[world zoomOut];
			break;
			
		case 'X':
		case 'x':
			// movendo pontos
			[self setMovingPoint: _x: _y];
			break;
			
		case 'C':
		case 'c':
			[self cleanAllObjects];
			break;
			
		case '\t':
			[self nextPointInObject];
			break;
			
		case 27:
			// ESC, sai do modo de edicao
			modeEdition = false;
			[self finalizeEditionObject];
			[self newGraphObject: [ObjectGraph class]: -1];
			break;
			
		case 127:
			[self deleteObjetct];
			break;
	}
	
	glutPostRedisplay();
	
}

// metodo responsavel por pegar teclas especiais do teclado F1, F2 ...
// pega o tipo de transformacao a ser usada pelo objeto grafico e o
// ponto inicial para calculos posteriores
- (void) special: (int) _key: (int) _x: (int) _y
{
	if (editDelePoint)
		return;
	
	// pega a transformacao do objeto corrente para depois setar o tipo de trasnformacao.
	Transform * transform = [currentObjectGraph transform];
	
	// pega o ponto de origem normalizado
	Pointer * point = [self ndc: _x: _y];
	xSource = [point x];
	ySource = [point y];
	
	switch (_key) {
		case GLUT_KEY_F1:
			[transform setTypeTransform: TRANSLATE];
			break;
			
		case GLUT_KEY_F2:
			// XGH+POG pegar o valor inicial da matrix
			// para o objeto nao iniciar minusculo
			xSource = [transform getElement: 0];
			ySource = [transform getElement: 5];
			[transform setTypeTransform: SCALE];
			break;
			
		case GLUT_KEY_F3:
			[transform setTypeTransform: ROTATE];
			break;
			
		case GLUT_KEY_F4:
			[transform setTypeTransform: NONE];
			break;
	}
	
}

// responsavel por receber os pontos gerados pelo mouse
// passando pela normalizacao (NDC) e passando para o objeto corrente
// para q se case tenha alguma trasnformacao a ser feita, usar os pontos
- (void) motion: (int) _x: (int) _y
{
	Pointer * point = [self ndc: _x: _y];
	[[currentObjectGraph transform] transformGraphObject: [point x] - xSource : [point y] - ySource : 0];
	glutPostRedisplay();	
}

// controle de click do mouse
- (void) mouse: (int) _button: (int) _state: (int) _x: (int) _y
{
	if (editDelePoint) {
		return;
	}
	
	if (_state == GLUT_DOWN) {
		// passa pelo NDC
		Pointer * point = [self ndc: _x: _y];
		
		// caso nao esteja em modo de edicao, ele ira colocar os pontos
		// gerado pelo click do mouse, no objeto grafico corrente
		if (!modeEdition) {
			[currentObjectGraph addPoint: point];
			totalPoints++;
		} else {
			// caso estiver em edicao, ele ira ver se o click é sobre
			// um objeto grafico
			[self selectObject: point];
		}
	}
	
	// verifica a quantidade maxima de pontos para
	// o circulo e spline q sao limitados a 2 e 4 pontos respectivamente
	if (maxPoints == totalPoints) {
		// finaliza o objeto
		[self finalizeConstructionObject];
		totalPoints = 0;
	}
	
	glutPostRedisplay();	
}

- (void) passive: (int) _x: (int) _y
{
	if (!editDelePoint)
		return;
	
	Pointer * point = [self ndc: _x: _y];
	[[currentObjectGraph transform] transformPoint: point];
	[currentObjectGraph setPointHighlights: point];
	[currentObjectGraph start];
	glutPostRedisplay();

}

- (double) getOrtho2DLeft
{
	return [world left];
}

- (double) getOrtho2DRight
{
	return [world right];
}

- (double) getOrtho2DBottom
{
	return [world bottom];
}

- (double) getOrtho2DTop
{
	return [world top];
}
@end
