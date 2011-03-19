libpngldflags=`pkg-config --libs libpng`
libpngcflags=`pkg-config --cflags libpng`
CFLAGS=-g -Wall

write-test:	write-test.c
	$(CC) $(CFLAGS) $(libpngcflags) -o $@ write-test.c $(libpngldflags)

png_set_write_fn:	png_set_write_fn.c
	$(CC) $(CFLAGS) $(libpngcflags) -o $@ png_set_write_fn.c $(libpngldflags)

png_destroy_struct_no_info:	png_destroy_struct_no_info.c
	$(CC) $(CFLAGS) $(libpngcflags) -o $@ png_destroy_struct_no_info.c $(libpngldflags)


