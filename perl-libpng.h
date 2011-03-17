/* This is a Cfunctions (version 0.27) generated header file.
   Cfunctions is a free program for extracting headers from C files.
   Get Cfunctions from `http://cfunctions.sourceforge.net/'. */

/* This file was generated with:
`cfunctions -in perl-libpng.c' */
#ifndef CFH_PERL_LIBPNG_H
#define CFH_PERL_LIBPNG_H

/* From `perl-libpng.c': */

#line 10 "perl-libpng.c"

#line 12 "perl-libpng.c"
typedef png_structp File__PNG__Libpng__Png;

#line 13 "perl-libpng.c"
typedef png_infop File__PNG__Libpng__Info;

#line 37 "perl-libpng.c"
void perl_png_timep_to_hash (const png_timep mod_time , HV * time_hash );

#line 212 "perl-libpng.c"
int perl_png_get_text (png_structp png_ptr , png_infop info_ptr , SV * text_ref );

#line 246 "perl-libpng.c"
int perl_png_get_time (png_structp png_ptr , png_infop info_ptr , SV * time_ref );

#line 272 "perl-libpng.c"
int perl_png_sig_cmp (SV * png_header , int start , int num_to_check );

#line 319 "perl-libpng.c"
void perl_png_scalar_as_image (png_structp png_ptr , SV * image_data );

#line 336 "perl-libpng.c"
int perl_png_get_IHDR (png_structp png_ptr , png_infop info_ptr , HV * IHDR_ref );

#line 375 "perl-libpng.c"
const char * perl_png_color_type_name (int color_type );

#line 399 "perl-libpng.c"
const char * perl_png_text_compression_name (int text_compression );

#line 417 "perl-libpng.c"
AV * perl_png_get_rows (png_structp png_ptr , png_infop info_ptr );

#line 477 "perl-libpng.c"
int perl_png_get_PLTE (png_structp png_ptr , png_infop info_ptr , AV * perl_colors );

#endif /* CFH_PERL_LIBPNG_H */
