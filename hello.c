
#include <stdio.h>

const char * get_hello(void);
const char * get_bye(void);

int main(void)
{

    printf("%s\n", get_hello());
    printf("%s\n", get_bye());

   return 0;
}