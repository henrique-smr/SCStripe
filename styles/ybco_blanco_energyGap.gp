set encoding utf8

#========================================================
#= remove border on top and right and set color to gray =
#========================================================
set style line 11 lc rgb '#000000' lt 1
set border 3 back ls 11
set tics font "TimesNewRoman,12"


#======================================
#========== define grid ===============
#======================================
set style line 12 lc rgb '#808080' lt 0 lw 1
set grid back ls 12
set ytics 50
set mytics 1
set grid ytics mytics

#========================================================
#================= color definitions ====================
#========================================================
set style line 1 lc rgb '#2c6b22' pt 4 ps 1.5 lt 1 lw 1.2 
set style line 2 lc rgb '#e64d61' pt 6 ps 1.5 lt 1 lw 1.2 
set style line 3 lc rgb '#8b1a0e' pt 6 ps 1.5 lt 1 lw 1.5  # --- red
set style line 4 lc rgb '#5e9c36' pt 6 ps 1.5 lt 1 lw 1.5  # --- green

#==========================
#======= set key box ======
#==========================
set key box opaque top right width 2.6

#=========================================
#========== Title and axis names =========
#=========================================

set title 'Energy gaps in LBCO - V = 2.0eV'
set xlabel 'ρ(hole/planar Cu)'
set ylabel '{ΔE(meV)}' font ",14"

#=======================================================
#================== set terminal =======================
#=======================================================

set terminal qt 2 size 800,600 enhanced font 'TimesNewRoman,14' persist

#=====================================================================================
#================================== plotting =========================================
#=====================================================================================

plot 'Output/plotdata/avgEnergyGap_YBCO_blanco.dat' u 1:2 notitle w l ls 2, 'Output/plotdata/avgEnergyGap_YBCO_blanco.dat' u 1:2:3 title "〈 ΔE 〉"  w yerr ls 2, \
		'Output/plotdata/topEnergyGap_YBCO_blanco.dat'	u 1:2  title "top ΔE" w lp ls 1 ,\
		'Output/plotdata/bottomEnergyGap_YBCO_blanco.dat'	u 1:2 title "bottom ΔE" w lp ls 1