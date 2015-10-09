package RemoteImageDriver;
use Mojo::Base 'Mojolicious';

use File::Spec;
use File::Temp qw( tempdir );

# This method will run once at server start
sub startup {
    my $self = shift;

    my $temp_dir = tempdir();
    $self->helper(
        upload_file => sub {
            my $c = shift;

            my $file = $c->req->upload('file');
            my $filename = File::Spec->catfile( $temp_dir, $file->filename );
            $file->move_to($filename);

            my ($suffix) = $file->filename =~ /\.([^\.]+)$/;
            $suffix = lc $suffix;
            $suffix = 'jpeg' if $suffix eq 'jpg';

            ( $filename, $suffix );
        }
    );

    # Router
    my $r = $self->routes;

    # Normal route to controller
    $r->get('/')->to('example#welcome');

    $r->post('scale')->to('driver#scale');
    $r->post('crop_rectangle')->to('driver#crop_rectangle');
    $r->post('flip_horizontal')->to('driver#flip_horizontal');
    $r->post('flip_vertical')->to('driver#flip_vertical');
    $r->post('rotate')->to('driver#rotate');
    $r->post('convert')->to('driver#convert');
}

1;
