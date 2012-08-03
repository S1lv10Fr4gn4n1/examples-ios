//
//  Shader.fsh
//  TemplateGameClean
//
//  Created by Silvio Fragnani da Silva on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
