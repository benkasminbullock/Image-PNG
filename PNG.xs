#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <png.h>
#include "perl-libpng.h"
#include "const-c.inc"

MODULE = File::PNG		PACKAGE = File::PNG  PREFIX = perl_png_

PROTOTYPES: ENABLE

INCLUDE: const-xs.inc

File::PNG::Png perl_png_create_read_struct ()
        CODE:
        RETVAL = png_create_read_struct (PNG_LIBPNG_VER_STRING, 0, 0, 0);
        OUTPUT:
        RETVAL

File::PNG::Png perl_png_create_write_struct ()
        CODE:
        RETVAL = png_create_write_struct (PNG_LIBPNG_VER_STRING, 0, 0, 0);
        OUTPUT:
        RETVAL

void perl_png_read_png (Png, Info, transforms)
        File::PNG::Png Png
        File::PNG::Info Info
        int transforms
        CODE:
        png_read_png (Png, Info, transforms, 0);
        OUTPUT:

void perl_png_write_png (Png, Info, transforms)
        File::PNG::Png Png
        File::PNG::Info Info
        int transforms
        CODE:
        png_write_png (Png, Info, transforms, 0);
        OUTPUT:

File::PNG::Info perl_png_create_info_struct (Png)
        File::PNG::Png Png
        CODE:
        RETVAL = png_create_info_struct (Png);
        OUTPUT:
        RETVAL

=head2 perl_png_init_io

Send a pointer to a "FILE", "fp", to the "png_read_struct" in Png.

=cut

void perl_png_init_io (Png, fp)
        File::PNG::Png Png
        FILE * fp
        CODE:
        png_init_io (Png, fp);
        OUTPUT:

void perl_png_read_info (Png, Info)
        File::PNG::Png Png
        File::PNG::Info Info
        CODE:
        png_read_info (Png, Info);
        OUTPUT:

int perl_png_get_IHDR (Png, Info, width_ref, height_ref)
        File::PNG::Png Png
        File::PNG::Info Info
        SV * width_ref
        SV * height_ref
        CODE:
        int w, h, bit_depth, color_type;
        RETVAL = png_get_IHDR (Png, Info, & w, & h, & bit_depth, & color_type, 0, 0, 0);
        if (SvROK (width_ref)) {
           SV * width = SvRV (width_ref);
           sv_setnv (width, w);
        }
        if (SvROK (height_ref)) {
           SV * height = SvRV (height_ref);
           sv_setnv (height, w);
        }
        OUTPUT:
        RETVAL
        width_ref
        height_ref

int perl_png_get_tIME (Png, Info, time_ref)
        File::PNG::Png Png
        File::PNG::Info Info
        SV * time_ref
        CODE:
        RETVAL = perl_png_get_time (Png, Info, time_ref);
        OUTPUT:
        RETVAL
        time_ref

int perl_png_get_text (Png, Info, text_ref)
        File::PNG::Png Png
        File::PNG::Info Info
        SV * text_ref
        CODE:
        RETVAL = perl_png_get_text (Png, Info, text_ref);
        OUTPUT:
        RETVAL
        text_ref

void perl_png_destroy_read_struct (Png, Info)
        File::PNG::Png Png
        File::PNG::Info Info
        CODE:
        png_destroy_read_struct (& Png, & Info, 0);
        OUTPUT:

int perl_png_sig_cmp (sig, start = 0, num_to_check = 8)
        SV * sig
        int start
        int num_to_check
        CODE:
        RETVAL = perl_png_sig_cmp (sig, start, num_to_check);
        OUTPUT:
        RETVAL

void perl_png_scalar_as_image (Png, scalar)
        File::PNG::Png Png
        SV * scalar
        CODE:
        perl_png_scalar_as_image (Png, scalar);
        OUTPUT:
