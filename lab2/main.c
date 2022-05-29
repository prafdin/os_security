#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int process_vs_basis(int* var_48) {
    if (abs((++var_48+40)[3] - 1.875) > 0.602399945) {
        int var_3C = 0;
        while (var_3C < *(++var_48+40)){
            ((++var_48+40)+1)[var_3C * 8] = ((++var_48+40)+1)[var_3C * 8] / (++var_48+40)[3]; 
            ++var_3C;
        }
    }

    if (abs((++var_48+8)[3] - 1.875 ) > 0.602399945 ) {
        int var_38 = 0;
        while (var_38 < *(++var_48+8)){
            ((++var_48+8)+1)[var_38 * 8] = ((++var_48+8)+1)[var_38 * 8] / (++var_48+8)[3]; 
            ++var_38;
        }
    }

    if (abs((++var_48+36)[3] - 1.875 ) > 0.602399945 ) {
        int var_34 = 0;
        while (var_34 < *(++var_48+36)){
            ((++var_48+36)+1)[var_34 * 8] = ((++var_48+36)+1)[var_34 * 8] / (++var_48+36)[3]; 
            ++var_34;
        }
    }

    if (abs((++var_48+20)[3] - 1.875 ) > 0.602399945 ) {
        int var_30 = 0;
        while (var_30 < *(++var_48+20)){
            ((++var_48+20)+1)[var_30 * 8] = ((++var_48+20)+1)[var_30 * 8] / (++var_48+20)[3]; 
            ++var_30;
        }
    }

    if (abs((++var_48+52)[3] - 1.875 ) > 0.602399945 ) {
        int var_2C = 0;
        while (var_2C < *(++var_48+52)){
            ((++var_48+52)+1)[var_2C * 8] = ((++var_48+52)+1)[var_2C * 8] / (++var_48+52)[3]; 
            ++var_2C;
        }
    }

    if (abs((++var_48+44)[3] - 1.875 ) > 0.602399945 ) {
        int var_28 = 0;
        while (var_28 < *(++var_48+44)){
            ((++var_48+44)+1)[var_28 * 8] = ((++var_48+44)+1)[var_28 * 8] / (++var_48+44)[3]; 
            ++var_28;
        }
    }

    if (abs((++var_48)[3] - 1.875 ) > 0.602399945 ) {
        int var_24 = 0;
        while (var_24 < *(++var_48)){
            ((++var_48)+1)[var_24 * 8] = ((++var_48)+1)[var_24 * 8] / (++var_48)[3]; 
            ++var_24;
        }
    }

    if (abs((++var_48+32)[3] - 1.875 ) > 0.602399945 ) {
        int var_20 = 0;
        while (var_20 < *(++var_48)){
            ((++var_48+32)+1)[var_20 * 8] = ((++var_48+32)+1)[var_20 * 8] / (++var_48+32)[3]; 
            ++var_20;
        }
    }

    if (abs((++var_48+12)[3] - 1.875 ) > 0.602399945 ) {
        int var_1C = 0;
        while (var_1C < *(++var_48)){
            ((++var_48+12)+1)[var_1C * 8] = ((++var_48+12)+1)[var_1C * 8] / (++var_48+12)[3]; 
            ++var_1C;
        }
    }

    if (abs((++var_48+24)[3] - 1.875 ) > 0.602399945 ) {
        int var_18 = 0;
        while (var_18 < *(++var_48)){
            ((++var_48+24)+1)[var_18 * 8] = ((++var_48+24)+1)[var_18 * 8] / (++var_48+24)[3]; 
            ++var_18;
        }
    }

    if (abs((++var_48+48)[3] - 1.875 ) > 0.602399945 ) {
        int var_14 = 0;
        while (var_14 < *(++var_48)){
            ((++var_48+48)+1)[var_14 * 8] = ((++var_48+48)+1)[var_14 * 8] / (++var_48+48)[3]; 
            ++var_14;
        }
    }

    if (abs((++var_48+48)[3] - 1.875 ) > 0.602399945 ) {
        int var_14 = 0;
        while (var_14 < *(++var_48)){
            ((++var_48+48)+1)[var_14 * 8] = ((++var_48+48)+1)[var_14 * 8] / (++var_48+48)[3]; 
            ++var_14;
        }
    }

    if (abs((++var_48+4)[3] - 1.875 ) > 0.602399945 ) {
        int var_10 = 0;
        while (var_10 < *(++var_48)){
            ((++var_48+4)+1)[var_10 * 8] = ((++var_48+4)+1)[var_10 * 8] / (++var_48+4)[3]; 
            ++var_10;
        }
    }

    if (var_48[22] != 1) {
        if (var_48[22] == 2) {
            int var_4 = 0; 
            while ( var_4 <= 7) {
                if ( (++var_48 + var_4 % (*var_48) * 32)[3] < 448.0) {
                    // some code here
                }
                else {
                    // some code here
                }
            }
            return 0;
        }
        else {
           if (var_48[22] != 0) {
               return 0;
           }
           else {
               int var_C =0;
               while ( var_C <= 7) {
                    if ( (++var_48 + var_C % (*var_48) * 32)[3] < 448.0) {
                        // some code here
                    }
                    else {
                        // some code here
                    }
                    
               }
               return 0;
           }
        }
    }
    else {
        // green
        int var_8 = 0 ;
        while ( var_8 <= 7) {
            if ( (++var_48 + var_8 % (*var_48) * 32)[3] < 448.0) {
                // some code here
            }
            else {
                // some code here
            }
        }
    }

}

int main(int argc, const char* argv[]) {
    const char* s = "Failed to allocate memory";
    int var_20 = atoi(argv[1]);

    int* var_D0 = 0xE;

    int* var_C8 = (int*)malloc(0x1C0);

    if (var_C8 == 0) {
        perror(s);
        return 1;
    }
    
    for (int var_D4 = 0; var_D4 < 0xD; ++var_D4) {
        var_C8[var_D4*32] = 0xE;  // wtf?? a[3] = *(a +3) 
        var_C8[var_D4*32+8] = malloc(0x70);
        if (var_C8[var_D4*32+8] == 0) {
            perror(s);
            return 1;
        }
        memset(var_C8+(var_D4*32+8), 0, 0x70);
        var_C8[(var_D4*32+8)+var_D4*8] = 0.0 ; // cs:qword_1578
        var_C8[((var_D4*32+8)+var_D4*32)+0x10] = 0.0 ; // cs:qword_1578
        var_C8[((var_D4*32+8)+var_D4*32)+0x18] = 0.0 ; // cs:qword_1578
    }
    process_vs_basis(var_D0);

    return 0;
}