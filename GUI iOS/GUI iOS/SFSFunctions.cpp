//
//  SFSFunctions.cpp
//  GUI iOS
//
//  Created by Silvio Fragnani da Silva on 01/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

void calcNDCCoordinates(float *_x, float *_y)
{
    //TODO refazer NDC, valores fixos para o window/ortho do iPad 2

    float deltaO, deltaD;
    
    deltaO = 728 - 0;
    deltaD = 1 - (-1);
    *_x = (*_x * (deltaD / deltaO)) + (-1);
    deltaO = 1024 - 0;
    deltaD = 1 - (-1);
    *_y = ((1024 - *_y) * (deltaD /deltaO)) + (-1);
}



