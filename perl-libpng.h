/* This is a Cfunctions (version 0.27) generated header file.
   Cfunctions is a free program for extracting headers from C files.
   Get Cfunctions from `http://cfunctions.sourceforge.net/'. */

/* This file was generated with:
`cfunctions -in perl-libpng.c' */
#ifndef CFH_PERL_LIBPNG_H
#define CFH_PERL_LIBPNG_H

/* From `perl-libpng.c': */

#line 10 "perl-libpng.c"
typedef struct perl_libpng {
    png_structp png;
    png_infop info;
    png_infop end_info;
} 

#line 17 "perl-libpng.c"
perl_libpng_t;

#line 19 "perl-libpng.c"
typedef perl_libpng_t Image__PNG__Libpng__t;

#line 47 "perl-libpng.c"
#include "c-extensions.h"
perl_libpng_t * perl_png_create_write_struct PROTO ((void));

#line 56 "perl-libpng.c"
perl_libpng_t * perl_png_create_read_struct PROTO ((void));

#line 64 "perl-libpng.c"
int /* default */perl_png_destroy_write_struct (perl_libpng_t * png );

#line 70 "perl-libpng.c"
int /* default */perl_png_destroy_read_struct (perl_libpng_t * png );

#line 81 "perl-libpng.c"
void perl_png_timep_to_hash (const png_timep mod_time , HV * time_hash );

#line 256 "perl-libpng.c"
int perl_png_get_text (perl_libpng_t * png , SV * text_ref );

#line 290 "perl-libpng.c"
int perl_png_get_time (perl_libpng_t * png , SV * time_ref );

#line 316 "perl-libpng.c"
int perl_png_sig_cmp (SV * png_header , int start , int num_to_check );

#line 364 "perl-libpng.c"
void perl_png_scalar_as_image (perl_libpng_t * png , SV * image_data );

#line 381 "perl-libpng.c"
int perl_png_get_IHDR (perl_libpng_t * png , HV * IHDR_ref );

#line 420 "perl-libpng.c"
const char * perl_png_color_type_name (int color_type );

#line 444 "perl-libpng.c"
const char * perl_png_text_compression_name (int text_compression );

#line 462 "perl-libpng.c"
AV * perl_png_get_rows (perl_libpng_t * png );

#line 522 "perl-libpng.c"
int perl_png_get_PLTE (perl_libpng_t * png , AV * perl_colors );

#line 549 "perl-libpng.c"
int perl_png_get_bKGD (perl_libpng_t * png , HV * background );

#line 555 "perl-libpng.c"
int perl_png_get_cHRM (perl_libpng_t * png , HV * cie_chromacities );

#endif /* CFH_PERL_LIBPNG_H */
