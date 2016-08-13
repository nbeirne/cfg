# todo:
#   distinction from when popup last happened
#   make 'pipe' bar name changable
#   make 'pipe' bar item changable 
#   follow multiple buffers / have multiple bars
#   fix hide

@bar_lines = ();
@bar_lines_time = ();
# Replicate info earlier for in-client help

# Bar item build
sub pipe_bar_build
{
	# Get max lines
	$max_lines = weechat::config_get_plugin("bar_lines");
	$max_lines = $max_lines ? $max_lines : 10;
	$str = '';
	$align_num = 0;
	$count = 0;
	# Keep lines within max
	while ($#bar_lines > $max_lines)
	{
		shift(@bar_lines);
        #shift(@bar_lines_time);
	}
	# So long as we have some lines, build a string
	if (@bar_lines)
	{
		# Build loop
        $sep = " ".weechat::config_string(weechat::config_get("weechat.look.prefix_suffix"))." ";
        foreach(@bar_lines)
        {
			# Find max align needed
        	$prefix_num = (index(weechat::string_remove_color($_, ""), $sep));
            $align_num = $prefix_num if ($prefix_num > $align_num);
        }
		foreach(@bar_lines)
		{
			# Get align for this line
            $prefix_num = (index(weechat::string_remove_color($_, ""), $sep));

			# Make string
        	$str = $str.$bar_lines_time[$count]." ".(" " x ($align_num - $prefix_num)).$_."\n";
			# Increment count for sync with time list
			$count++;
		}
	}
	return $str;
}

# Make a new bar
sub pipe_bar_open
{
	# Make the bar item
	weechat::bar_item_new("pipe", "pipe_bar_build", "");

	$pipe = weechat::bar_new ("pipe", "off", 100, "root", "", "bottom", "vertical", "vertical", 0, 0, "default", "cyan", "default", "on", "pipe");

	return weechat::WEECHAT_RC_OK;
}


# Check config elements
sub pipe_config_init
{
    # Output bar lines default
    if (!(weechat::config_is_set_plugin ("bar_lines")))
    {
        weechat::config_set_plugin("bar_lines", "10");
    }

    if (!(weechat::config_is_set_plugin ("bar_scrolldown")))
    {
        weechat::config_set_plugin("bar_scrolldown", "off");
    }

    if (!(weechat::config_is_set_plugin("use_popup"))) 
    {
        weechat::config_set_plugin("use_popup", "off");
    }

    if (!(weechat::config_is_set_plugin("popup_timeout"))) 
    {
        weechat::config_set_plugin("popup_timeout", "5");
    }
}

# Set up weechat hooks / commands
sub pipe_hook
{
    weechat::hook_print("", "", "", 0, "pipe_new_message", "");
}

# Main body, Callback for hook_print
sub pipe_new_message
{
	my $net = "";
	my $chan = "";
	my $nick = "";
	my $outstr = "";
	my $window_displayed = "";
	my $dyncheck = "0";

#	DEBUG point
#	$string = "\t"."0: ".$_[0]." 1: ".$_[1]." 2: ".$_[2]." 3: ".$_[3]." 4: ".$_[4]." 5: ".$_[5]." 6: ".$_[6]." 7: ".$_[7];
#	weechat::print("", "\t".$string);

	$cb_datap = $_[0];
	$cb_bufferp = $_[1];
	$cb_date = $_[2];
	$cb_tags = $_[3];
	$cb_disp = $_[4];
	$cb_high = $_[5];
	$cb_prefix = $_[6];
	$cb_msg = $_[7];
    
    $bname = weechat::buffer_get_string($cb_bufferp, 'plugin').".".weechat::buffer_get_string($cb_bufferp, 'name');
    if ($bname eq 'perl.highmon') {
        $msg = $cb_msg;
        pipe_print ($msg, $cb_prefix, $cb_date);
    }

	return weechat::WEECHAT_RC_OK;
}

# Output formatter and printer takes (msg bufpointer nick)
sub pipe_print
{
	$cb_msg = $_[0];
    $nick = $_[1] if ($_[1]);
    $date = $_[2] if ($_[2]);

    $msg = $nick."\t".$cb_msg;

        # Add time string
		use POSIX qw(strftime);
		if ($cb_date)
		{
			$time = strftime(weechat::config_string(weechat::config_get("weechat.look.buffer_time_format")), localtime($cb_date));
		}
		else
		{
			$time = strftime(weechat::config_string(weechat::config_get("weechat.look.buffer_time_format")), localtime);
		}
		# Colourise
		if ($time =~ /\$\{(?:color:)?[\w,]+\}/) # Coloured string
		{
			while ($time =~ /\$\{(?:color:)?([\w,]+)\}/)
			{
				$color = weechat::color($1);
				$time =~ s/\$\{(?:color:)?[\w,]+\}/$color/;
			}
			$time .= weechat::color("reset");
		}
		else # Default string
		{
			$colour = weechat::color(weechat::config_string(weechat::config_get("weechat.color.chat_time_delimiters")));
			$reset = weechat::color("reset");
			$time =~ s/(\d*)(.)(\d*)/$1$colour$2$reset$3/g;
		}

    $delim = " ".weechat::color(weechat::config_string(weechat::config_get("weechat.color.chat_delimiters"))).weechat::config_string(weechat::config_get("weechat.look.prefix_suffix")).weechat::color("reset")." ";
    $msg =~ s/\t/$delim/;


    push (@bar_lines_time, $time);
    push (@bar_lines, $msg);

    # Trigger update
    weechat::bar_item_update("pipe");

    if (weechat::config_get_plugin("use_popup") eq "on") {
        $seconds = weechat::config_get_plugin("popup_timeout");
        weechat::command("", "/bar show pipe");
        weechat::command("", "/wait $seconds /bar hide pipe");
    }

    if (weechat::config_get_plugin("bar_scrolldown") eq "on")
    {
        weechat::command("", "/bar scroll pipe * ye")
    }
}

# Start the output display
sub pipe_start
{
    pipe_bar_open();
}

# Check result of register, and attempt to behave in a sane manner
if (!weechat::register("pipe", "KenjiE20", "2.5", "GPL3", "Highlight Monitor", "", ""))
{
	weechat::print ("", "\tPipe is already loaded");
	return weechat::WEECHAT_RC_OK;
}
else
{
	# Start everything
	pipe_hook();
	pipe_config_init();
	pipe_start();
}
