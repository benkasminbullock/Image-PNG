#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <png.h>
#include "perl-libpng.h"
#include "const-c.inc"

MODULE = Image::PNG	PACKAGE = Image::PNG::Libpng  PREFIX = perl_png_

PROTOTYPES: ENABLE

INCLUDE: const-xs.inc

Image::PNG::Libpng::t * perl_png_create_read_struct ()
        CODE:
        RETVAL = perl_png_create_read_struct ();
        OUTPUT:
        RETVAL

Image::PNG::Libpng::t * perl_png_create_write_struct ()
        CODE:
        RETVAL = perl_png_create_write_struct ();
        OUTPUT:
        RETVAL

void perl_png_destroy_read_struct (Png)
        Image::PNG::Libpng::t *  Png
        CODE:
        perl_png_destroy_read_struct (Png);
        OUTPUT:

void perl_png_destroy_write_struct (Png)
        Image::PNG::Libpng::t *  Png
        CODE:
        perl_png_destroy_write_struct (Png);
        OUTPUT:

void perl_png_write_png (Png, transforms)
        Image::PNG::Libpng::t *  Png
        int transforms
        CODE:
        png_write_png (Png->png, Png->info, transforms, 0);
        OUTPUT:

void perl_png_init_io (Png, fp)
        Image::PNG::Libpng::t *  Png
        FILE * fp
        CODE:
        png_init_io (Png->png, fp);
        OUTPUT:

void perl_png_read_info (Png)
        Image::PNG::Libpng::t *  Png
        CODE:
        png_read_info (Png->png, Png->info);
        OUTPUT:

void perl_png_read_png (Png, transforms = PNG_TRANSFORM_IDENTITY)
        Image::PNG::Libpng::t *  Png
        int transforms
        CODE:
        png_read_png (Png->png, Png->info, transforms, 0);
        OUTPUT:

int perl_png_get_IHDR (Png, IHDR_ref)
        Image::PNG::Libpng::t *  Png
        HV * IHDR_ref
        CODE:
        int w, h, bit_depth, color_type;
        RETVAL = perl_png_get_IHDR (Png, IHDR_ref);
        OUTPUT:
        RETVAL
        IHDR_ref

int perl_png_get_tIME (Png, time_ref)
        Image::PNG::Libpng::t *  Png
        SV * time_ref
        CODE:
        RETVAL = perl_png_get_time (Png, time_ref);
        OUTPUT:
        RETVAL
        time_ref

int perl_png_get_text (Png, text_ref)
        Image::PNG::Libpng::t *  Png
        SV * text_ref
        CODE:
        RETVAL = perl_png_get_text (Png, text_ref);
        OUTPUT:
        RETVAL
        text_ref

int perl_png_sig_cmp (sig, start = 0, num_to_check = 8)
        SV * sig
        int start
        int num_to_check
        CODE:
        RETVAL = perl_png_sig_cmp (sig, start, num_to_check);
        OUTPUT:
        RETVAL

void perl_png_scalar_as_image (Png, scalar)
        Image::PNG::Libpng::t *  Png
        SV * scalar
        CODE:
        perl_png_scalar_as_image (Png, scalar);
        OUTPUT:

const char * perl_png_color_type_name (color_type)
        int color_type
        CODE:
        RETVAL = perl_png_color_type_name (color_type);
        OUTPUT:
        RETVAL

const char * perl_png_text_compression_name (text_compression)
        int text_compression
        CODE:
        RETVAL = perl_png_text_compression_name (text_compression);
        OUTPUT:
        RETVAL

const char * perl_png_get_libpng_ver ()
        CODE:
        RETVAL = png_get_libpng_ver (0);
        OUTPUT:
        RETVAL

int perl_png_access_version_number ()
        CODE:
        RETVAL = png_access_version_number ();
        OUTPUT:
        RETVAL

AV * perl_png_get_rows (Png)
        Image::PNG::Libpng::t *  Png
        CODE:
        RETVAL = perl_png_get_rows (Png);
        OUTPUT:
        RETVAL

int perl_png_get_rowbytes (Png)
        Image::PNG::Libpng::t *  Png
        CODE:
        RETVAL = png_get_rowbytes (Png->png, Png->info);
        OUTPUT:
        RETVAL

int perl_png_get_PLTE (Png, colors)
        Image::PNG::Libpng::t *  Png
        AV * colors
        CODE:
        RETVAL = perl_png_get_PLTE (Png, colors);
        OUTPUT:
        RETVAL

int perl_png_get_bKGD (Png, background)
        Image::PNG::Libpng::t *  Png
        HV * background
        CODE:
        RETVAL = perl_png_get_bKGD (Png, background);
        OUTPUT:
        RETVAL

int perl_png_get_cHRM (Png, cie_chromacities)
        Image::PNG::Libpng::t *  Png
        HV * cie_chromacities
        CODE:
        RETVAL = perl_png_get_cHRM (Png, cie_chromacities);
        OUTPUT:
        RETVAL
        cie_chromacities

int perl_png_get_channels (Png);
        Image::PNG::Libpng::t * Png
        CODE:
        RETVAL = png_get_channels (Png->png, Png->info);
        OUTPUT:
        RETVAL