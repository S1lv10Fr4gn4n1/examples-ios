//
//  SFSComponent.cpp
//  GUI iOS
//
//  Created by Silvio Fragnani da Silva on 31/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#include "SFSComponent.h"

SFSComponent::SFSComponent()
{
    x = 0;
    y = 0;
    width = 0;
    height = 0;
}

SFSComponent::~SFSComponent()
{
    //TODO code implementation
}

void SFSComponent::init()
{
    //TODO code implementation
}

void SFSComponent::draw()
{
    //TODO code implementation
}

void SFSComponent::setX(float _x)
{
    x = _x;
}

float SFSComponent::getX()
{
    return x;
}

void SFSComponent::setY(float _y)
{
    y = _y;
}

float SFSComponent::getY()
{
    return y;
}

void SFSComponent::setWidth(float _width)
{
    width = _width;
}

float SFSComponent::getWidht()
{
    return width;
}

void SFSComponent::setHeigth(float _height)
{
    height = _height;
}

float SFSComponent::getHeight()
{
    return height;
}

