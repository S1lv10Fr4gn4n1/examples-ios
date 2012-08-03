//
//  SFSWindow.h
//  GUI iOS
//
//  Created by Silvio Fragnani da Silva on 31/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef SFSWindow_h
#define SFSWindow_h

#include "SFSComponent.h"

class SFSWindow: public SFSComponent {
    
public:
    SFSWindow();
    ~SFSWindow();
    
    virtual void init();
    virtual void draw();
};


#endif
