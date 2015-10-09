package RemoteImageDriver::Controller::Driver;
use Mojo::Base 'Mojolicious::Controller';

use RemoteImageDriver::Imager;

sub scale {
    my $c = shift;
    my ( $filename, $suffix ) = $c->upload_file;

    my $width  = $c->param('width');
    my $height = $c->param('height');

    my $driver = RemoteImageDriver::Imager->new( $filename, $suffix );
    my $blob = $driver->scale( width => $width, height => $height );

    $c->render( data => $blob, format => $suffix );
}

sub crop_rectangle {
    my $c = shift;
    my ( $filename, $suffix ) = $c->upload_file;

    my $left = $c->param('left') || 0;
    my $top  = $c->param('top')  || 0;
    my $width  = $c->param('width');
    my $height = $c->param('height');

    my $driver = RemoteImageDriver::Imager->new( $filename, $suffix );
    my $blob = $driver->crop_rectangle(
        left   => $left,
        top    => $top,
        width  => $width,
        height => $height,
    );

    $c->render( data => $blob, format => $suffix );
}

sub flip_horizontal {
    my $c = shift;
    my ( $filename, $suffix ) = $c->upload_file;

    my $driver = RemoteImageDriver::Imager->new( $filename, $suffix );
    my $blob = $driver->flip_hozontal;

    $c->render( data => $blob, format => $suffix );
}

sub flip_vertical {
    my $c = shift;
    my ( $filename, $suffix ) = $c->upload_file;

    my $driver = RemoteImageDriver::Imager->new( $filename, $suffix );
    my $blob = $driver->flip_vertical;

    $c->render( data => $blob, format => $suffix );
}

sub rotate {
    my $c = shift;
    my ( $filename, $suffix ) = $c->upload_file;

    my $degrees = $c->param('degrees');
    $degrees %= 360;

    my $driver = RemoteImageDriver::Imager->new( $filename, $suffix );
    my $blob = $driver->rotate( degrees => $degrees );

    $c->render( data => $blob, format => $suffix );
}

sub convert {
    my $c = shift;
    my ( $filename, $suffix ) = $c->upload_file;

    my $type = $c->param('type');

    my $driver = RemoteImageDriver::Imager->new( $filename, $suffix );
    my $blob = $driver->convert( type => $type );

    $c->render( data => $blob, format => $type );
}

1;

