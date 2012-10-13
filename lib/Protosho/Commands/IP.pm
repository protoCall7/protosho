#
#===============================================================================
#
#         FILE: IP.pm
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

package Protosho::Commands::IP;
use Modern::Perl;
use base qw( CLI::Framework::Command );
use Data::Printer colored => 1;

#===  FUNCTION  ================================================================
#         NAME: run
#      PURPOSE: Main run loop of IP object.
#   PARAMETERS: ????
#      RETURNS: ????
#  DESCRIPTION: ????
#       THROWS: no exceptions
#     COMMENTS: none
#     SEE ALSO: n/a
#===============================================================================
sub run {
    my ( $self, $opts, @args ) = @_;

	my $api = $self->cache->get( 'api' );

    my $result = $api->host( $opts->{'ip'} );

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
        [ 'ip=s' => 'IP address to search' ],
    }
}

sub validate {
    my ( $self, $opts, @args ) = @_;
    die "IP address required" unless $opts->{'ip'};
}

1;
