/* This is a Cfunctions (version 0.27) generated header file.
   Cfunctions is a free program for extracting headers from C files.
   Get Cfunctions from `http://cfunctions.sourceforge.net/'. */

/* This file was generated with:
`cfunctions -i -n -c perl-libpng.c' */
#ifndef CFH_PERL_LIBPNG_H
#define CFH_PERL_LIBPNG_H

/* From `perl-libpng.c': */

#line 10 "perl-libpng.c"
typedef struct perl_libpng {
    png_structp png;
    png_infop info;
    png_infop end_info;
    void * row_pointers;
} 

#line 18 "perl-libpng.c"
perl_libpng_t;

#line 20 "perl-libpng.c"
typedef perl_libpng_t Image__PNG__Libpng__t;

#line 50 "perl-libpng.c"
#line 1 "/home/ben/software/install/share/cfunctions/c-extensions.h"
/* Macro definitions for C extensions for Cfunctions. */

/* 
   Copyright (C) 1998 Ben K. Bullock.

   This header file is free software; Ben K. Bullock gives unlimited
   permission to copy, modify and distribute it. 

   This header file is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
*/


#ifndef C_EXTENSIONS_H
#define C_EXTENSIONS_H

/* Only modern GNU C's have `__attribute__'.  The keyword `inline'
   seems to have been around since the beginning, but it does not work
   with the `-ansi' option, which defines `__STRICT_ANSI__'.  I expect
   that `__attribute__' does not work with `-ansi' either.  Anyway
   both of these failure cases are being lumped together here for the
   sake of brevity. */

#if defined (__GNUC__) && ( __GNUC__ >= 2 ) && ( __GNUC_MINOR__ > 4 ) && \
   ! defined (__STRICT_ANSI__)

/* Macro definitions for Gnu C extensions to C. */

#define X_NO_RETURN __attribute__((noreturn))
#define X_PRINT_FORMAT(a,b) __attribute__((format(printf,a,b)))
#define X_CONST __attribute__((const))
#define X_INLINE

#else /* Not a modern GNU C */

#define X_NO_RETURN 
#define X_PRINT_FORMAT(a,b) 
#define X_CONST

#endif /* GNU C */

/* The following `#define' is not a mistake.  INLINE is defined to
   nothing for both GNU and non-GNU compilers.  When Cfunctions sees
   `INLINE' it copies the whole of the function into the header file,
   prefixed with `extern inline' and surrounded by an `#ifdef
   X_INLINE' wrapper.  In order to inline the function in GNU C, only
   `X_INLINE' needs to be defined. There is also a normal prototype
   for the case that X_INLINE is not defined.  The reason for copying
   the function with a prefix `extern inline' into the header file is
   explained in the GNU C manual and the Cfunctions manual. */

#define INLINE
#define NO_RETURN void
#define NO_SIDE_FX
#define PRINT_FORMAT(a,b)
#define LOCAL

/* Prototype macro for `traditional C' output. */

#ifndef PROTO
#if defined(__STDC__) && __STDC__ == 1
#define PROTO(a) a
#else
#define PROTO(a) ()
#endif /* __STDC__ */
#endif /* PROTO */

#endif /* ndef C_EXTENSIONS_H */
perl_libpng_t * perl_png_create_write_struct PROTO ((void));

#line 61 "perl-libpng.c"
perl_libpng_t * perl_png_create_read_struct PROTO ((void));

#line 70 "perl-libpng.c"
int /* default */perl_png_destroy_write_struct (perl_libpng_t * png );

#line 79 "perl-libpng.c"
int /* default */perl_png_destroy_read_struct (perl_libpng_t * png );

#line 90 "perl-libpng.c"
void perl_png_timep_to_hash (const png_timep mod_time , HV * time_hash );

#line 265 "perl-libpng.c"
int perl_png_get_text (perl_libpng_t * png , SV * text_ref );

#line 299 "perl-libpng.c"
int perl_png_get_time (perl_libpng_t * png , SV * time_ref );

#line 325 "perl-libpng.c"
int perl_png_sig_cmp (SV * png_header , int start , int num_to_check );

#line 373 "perl-libpng.c"
void perl_png_scalar_as_image (perl_libpng_t * png , SV * image_data );

#line 390 "perl-libpng.c"
HV * perl_png_get_IHDR (perl_libpng_t * png );

#line 432 "perl-libpng.c"
const char * perl_png_color_type_name (int color_type );

#line 456 "perl-libpng.c"
const char * perl_png_text_compression_name (int text_compression );

#line 474 "perl-libpng.c"
AV * perl_png_get_rows (perl_libpng_t * png );

#line 534 "perl-libpng.c"
int perl_png_get_PLTE (perl_libpng_t * png , AV * perl_colors );

#line 580 "perl-libpng.c"
HV * perl_png_get_bKGD (perl_libpng_t * png );

#line 591 "perl-libpng.c"
HV * perl_png_get_cHRM (perl_libpng_t * png );

#line 601 "perl-libpng.c"
HV * perl_png_get_sBIT (perl_libpng_t * png );

#line 611 "perl-libpng.c"
HV * perl_png_get_oFFs (perl_libpng_t * png );

#line 622 "perl-libpng.c"
HV * perl_png_get_pHYs (perl_libpng_t * png );

#line 633 "perl-libpng.c"
int perl_png_get_sRGB (perl_libpng_t * png );

#line 645 "perl-libpng.c"
HV * perl_png_get_valid (perl_libpng_t * png );

#line 677 "perl-libpng.c"
void perl_png_set_rows (perl_libpng_t * png , AV * rows );

#line 709 "perl-libpng.c"
void perl_png_set_IHDR (perl_libpng_t * png , HV * IHDR );

#endif /* CFH_PERL_LIBPNG_H */
