#
# Quick plotting script, which allows a user to pipe data
# into gnuplot.
#

#
# Default gnuplot settings.
#
# terminal type
term="dumb"
# output file
output=""
# input file
file="-"
# line style
with="with l"
# input columns
using=""
# type of plot (plot, splot)
plot="plot"


#
# Parse user options.
#
cmd=""
while getopts xf:o:e:w:u: flag
do
	case $flag in
		x)
			term="x11"
			;;
		f)
			file="$OPTARG"
			;;
		o)
			term="${OPTARG##*.}"
			output="$OPTARG"
			;;
		e)
			cmd="$OPTARG"
			;;
		w)
			with="with $OPTARG"
			;;
		u)
			using="using $OPTARG"
			;;
		p)
			plot="$OPTARG"
			;;
		?)
			echo "Options:"
			echo "    -x          Plot in x11 window."
			echo "    -f FILE     Read data from FILE."
			echo "    -o FILE     Write output to FILE.  File extension must"
			echo "                match one of gnuplot's supported formats."
			echo "    -e string   Run this gnuplot command instead of default."
			echo "    -w string   Set the line/point style."
			echo "    -u string   Set gnuplot's 'using' string."
			echo "    -p string   Set the plot command (plot,splot)"
			exit
			;;
	esac
done


# If user set the cmd variable, then use it,
# otherwise construct our own.
if [ -z "${cmd}" ]
then
	if [ -z "$output" ]
	then
		cmd="set terminal ${term}; set output; ${plot} \"${file}\" ${using} ${with}"
	else
		cmd="set terminal ${term}; set output \"${output}\"; ${plot} \"${file}\" ${using} ${with}"
	fi
fi

# Do it!
gnuplot -persist -e "$cmd"


