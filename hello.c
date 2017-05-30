#include <stdlib.h>
#include <stdio.h>
#include <dlfcn.h>

const char * get_bye(void);

int main(void)
{
   void *lib_handle;
   const char * (*fn)(void);
   char *error;


   lib_handle = dlopen("/opt/lib/libhello.so", RTLD_LAZY);

   if (!lib_handle)
   {
      fprintf(stderr, "%s\n", dlerror());
      exit(1);
   }

   fn = dlsym(lib_handle, "get_hello");

   if ((error = dlerror()) != NULL)
   {
      fprintf(stderr, "%s\n", error);
      exit(1);
   }

   printf("%s\n", fn() );

   dlclose(lib_handle);

   printf("%s\n", get_bye());

   return 0;
}