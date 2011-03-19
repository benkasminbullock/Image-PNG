#include <stdlib.h>
#include <stdio.h>
#include <err.h>
#include <png.h>

int main ()
{
    FILE * output;
    png_structp png;
    png_infop info;
    png_byte * row_pointers[10];
    int i;

    for (i = 0; i < 10; i++) {
        int j;
        row_pointers[i] = malloc (11);
        for (j = 0; j < 10; j++) {
            row_pointers[i][j] = 'x' + i * 5 + j * 5;
        }
    }




    png = png_create_write_struct (PNG_LIBPNG_VER_STRING, 0, 0, 0);
    info = png_create_info_struct (png);
    png_set_IHDR (png,
                  info,
                  10,
                  10,
                  8,
                  PNG_COLOR_TYPE_GRAY,
                  PNG_INTERLACE_NONE,
                  PNG_COMPRESSION_TYPE_DEFAULT,
                  PNG_FILTER_TYPE_DEFAULT);
    output = fopen ("write-test.png", "w");
    if (! output) {
        err (1, "fopen output failed");
    }
    png_init_io (png, output);
    png_set_rows (png, info, row_pointers);
    png_write_png (png, info, 0, 0);
    return 0;
}
