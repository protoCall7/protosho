#
#===============================================================================
#
#         FILE: Search.pm
#
#  DESCRIPTION:
#
#        FILES: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Peter H. Ezetta (PE), peter.ezetta@zonarsystems.com
# ORGANIZATION:
#      VERSION: 1.0
#      CREATED: 10/12/2012 00:24:42
#     REVISION: ---
#===============================================================================

package Protosho::Commands::Search;
use Modern::Perl;
use base qw( CLI::Framework::Command );
use Data::Printer colored => 1;

sub run {
    my ( $self, $opts, @args ) = @_;

	my $api = $self->cache->get( 'api' );

    my $result = $api->search( $opts->{'search'} );

    # Check for errors
    if ( $result->{'error'} ) {
        print "Error: " . $result->{'error'} . "\n";
    }
    else {
        p $result;
    }
    return;
}

sub option_spec {
    {
        [ 'search|s=s' => 'Search Term' ],
    }
}

sub validate {
    my ( $self, $opts, @args ) = @_;
    die "Search Term Required" unless $opts->{'search'};
}

1;
