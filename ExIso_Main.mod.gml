//this will be merged into the main file (when it exists) so delete this once it does
#define init

		//Loading Message:
		if(fork()) {
	    	wait 35;
	    	trace_color("Thanks for playing NT:EI!", c_fuchsia);
	    	trace_color("Please let Shane#1288 in the NT Discord know if you find any bugs", c_fuchsia);
	    	exit;
	    }
#define step

	//Confetti Cleanup:
if instance_number(Confetti) > 1300
    {
    //trace("CLEAN")
    with(Confetti){
        if random(5)<1{ instance_destroy() }
    } }
    