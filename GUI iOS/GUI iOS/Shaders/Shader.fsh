//
//  Shader.fsh
//  GUI iOS
//
//  Created by Silvio Fragnani da Silva on 20/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
