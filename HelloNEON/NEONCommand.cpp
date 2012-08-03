//
//  NEONCommand.cpp
//  HelloNEON
//
//  Created by Silvio Fragnani da Silva on 01/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#include "NEONCommand.h"

#ifdef _ARM_ARCH_7
    #include <arm_neon.h>
#endif


#ifdef _ARM_ARCH_7
void add3 (uint8x16_t *data) {
    // Set each sixteen values of the vector to 3.
    //
    // Remark: a 'q' suffix to intrinsics indicates
    // the instruction run for 128 bits registers.
    //
    uint8x16_t three = vmovq_n_u8 (3);
    
    // Add 3 to the value given in argument. 
    *data = vaddq_u8 (*data, three);
}

void print_uint8 (uint8x16_t data, const char* name) {
    int i;
    static uint8_t p[16];
    
    vst1q_u8 (p, data);
    
    printf ("%s = ", name);
    for (i = 0; i < 16; i++) {
        printf ("%02d ", p[i]);
    }
    printf ("\n");
}

void NEONCommand::executeNEON()
{
    // Create custom arbitrary data. 
    const uint8_t uint8_data[] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 };
    
    // Create the vector with our data. 
    uint8x16_t data;
    
    // Load our custom data into the vector register. 
    data = vld1q_u8 (uint8_data);
    
    print_uint8(data, "data");
    
    // Call of the add3 function. 
    add3(&data);
    
    print_uint8 (data, "data (new)");
}

#endif

