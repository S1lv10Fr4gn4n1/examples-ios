//
//  Shader.fsh
//  TemplateGame
//
//  Created by Silvio Fragnani da Silva on 27/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
