#ifdef HEADER

/* Fetch a value "field" from a hash. */

#define HASH_FETCH(hash,field)     {                            \
    SV ** field_sv_ptr = hv_fetch (hash, #field,                \
                                   strlen (#field), 0);         \
    if (! field_sv_ptr) {                                       \
        fprintf (stderr, "Field '%s' in '%s' not valid.\n",     \
                 #field, #hash);                                \
    }                                                           \
    field_sv = * field_sv_ptr;                                  \
    }                                                           \

#define HASH_FETCH_IV(hash,field) {                             \
        SV * field_sv;                                          \
        HASH_FETCH (hash, field);                               \
        field = SvIV (field_sv);                                \
    }

/* If "hash" does not contain "field", do not complain but just skip
   that field. */

#define HASH_FETCH_IV_MEMBER(hash,field,str) {                  \
        SV ** field_sv_ptr = hv_fetch (hash, #field,            \
                                       strlen (#field), 0);     \
        if (field_sv_ptr) {                                     \
            SV * field_sv;                                      \
            field_sv = * field_sv_ptr;                          \
            str->field = SvIV (field_sv);                       \
        }                                                       \
    }

#define HASH_FETCH_PV(hash,field) {                             \
        SV * field_sv;                                          \
        HASH_FETCH (hash, field);                               \
        field = SvPV (field_sv, field ## _length);              \
    }


#define HASH_STORE_IV(hash,field)                                       \
    (void) hv_store (hash, #field, strlen (#field), newSViv (field), 0)

#define HASH_STORE_IV_MEMBER(hash,field,str)                            \
    (void) hv_store (hash, #field, strlen (#field), newSViv (str.field), 0)

#endif /* HEADER */
