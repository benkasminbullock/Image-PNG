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
typedef png_structp File__PNG__Png;

#line 13 "perl-libpng.c"
typedef png_infop File__PNG__Info;

#line 37 "perl-libpng.c"
void perl_png_timep_to_hash (const png_timep mod_time , HV * time_hash );

#line 202 "perl-libpng.c"
int perl_png_get_text (png_structp png_ptr , png_infop info_ptr , SV * text_ref );

#line 236 "perl-libpng.c"
int perl_png_get_time (png_structp png_ptr , png_infop info_ptr , SV * time_ref );

#line 262 "perl-libpng.c"
int perl_png_sig_cmp (SV * png_header , int start , int num_to_check );

#line 309 "perl-libpng.c"
void perl_png_scalar_as_image (png_structp png_ptr , SV * image_data );

#line 326 "perl-libpng.c"
int perl_png_get_IHDR (png_structp png_ptr , png_infop info_ptr , HV * IHDR_ref );

#endif /* CFH_PERL_LIBPNG_H */
