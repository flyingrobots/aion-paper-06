$ENV{'TEXINPUTS'} = "../:./:" . ($ENV{'TEXINPUTS'} // '');

# Match Makefile behavior:
# - Put all build artifacts (including PDF) in ../pdf
# - Use the same jobname for the output PDF
$out_dir = "../pdf";
$jobname = "aion-paper-04-observer-geometry";
