package LibpngInfo;
require Exporter;
@ISA = qw(Exporter);
@EXPORT_OK = qw/template_vars @chunks/;
use warnings;
use strict;

my @ihdr_fields = (
{
    name => 'width',
    c => 'png_uint_32',
    text => <<EOF,
The width of the image in pixels.
EOF
},
{
    name => 'height',
    c => 'png_uint_32',
    text => <<EOF,
The height of the image in pixels.
EOF
},
{
    name => 'bit_depth',
    c => 'int',
    text => <<EOF,
The bit depth of the image (the number of bits used for each colour in a pixel).
EOF
    retvalues => [1, 2, 4, 8, 16],
},
{
    name => 'color_type',
        c => 'int',
            text => <<EOF,
The colour type.
EOF
    retvalues => [qw/
                    PNG_COLOR_TYPE_GRAY
                    PNG_COLOR_TYPE_GRAY_ALPHA
                    PNG_COLOR_TYPE_PALETTE
                    PNG_COLOR_TYPE_RGB
                    PNG_COLOR_TYPE_RGB_ALPHA
                /],
            }
,
{
    name => 'interlace_method',
    c => 'int',
    text => <<EOF,
The method of interlacing.
EOF
    retvalues => [qw/
                    PNG_INTERLACE_NONE
                    PNG_INTERLACE_ADAM7
                /],
},
{
    name => 'compression_method',
    c => 'int',
    unused => 1,
    retvalues => [qw/
                    PNG_COMPRESSION_TYPE_BASE
                /],
},
{
    name => 'filter_method',
    c => 'int',
    unused => 1,
    retvalues => qw/
                    PNG_FILTER_TYPE_BASE
                /,
},
);

my @unknown_chunk_fields = (
{
    name => 'name',
    c => 'png_byte',
    description => <<EOF,
The name of the unknown chunk, in the PNG chunk format (four bytes).
EOF
},
{
    name => 'location',
    c => 'png_byte',
    description => <<EOF,
The location of the unknown chunk.
EOF
    values => [
    {
        value => 0, 	
        meaning => "do not write the chunk",
    }, {
        value => "PNG_HAVE_IHDR",
        meaning => "insert chunk before PLTE",
    }, {
        value => 'PNG_HAVE_PLTE',	 	
        meaning => 'insert chunk before IDAT',
    }, {
        value => 'PNG_AFTER_IDAT',
        meaning => 'insert chunk after IDAT',
    },
    ],
},
{
    name => 'data',
    c => 'png_bytep',
    description => <<EOF,
The data of the unknown chunk
EOF
},
);

my $input_file = '/usr/local/include/png.h';
my @macros;
my %macros;
{
    local $/;
    open my $input, "<", $input_file;
    my $text = <$input>;
    close $input;
    while ($text =~ /^\#define\s+
                     (PNG_\w+)\s+
                     (
                         (?:0[xX]|-)?
                         [0-9a-fA-F]+|
                         \w+|
                         \(
                         (?:\(png_.*?\))?[^\)]+
                         \)
                     )
                    /gxsm) {
        my ($macro, $value) = ($1, $2);
        $value =~ s/\(png.*\)//;

        # Now we reject constants which aren't necessary for Perl.

        if ($macro =~ /_LAST$/) {
            next;
        }
        if ($macro =~ /_LIBPNG_/) {
            next;
        }
        if ($macro =~ /_MAX$/) {
            next;
        }

        # The following heebie jeebies turns values of the form (X |
        # Y) into numbers like (1 | 4). It also removes newlines and
        # tidies spaces in the values.

        $macros{$macro} = $value;
        for my $k (keys %macros) {
            $value =~ s/\b$k\b/$macros{$k}/g;
        }
        $value =~ s/\\\n//g;
        $value =~ s/\s+/ /g;
        $macros{$macro} = $value;
        push @macros, {macro => $macro, value => $value};
    }
}

my @filter_macros = (qw/
PNG_NO_FILTERS
PNG_FILTER_NONE
PNG_FILTER_SUB
PNG_FILTER_UP
PNG_FILTER_AVG
PNG_FILTER_PAETH
PNG_ALL_FILTERS
/);
my @filters;
for (@filter_macros) {
    push @filters, {macro => $_};
}

# Swiped from http://refspecs.freestandards.org/LSB_3.1.0/LSB-Desktop-generic/LSB-Desktop-generic/libpng12.png.read.png.1.html

