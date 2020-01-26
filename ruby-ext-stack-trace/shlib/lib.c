#include <string.h>

void foo(){
    strcpy((void*) -1, (void*) -2);
}
