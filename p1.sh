#!/bin/bash

awk -F, ' NR>1 { if ($1 ~ /^tm[0-9]*/ || /^ts[0-9]*/) print$0 }' titles.cvs > titles_net.csv

awk -F, '$2 ~ /^[[:alnum:],",#,¡,¿,'\'']/ { print $0 }' titles_net.csv > titles_net1.csv

awk -F, '$3 ~ /MOVIE/ { print $0 }' titles_net1.csv > Movies.csv

awk -F, '$3 ~ /SHOW/ { print $0 }' titles_net1.csv > Shows.csv

awk -F, '$12 $13 $14 $15 ~ /[[:alnum:]]/ { print $0 }' Movies.csv > Movies1.csv

awk -F, '$12 $13 $14 $15 ~ /[[:alnum:]]/ { print $0 }' Shows.csv > Shows1.csv

h=$(awk -F, 'BEGIN {max=0*1.0} { if ( $13*0.1 > max*1.0) max=$13} END {print max}' Shows1.csv)

awk -F, -v var1=$h '{ print $0","$12*($13/var1)}' Shows1.csv > Shows2.csv

m=$(awk -F, 'BEGIN {max=0*1.0} { if ( $14*0.1 > max*1.0) max=$14} END {print max}' Shows1.csv)

awk -F, -v var2=$m '{ print $0","$12*($14/var2)}' Shows2.csv > Shows3.csv
