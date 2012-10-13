#
#===============================================================================
#
#         FILE: MsfFetch.pm
#
#  DESCRIPTION: Download exploit from the Metasploit Database by fullname
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

package Protosho::Commands::MsfFetch;
use Modern::Perl;
use base qw( CLI::Framework::Command );
use Data::Printer colored => 1;

#===  FUNCTION  ================================================================
#         NAME: run
#      PURPOSE: Main run loop of the MsfFetch object.
#   PARAMETERS: N/A
#      RETURNS: ????
#  DESCRIPTION: ????
#       THROWS: no exceptions
#     COMMENTS: none
#     SEE ALSO: n/a
#===============================================================================
sub run {
    my ( $self, $opts, @args ) = @_;

	my $api = $self->cache->get( 'api' );

#-------------------------------------------------------------------------------
#  Search for MSF fullname, parse the results, and pass them to 
#  msf_download.
#-------------------------------------------------------------------------------
    my $result   = $api->msf_search( '', { fullname => 
			$opts->{'fullname'} } );
    my @matches  = @{ $result->{'matches'} };
    my $exploit  = $matches[0];
    my $download = $api->msf_download( $exploit->{'fullname'} );

#-------------------------------------------------------------------------------
#  Basic error checking.
#-------------------------------------------------------------------------------
    if ( $result->{'error'} ) {
        print "Error: " . $result->{'error'} . "\n";
    }
    else {
        p $download;
    }
    return;
}

#===  FUNCTION  ================================================================
#         NAME: option_spec
#      PURPOSE: Define option specifications
#   PARAMETERS: N/A
#      RETURNS: ????
#  DESCRIPTION: ????
#       THROWS: no exceptions
#     COMMENTS: none
#     SEE ALSO: n/a
#===============================================================================
sub option_spec {
    {
        [ 'fullname=s' => 'Metasploit fullname' ],
    }
}

#===  FUNCTION  ================================================================
#         NAME: validate
#      PURPOSE: Validate incoming (user-provided) command line optons.
#   PARAMETERS: N/A
#      RETURNS: ????
#  DESCRIPTION: ????
#       THROWS: no exceptions
#     COMMENTS: none
#     SEE ALSO: n/a
#===============================================================================
sub validate {
    my ( $self, $opts, @args ) = @_;
    die "Metasploit fullname Required" unless $opts->{'fullname'};
}

1;
