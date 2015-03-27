#!/usr/bin/perl

$runtimes = 100;
$num_of_infections = 5;

#grid is 100x100
$hsize = 99;
$vsize = 99;




$hposition = int(rand($hsize));
$vposition = int(rand($vsize));
#$hposition = 0;
#$vposition = 0;

#print "Starting position: ${hposition}x${vposition}\n";
$infected = 0;

sub create_infection {
    $hinfected = int(rand($hsize));
    $vinfected = int(rand($vsize));
    
    return "${hinfected}x${vinfected}";
}

sub test_square_infected {
    $test = $_[0];
    for( @infection_space ){
            if( "$test" eq $_ ){
                return 1;
            } else {
                return 0;
            }
    }
}

#print "Generating $num_of_infections infectious spaces\n";
for (my $i=0; $i <= $num_of_infections; $i++) {
    do {
        $proposed_infection = create_infection;
        $test_result = test_square_infected($proposed_infection)
    } until ( $test_result == 0 );
    @infection_space[$i] = $proposed_infection;
}

sub rand_move {
    $random = int(rand(4));

    if ( $random == 0 ) {
        #move left
        $hposition = $hposition - 1;
    } elsif ( $random == 1) {
        #move right
        $hposition = $hposition + 1;
    }elsif ( $random == 2) {
        #move up
        $vposition = $vposition + 1;
    }else {
        #move down
        $vposition = $vposition - 1;
    }
}

for (my $i=0; $i <= $runtimes; $i++) {
    #print "position is ${hposition}x${vposition}\n";
    
    #move
    rand_move;
    
    #ensure we are still within boundaries
    while ( $hposition < 0 || $vposition < 0 || $hposition > $hsize || $vposition > $vsize ) {
        if ( $hposition < 0 ) {
            $hposition = 0;
            rand_move;
        } elsif ( $vposition < 0 ) {
            $vposition = 0;
            rand_move;
        } elsif ( $hposition > $hsize ) {
            $hposition = $hsize;
            rand_move;
        } elsif ( $vposition > $vsize ) {
            $vposition = $vsize;
            rand_move;
        }
    }
    
    #test if we hit infected space
    if ( $infected == 0 ) {
        for( @infection_space ){
            if( "${hposition}x${vposition}" eq $_ ){
                $infected = 1;
                #print "Became infected \n";
                last;
            }
        }
    } else {
       #print "Infected :( \n"; 
    }
}

#print "final position: ${hposition}x${vposition}\n";
if ( $infected == 1 ) {
    print "Infected :( \n";
} else {
    print "Not infected\n";
}
