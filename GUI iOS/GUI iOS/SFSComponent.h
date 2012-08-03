//
//  SFSComponent.h
//  GUI iOS
//
//  Created by Silvio Fragnani da Silva on 31/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef SFSComponent_h
#define SFSComponent_h

class SFSComponent {
private:
    float x;
    float y;
    
    float width;
    float height;
public:
    SFSComponent();
    ~SFSComponent();
    
    virtual void init() = 0;
    virtual void draw() = 0;
    
    //GETTERS SETTERS
    void setX(float _x);
    float getX();
    void setY(float _y);
    float getY();
    void setWidth(float _width);
    float getWidht();
    void setHeigth(float _height);
    float getHeight();
};

#endif
