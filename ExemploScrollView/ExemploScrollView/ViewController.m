//
//  ViewController.m
//  ExemploScrollView
//
//  Created by Silvio Fragnani da Silva on 13/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize imageView = _imageView;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIImage *image = [UIImage imageNamed:@"nao-alimente-analista.jpg"];
    _imageView = [[UIImageView alloc] initWithImage:image];
    [self.view addSubview:_imageView];
    
    //seta o tamanho da imagem para o scroll
    [(UIScrollView *)self.view setContentSize: [image size]];
    
    // configurando para funcionar o zoom
    [(UIScrollView *)self.view setMaximumZoomScale:3.0];
    [(UIScrollView *)self.view setMinimumZoomScale:0.1];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *) scrollView
{
    return _imageView;
}

@end