my @transforms = (
{
    name => 'PNG_TRANSFORM_IDENTITY',
    text => 'No transformation',
},

{
    name => 'PNG_TRANSFORM_STRIP_16',
    text => 'Strip 16-bit samples to 8 bits',
},

{
    name => 'PNG_TRANSFORM_STRIP_ALPHA',
    text => 'Discard the alpha channel',
},

{
    name => 'PNG_TRANSFORM_PACKING',
    text => 'Expand 1, 2 and 4-bit samples to bytes',
},

{
    name => 'PNG_TRANSFORM_PACKSWAP',
    text => 'Change order of packed pixels to LSB first',
},

{
    name => 'PNG_TRANSFORM_EXPAND',
    text => 'Expand paletted images to RGB, grayscale to 8-bit images and tRNS chunks to alpha channels',
},

{
    name => 'PNG_TRANSFORM_INVERT_MONO',
    text => 'Invert monochrome images',
},

{
    name => 'PNG_TRANSFORM_SHIFT',
    text => 'Normalize pixels to the sBIT depth',
},

{
    name => 'PNG_TRANSFORM_BGR',
    text => 'Flip RGB to BGR, RGBA to BGRA',
},

{
    name => 'PNG_TRANSFORM_SWAP_ALPHA',
    text => 'Flip RGBA to ARGB or GA to AG',
},

{
    name => 'PNG_TRANSFORM_INVERT_ALPHA',
    text => 'Change alpha from opacity to transparency',
},

{
    name => 'PNG_TRANSFORM_SWAP_ENDIAN',
    text => 'Byte-swap 16-bit samples'
},
);


my $png_functions =<<EOF;
png_access_version_number -- return version of the run-time library
png_create_info_struct -- allocate and initialize a png_info structure
png_create_read_struct -- allocate and initialize a png_struct structure for reading PNG file
png_create_write_struct -- allocate and initialize a png_struct structure for writing PNG file
png_destroy_read_struct -- free the memory associated with read png_struct
png_destroy_write_struct -- free the memory associated with write png_struct
png_error -- default function to handle fatal errors
png_free -- free a pointer allocated by png_malloc()
png_get_IHDR -- get PNG_IHDR chunk information from png_info structure
png_get_PLTE -- get image palette information from png_info structure
png_get_bKGD -- get background color for given image
png_get_bit_depth -- return image bit_depth
png_get_cHRM -- get CIE chromacities and referenced white point for given image
png_get_channels -- get number of color channels in image
png_get_color_type -- return image color type
png_get_error_ptr -- return error_ptr for user-defined functions
png_get_gAMA -- get the gamma value for given image
png_get_hIST -- get the histogram for given image
png_get_iCCP -- get the embedded ICC profile data for given image
png_get_image_height -- return image height
png_get_image_width -- return image width
png_get_interlace_type -- returns interlace method
png_get_io_ptr -- return pointer for user-defined I/O
png_get_libpng_ver -- get the library version string
png_get_oFFs -- get screen offsets for the given image
png_get_pHYs -- get the physical resolution for given image
png_get_progressive_ptr -- return pointer to user-defined push read functions
png_get_rowbytes -- Return number of bytes for a row
png_get_rows -- retrieve image data from png_info structure
png_get_sBIT -- get number of significant bits for each color channel
png_get_sRGB -- get the rendering intent for given image
png_get_tIME -- get last modification time for the image
png_get_tRNS -- get transparency data for images
png_get_text -- get comments information from png_info structure
png_get_valid -- determine if given chunk data is valid
png_get_x_offset_pixels -- return x offset in pixels from oFFs chunk
png_get_x_pixels_per_meter -- return horizontal pixel density per meter
png_get_y_offset_pixels -- return y offset in pixels from oFFs chunk
png_get_y_pixels_per_meter -- return vertical pixel density per meter
png_init_io -- initialize input/output for the PNG file
png_malloc -- allocate memory
png_process_data -- read PNG file progressively
png_progressive_combine_row -- combines current row data with processed row
png_read_end -- read the end of PNG file
png_read_image -- read the entire image into memory
png_read_info -- read the PNG image information
png_read_png -- read the entire PNG file
png_read_row -- read a row of image data
png_read_rows -- read multiple rows of image data
png_read_update_info -- update png_info structure
png_set_IHDR -- set the PNG_IHDR chunk information
png_set_PLTE -- set color values for the palette
png_set_bKGD -- set the background color for given image
png_set_background -- set the background for given image
png_set_bgr -- set pixel order to blue, green, red
png_set_cHRM -- set CIE chromacities and referenced white point for given image
png_set_compression_level -- set image compression level
png_set_dither -- turn on dithering to 8-bit
png_set_error_fn -- set user defined functions for error handling
png_set_expand -- set expansion transformation
png_set_filler -- add a filler byte to given image
png_set_filter -- set filtering method
png_set_gAMA -- set the gamma value for given image
png_set_gamma -- transform the image from file gamma to screen gamma
png_set_gray_to_rgb -- expand the grayscale image to 24-bit RGB
png_set_hIST -- set the histogram of color palette
png_set_iCCP -- set ICC component
png_set_interlace_handling -- get the number of passes for image interlacing
png_set_invert_mono -- reverse values for monochromicity
png_set_oFFs -- set screen offsets for given image
png_set_pHYs -- set physical resolution
png_set_packing -- expand image to 1 pixel per byte for bit-depths 1,2 and 4
png_set_packswap -- swap the order of pixels for packed-pixel image
png_set_progressive_read_fn -- set progressive read callback functions
png_set_read_fn -- set user-defined function for reading a PNG stream
png_set_rgb_to_gray -- reduce 24-bit RGB to grayscale image
png_set_rows -- put image data in png_info structure
png_set_sBIT -- set number of significant bits for each channel
png_set_sRGB -- set the rendering intent for given image
png_set_shift --  pixel values to valid bit-depth
png_set_sig_bytes -- number of bytes read from PNG file
png_set_strip_16 -- strip 16 bit PNG file to 8 bit depth
png_set_strip_alpha -- remove alpha channel on the given image
png_set_swap -- swap byte-order for 16 bit depth files
png_set_swap_alpha -- swap image data from RGBA to ARGB format
png_set_tIME -- set last modification time for the image
png_set_tRNS -- set transparency values for images
png_set_text -- stores information for image comments
png_set_write_fn -- set user-defined function for writing a PNG stream
png_sig_cmp -- match the PNG signature
png_warning -- default function to handle non-fatal errors
png_write_chunk -- write a PNG chunk
png_write_end -- write the end of a PNG file
png_write_flush -- flush the current output buffers
png_write_image -- write the given image data
png_write_info -- write PNG information to file
png_write_png -- write the entire PNG file
png_write_row -- write a row of image data
png_write_rows -- write multiple rows of image data
EOF

