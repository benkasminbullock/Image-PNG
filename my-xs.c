#ifdef HEADER

/* Fetch a value "field" from a hash. */

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

#endif /* HEADER */
