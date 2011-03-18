libpngldflags=`pkg-config --libs libpng`
libpngcflags=`pkg-config --cflags libpng`
CFLAGS=-g -Wall

png_set_write_fn:	png_set_write_fn.c
	$(CC) $(CFLAGS) $(libpngcflags) -o $@ png_set_write_fn.c $(libpngldflags)

png_destroy_struct_no_info:	png_destroy_struct_no_info.c
	$(CC) $(CFLAGS) $(libpngcflags) -o $@ png_destroy_struct_no_info.c $(libpngldflags)