# Known chunks. Here "in_valid" means the chunk is one of the ones
# which is returned by the libpng routine "png_get_valid".

our @chunks = (
{
    name => 'gAMA',
    in_valid => 1,
    auto_type => 'hv',
},

{
    name => 'sBIT',
    in_valid => 1,
    auto_type => 'hv',
},

{
    name => 'cHRM',
    in_valid => 1,
    auto_type => 'hv',
},

{
    name => 'PLTE',
    in_valid => 1,
    auto_type => 'av',
},

{
    name => 'tRNS',
    in_valid => 1,
    auto_type => 'hv',
},

{
    name => 'bKGD',
    in_valid => 1,
    auto_type => 'hv',
},

{
    name => 'hIST',
    in_valid => 1,
},

{
    name => 'pHYs',
    in_valid => 1,
    auto_type => 'hv',
},

{
    name => 'oFFs',
    in_valid => 1,
    auto_type => 'hv',
},

{
    name => 'tIME',
    in_valid => 1,
    auto_type => 'sv',
},

{
    name => 'pCAL',
    in_valid => 1,
    auto_type => 'hv',
},

{
    name => 'sRGB',
    in_valid => 1,
},

{
    name => 'iCCP',
    in_valid => 1,
    auto_type => 'hv',
},

{
    name => 'sPLT',
    in_valid => 1,
    auto_type => 'hv',
},

{
    name => 'sCAL',
    in_valid => 1,
    auto_type => 'hv',
},

{
    name => 'IDAT',
    in_valid => 1,
},
{
    name => 'tEXt',
    is_text => 1,
},
{
    name => 'zTXt',
    is_text => 1,
},
{
    name => 'iTXt',
    is_text => 1,
},
{
    name => 'IHDR',
    auto_type => 'hv',
},

);

@chunks = sort {(uc $a->{name}) cmp (uc $b->{name})} @chunks;

sub template_vars
{
    my ($vars_ref) = @_;
    $vars_ref->{ihdr_fields} = \@ihdr_fields;
    $vars_ref->{macros} = \@macros;
    $vars_ref->{filters} = \@filters;
    $vars_ref->{transforms} = \@transforms;
    $vars_ref->{chunks} = \@chunks;
    $vars_ref->{unknown_chunk_fields} = \@unknown_chunk_fields;
}

1;
