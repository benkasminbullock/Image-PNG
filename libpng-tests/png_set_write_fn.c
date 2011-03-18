#include <stdio.h>
#include <err.h>
#include <png.h>

int main ()
{
    FILE * input;
    FILE * output;
    png_structp png;
    png_structp png_out;
    png_infop info;
    png_infop info_out;
    png_bytepp row_pointers;
    png_colorp palette;
    int num_palette;
    int color_type;

    png = png_create_read_struct (PNG_LIBPNG_VER_STRING, 0, 0, 0);
    info = png_create_info_struct (png);
    input = fopen ("../t/tantei-san.png", "r");
    if (! input) {
        err (1, "fopen failed");
    }
    png_init_io (png, input);
    png_read_png (png, info, 0, 0);
    fclose (input);
    row_pointers = png_get_rows (png, info);
    color_type = png_get_color_type (png, info);
    png_get_PLTE (png, info, & palette, & num_palette);
    output = fopen ("tantei-san.png", "w");
    if (! output) {
        err (1, "fopen output failed");
    }
    png_out = png_create_write_struct (PNG_LIBPNG_VER_STRING, 0, 0, 0);
    info_out = png_create_info_struct (png_out);
    row_pointers = png_get_rows (png, info);
    png_set_IHDR (png_out,
                  info_out,
                  png_get_image_width (png, info),
                  png_get_image_height (png, info),
                  png_get_bit_depth (png, info),
                  PNG_COLOR_TYPE_GRAY,
                  png_get_interlace_type (png, info),
                  PNG_COMPRESSION_TYPE_DEFAULT,
                  PNG_FILTER_TYPE_DEFAULT);
    if (0) {
    png_set_PLTE (png_out, info_out, palette, num_palette);
    }
    png_init_io (png_out, output);
    png_set_rows (png_out, info_out, row_pointers);
    png_write_png (png_out, info_out, 0, 0);
    return 0;
}
