#include <ruby.h>

void Init_foo()
{
    puts("hello world");
    strcpy(-1, -2);
    puts("success");
}
