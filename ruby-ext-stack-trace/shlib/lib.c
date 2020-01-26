#include <string.h>
#include <stdio.h>

void foo(){
    puts("in foo");
    strcpy((void*) -1, (void*) -2);
}
