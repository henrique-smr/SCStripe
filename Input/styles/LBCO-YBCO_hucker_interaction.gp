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
set mytics 2
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

set title 'Simmetry conserving BSC Interaction - V = 2.0eV & θ = 295.6 meV'
set ylabel '{V^{ef} _T (eV)}' font ",14"
set xlabel 'ρ(hole/planar Cu)'
#set yrange [-300:0]


#===================================================================
#============ Label for interaction definition =====================
#===================================================================

LABEL = "{/:Italic {/=16 I_{T}} = { {/=18 Σ_{n}}{θ} {/=16 (}{(E_n - E_{n-2})^2 - {θ^2}}{/=16 ) }^{-1}}"
set obj 10 rect at 0.11,-250 size 0.033,25
set label 10 at 0.11,-250 LABEL front center

#=======================================================
#================== set terminal =======================
#=======================================================

set terminal qt 5 size 800,600 enhanced font 'TimesNewRoman,14' persist

#=====================================================================================
#================================== plotting =========================================
#=====================================================================================

plot  'Output/plotdata/LaBaCuO-Hucker/avgInteraction.dat'	u 1:2 title "LBCO-Hucker" w lp ls 4, \
	  'Output/plotdata/YaBaCuO-Hucker/avgInteraction.dat'	u 1:2 title "YBCO-Hucker" w lp ls 3

