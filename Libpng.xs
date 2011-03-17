#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <png.h>
#include "perl-libpng.h"
#include "const-c.inc"

MODULE = File::PNG::Libpng	PACKAGE = File::PNG  PREFIX = perl_png_

PROTOTYPES: ENABLE

INCLUDE: const-xs.inc

File::PNG::Libpng::Png perl_png_create_read_struct ()
        CODE:
        RETVAL = png_create_read_struct (PNG_LIBPNG_VER_STRING, 0, 0, 0);
        OUTPUT:
        RETVAL

File::PNG::Libpng::Png perl_png_create_write_struct ()
        CODE:
        RETVAL = png_create_write_struct (PNG_LIBPNG_VER_STRING, 0, 0, 0);
        OUTPUT:
        RETVAL

void perl_png_destroy_read_struct (Png, Info = 0, EndInfo = 0)
        File::PNG::Libpng::Png Png
        File::PNG::Libpng::Info Info
        File::PNG::Libpng::Info EndInfo
        CODE:
        png_destroy_read_struct (& Png, & Info, & EndInfo);
        OUTPUT:

void perl_png_destroy_write_struct (Png, Info = 0)
        File::PNG::Libpng::Png Png
        File::PNG::Libpng::Info Info
        CODE:
        png_destroy_write_struct (& Png, & Info);
        OUTPUT:

void perl_png_write_png (Png, Info, transforms)
        File::PNG::Libpng::Png Png
        File::PNG::Libpng::Info Info
        int transforms
        CODE:
        png_write_png (Png, Info, transforms, 0);
        OUTPUT:

File::PNG::Libpng::Info perl_png_create_info_struct (Png)
        File::PNG::Libpng::Png Png
        CODE:
        RETVAL = png_create_info_struct (Png);
        OUTPUT:
        RETVAL

void perl_png_init_io (Png, fp)
        File::PNG::Libpng::Png Png
        FILE * fp
        CODE:
        png_init_io (Png, fp);
        OUTPUT:

void perl_png_read_info (Png, Info)
        File::PNG::Libpng::Png Png
        File::PNG::Libpng::Info Info
        CODE:
        png_read_info (Png, Info);
        OUTPUT:

void perl_png_read_png (Png, Info, transforms = PNG_TRANSFORM_IDENTITY)
        File::PNG::Libpng::Png Png
        File::PNG::Libpng::Info Info
        int transforms
        CODE:
        png_read_png (Png, Info, transforms, 0);
        OUTPUT:

int perl_png_get_IHDR (Png, Info, IHDR_ref)
        File::PNG::Libpng::Png Png
        File::PNG::Libpng::Info Info
        HV * IHDR_ref
        CODE:
        int w, h, bit_depth, color_type;
        RETVAL = perl_png_get_IHDR (Png, Info, IHDR_ref);
        OUTPUT:
        RETVAL
        IHDR_ref

int perl_png_get_tIME (Png, Info, time_ref)
        File::PNG::Libpng::Png Png
        File::PNG::Libpng::Info Info
        SV * time_ref
        CODE:
        RETVAL = perl_png_get_time (Png, Info, time_ref);
        OUTPUT:
        RETVAL
        time_ref

int perl_png_get_text (Png, Info, text_ref)
        File::PNG::Libpng::Png Png
        File::PNG::Libpng::Info Info
        SV * text_ref
        CODE:
        RETVAL = perl_png_get_text (Png, Info, text_ref);
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
        File::PNG::Libpng::Png Png
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

AV * perl_png_get_rows (Png, Info)
        File::PNG::Libpng::Png Png
        File::PNG::Libpng::Info Info
        CODE:
        RETVAL = perl_png_get_rows (Png, Info);
        OUTPUT:
        RETVAL

int perl_png_get_rowbytes (Png, Info)
        File::PNG::Libpng::Png Png
        File::PNG::Libpng::Info Info
        CODE:
        RETVAL = png_get_rowbytes (Png, Info);
        OUTPUT:
        RETVAL

int perl_png_get_PLTE (Png, Info, colors)
        File::PNG::Libpng::Png Png
        File::PNG::Libpng::Info Info
        AV * colors
        CODE:
        RETVAL = perl_png_get_PLTE (Png, Info, colors);
        OUTPUT:
        RETVAL
