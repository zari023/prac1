#!/bin/bash

argument=$#

if $# == 0
	then
##########1##########
	awk -F, ' NR>1 { if ($1 ~ /^tm[0-9]*/ || /^ts[0-9]*/) print$0 }' titles.cvs > titles_net.csv
	x=$(wc -l < titles.cvs)
	y=$(wc -l < titles_net.csv)
	resta=$(($x - $y)) 
	echo $resta

###########2##########
	awk -F, '$2 ~ /^[[:alnum:],",#,¡,¿,'\'']/ { print $0 }' titles_net.csv > titles_net1.csv


##########3##########
	awk -F, '$3 ~ /MOVIE/ { print $0 }' titles_net1.csv > Movies.csv

	awk -F, '$3 ~ /SHOW/ { print $0 }' titles_net1.csv > Shows.csv

###########4###########
	awk -F, '($12 ~ /[0-9]/) && ($13 ~ /[0-9]/) && ($14 ~ /[0-9]/) && ($15 ~ /[0-9]/) { print $0 }' Movies.csv > Movies1.csv

	awk -F, '($12 ~ /[0-9]/) && ($13 ~ /[0-9]/) && ($14 ~ /[0-9]/) && ($15 ~ /[0-9]/) { print $0 }' Shows.csv > Shows1.csv


############5#########
	h=$(awk -F, 'BEGIN {max=0.0} { if ( $13*1.0 > max*1.0){ max=$13; } } END {print max}' Movies1.csv )

	awk -F, -v var1=$h '{ print $0","$12*($13/var1)}' Movies1.csv > Movies2.csv

	m=$(awk -F, 'BEGIN {max=0.0} { if ( $14*1.0 > max*1.0){ max=$14; } } END {print max}' Movies1.csv )

	awk -F, -v var2=$m '{ print $0","$12*($14/var2)}' Movies2.csv > Movies3.csv

	a=$(awk -F, 'BEGIN {max=0.0} { if ( $13*1.0 > max*1.0){ max=$13; } } END {print max}' Shows1.csv )

	awk -F, -v var3=$a '{ print $0","$12*($13/var3)}' Shows1.csv > Shows2.csv

	b=$(awk -F, 'BEGIN {max=0.0} { if ( $14*1.0 > max*1.0){ max=$14; } } END {print max}' Shows1.csv )

	awk -F, -v var4=$b '{ print $0","$12*($14/var4)}' Shows2.csv > Shows3.csv

	head -1 titles.cvs > Movies_f.csv
	awk -F, '{print $0",""imdb_reiability"",""tmdb_reliability"}' Movies_f.csv > Movies_f1.csv
	cat Movies3.csv >> Movies_f1.csv

	head -1 titles.cvs > Shows_f.csv
	awk -F, '{print $0",""imdb_reiability"",""tmdb_reliability"}' Shows_f.csv > Shows_f1.csv
	cat Shows3.csv >> Shows_f1.csv

#############6###########
	awk -F, 'BEGIN {max=0.0} { if ( $12*1.0 > max*1.0){ max=$12; } } {if($12==max){print $1 $2 $9 $12}}' Movies_f1.csv > m12max.csv
	z=$(tail -1 m12max.csv)
	echo $z

	awk -F, 'BEGIN {max=0.0} { if ( $12*1.0 > max*1.0){ max=$12; } } {if($12==max){print $1 $2 $9 $12}}' Shows_f1.csv > m12s.csv
	x=$(tail -1 m12s.csv)
	echo $x

	awk -F, 'BEGIN {max=0.0} { if ( $13*1.0 > max*1.0){ max=$13; } } {if($13==max){print $1 $2 $9 $13}}' Movies_f1.csv > m13m.csv
	c=$(tail -1 m13m.csv)
	echo $c

	awk -F, 'BEGIN {max=0.0} { if ( $13*1.0 > max*1.0){ max=$13; } } {if($13==max){print $1 $2 $9 $13}}' Shows_f1.csv > m13s.csv
	v=$(tail -1 m13s.csv)
	echo $v

	awk -F, 'BEGIN {max=0.0} { if ( $16*1.0 > max*1.0){ max=$16; } } {if($16==max){print $1 $2 $9 $16}}' Movies_f1.csv > m16.csv
	n=$(tail -1 m16.csv)
	echo $n


	awk -F, 'BEGIN {max=0.0} { if ( $16*1.0 > max*1.0){ max=$16; } } {if($16==max){print $1 $2 $9 $16}}' Shows_f1.csv > m16s.csv
	s=$(tail -1 m16s.csv)
	echo $s

	awk -F, 'BEGIN {max=0.0} { if ( $14*1.0 > max*1.0){ max=$14; } } {if($14==max){print $1 $2 $9 $14}}' Movies_f1.csv > m14m.csv
	d=$(tail -1 m14m.csv)
	echo $d

	awk -F, 'BEGIN {max=0.0} { if ( $14*1.0 > max*1.0){ max=$14; } } {if($14==max){print $1 $2 $9 $14}}' Shows_f1.csv > m14s.csv
	f=$(tail -1 m14s.csv)
	echo $f

	awk -F, 'BEGIN {max=0.0} { if ( $15*1.0 > max*1.0){ max=$15; } } {if($15==max){print $1 $2 $9 $15}}' Movies_f1.csv > m15m.csv
	g=$(tail -1 m15m.csv)
	echo $g

	awk -F, 'BEGIN {max=0.0} { if ( $15*1.0 > max*1.0){ max=$15; } } {if($15==max){print $1 $2 $9 $15}}' Shows_f1.csv > m15s.csv
	j=$(tail -1 m15s.csv)
	echo $j
	awk -F, 'BEGIN {max=0.0} { if ( $17*1.0 > max*1.0){ max=$17; } } {if($17==max){print $1 $2 $9 $17}}' Movies_f1.csv > m17m.csv
	k=$(tail -1 m17m.csv)
	echo $k

	awk -F, 'BEGIN {max=0.0} { if ( $17*1.0 > max*1.0){ max=$17; } } {if($17==max){print $1 $2 $9 $17}}' Shows_f1.csv > m17s.csv
	t=$(tail -1 m17s.csv)
	echo $t
else
	grep $argument Movies_f1.csv
	grep $argument Showss_f1.csv
fi
