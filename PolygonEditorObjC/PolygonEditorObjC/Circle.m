//
//  Circle.m
//  PolygonEditorObjC
//
//  Created by Silvio Fragnani on 18/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Circle.h"


@implementation Circle

@synthesize radius;
@synthesize pointInit;

- (id)init
{
    self = [super init];
    if (self) {
		// inicializa com -1 para indicar q ainda nao foi criado o circulo ainda.
		self.radius = -1;
		self.indexHighlights = 1;
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

// metodo responsavel por inicializacao antes de desenhar o objeto
- (void) start
{
	// pega o primeiro ponto, que idicara a origem do circulo
	pointInit = [points objectAtIndex: 0];
	Pointer * p2 = [points objectAtIndex: 1];
	
	// limpa lista de pontos e volta a colocar os pontos init e p2
	[points removeAllObjects];
	[points addObject: pointInit];
	[points addObject: p2];
	
	float x = [pointInit x] - [p2 x];
	float y = [pointInit y] - [p2 y];
	
	// faz o calculo para pegar o raio do circulo
	// conforme os pontos selecionados
	//d²=(x0-x)²+(y0-y)²
	float d = x*x + y*y;
	radius = pow(d, 0.5);
	
	float x1;
	float y1;
	
	// gera pontos para criar o circulo, esses pontos sao guardados
	// para posteriormente pode ser usados no algoritmo de scanline
	for (int i=0; i<36; i++) {
		x1 = (radius * cos(M_PI * i*10 / 180.0f));
		y1 = (radius * sin(M_PI * i*10 / 180.0f));
		
		Pointer * p = [[Pointer alloc] init: x1 + [pointInit x]: y1 + [pointInit y]: 0.0f: 1.0f];
		[p autorelease];
		[points addObject: p];
	}
	
	// chama o init do pai (criacao da bbox)
	[super start];
}

- (void) draw
{
	// caso ainda nao tenha gerado o raio, nao desenha o objeto
	if (radius == -1) {
		return;
	}
	
	// chama o draw do pai para poder desenhar o bbox
	// em torno do objeto grafico quando no estado de edicao
	// e passar a cor
	[super draw];
	
	glBegin(GL_LINE_LOOP);
	// comeca apartir do 2 o ponto de origem e o secundario responsavel
	// de gerar o raio, se mante-los, o circulo fica defeituoso
	for (int i = 2; i < [points count]; i++) {
		Pointer * point = [points objectAtIndex: i];
		glVertex2f([point x], [point y]);
	}
	glEnd();

}

- (void) nextPointHighlights
{
	// somente o ponto q da o raio
	self.indexHighlights = 1;	
}


@end
