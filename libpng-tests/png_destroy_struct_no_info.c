#include <png.h>

int main ()
{
    png_structp png_ptr;
    png_ptr = png_create_read_struct (PNG_LIBPNG_VER_STRING, 0, 0, 0);
    png_destroy_read_struct (& png_ptr, 0, 0);
    return 0;
}
