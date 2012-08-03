//
//  Shader.vsh
//  TemplateGameClean
//
//  Created by Silvio Fragnani da Silva on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

attribute vec4 position;
attribute vec4 color;
varying lowp vec4 colorVarying;

void main()
{
    gl_Position = position;
    colorVarying = color;
}
