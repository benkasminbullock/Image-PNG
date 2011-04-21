/* This is a Cfunctions (version 0.27) generated header file.
   Cfunctions is a free program for extracting headers from C files.
   Get Cfunctions from `http://cfunctions.sourceforge.net/'. */

/* This file was generated with:
`cfunctions -i -n -c my-xs.c' */
#ifndef CFH_MY_XS_H
#define CFH_MY_XS_H

/* From `my-xs.c': */

#line 1 "my-xs.c"
#define HASH_FETCH(hash,field)     {                            \
    SV ** field_sv_ptr = hv_fetch (hash, #field,                \
                                   strlen (#field), 0);         \
    if (! field_sv_ptr) {                                       \
        fprintf (stderr, "Field '%s' in '%s'not valid.\n",      \
                 #field, #hash);                                \
    }                                                           \
    field_sv = * field_sv_ptr;                                  \
    }                                                           \

#define HASH_FETCH_IV(hash,field) {                             \
        SV * field_sv;                                          \
        HASH_FETCH (hash, field);                               \
        field = SvIV (field_sv);                                \
    }
#define HASH_FETCH_PV(hash,field) {                             \
        SV * field_sv;                                          \
        HASH_FETCH (hash, field);                               \
        field = SvPV (field_sv, field ## _length);              \
    }

#endif /* CFH_MY_XS_H */
