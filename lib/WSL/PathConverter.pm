package WSL::PathConverter;

use 5.014;
use warnings;

use Cwd qw/abs_path/;

use base "Exporter";

our @EXPORT_OK = qw/
	convertToWin
/;

our $WSL_ROOT_DIR = "C:/Users/nyaap/AppData/Local/lxss/";

sub convertToWin($;$) {
	my $path = shift;
	my $ignore_check = shift;

	$path =~ s/:.*//;
	die "Unexisted path: $path" unless $ignore_check || -e $path;

	my $abs_path = abs_path($path); 
	unless ( $abs_path =~ s@^/mnt/c/@C:/@ ) {
		$abs_path = "$WSL_ROOT_DIR/$abs_path";
	}
	$abs_path =~ s@/@\\@g;
	return $abs_path;
}

1;
