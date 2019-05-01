

#========Name============
MF= Makefile

#====Compiler=======
FC 		:= gfortran
FFLAGS 	:= -O3 -Wall -Warray-bounds -fbounds-check -fcheck=all -cpp

#====Directories======

SRCDIR = src
BINDIR = bin
MODDIR = mod

VPATH = src src/well src/well/base /src/crystal
#files = $(wildcard src/well/base/*f03) $(wildcard src/well/*f03) $(wildcard src/crystalbase/*f03) $(wildcard src/*f03)   
#objects = 

#FFLAGS += -J $(MODDIR) -I $(MODDIR)
#======Target========

target = SCStripe

#=====Sources and Objects=========================================

files = $(SRCDIR)/well/base/instructools.f03 $(SRCDIR)/plotter.f03 $(SRCDIR)/well/base/base.f03  \
		  $(SRCDIR)/well/calculator.f03 $(SRCDIR)/well/auto.f03 \
		  $(SRCDIR)/crystal/crystalbase.f03 $(SRCDIR)/analysis.f03 \
		   $(SRCDIR)/main.f03 


objects = $(BINDIR)/instructools.o $(BINDIR)/linear_system.o $(BINDIR)/data_fit.o $(BINDIR)/plotter.o \
			$(BINDIR)/base.o $(BINDIR)/calculator.o $(BINDIR)/auto.o \
				$(BINDIR)/crystalbase.o $(BINDIR)/analysis.o $(BINDIR)/main.o


#======Rules====================================



default: $(target)
	



$(target): $(objects)
	$(FC) $(FFLAGS) -I $(MODDIR) -o $@ $^

$(BINDIR)/instructools.o: $(SRCDIR)/well/base/instructools.f03
	mkdir -p $(MODDIR)
	mkdir -p $(BINDIR)
	$(FC) $(FFLAGS) -J $(MODDIR) -c $< -o $@

$(BINDIR)/linear_system.o: $(SRCDIR)/data_fit/linear_system.f03
	$(FC) $(FFLAGS) -J $(MODDIR) -c $< -o $@

$(BINDIR)/data_fit.o: $(SRCDIR)/data_fit/data_fit.f03
	$(FC) $(FFLAGS) -J $(MODDIR) -c $< -o $@

$(BINDIR)/base.o: $(SRCDIR)/well/base/base.f03
	$(FC) $(FFLAGS) -J $(MODDIR) -c $< -o $@

$(BINDIR)/plotter.o: $(SRCDIR)/plotter.f03
	$(FC) $(FFLAGS) -J $(MODDIR) -c $< -o $@

$(BINDIR)/calculator.o: $(SRCDIR)/well/calculator.f03
	$(FC) $(FFLAGS) -J $(MODDIR) -c $< -o $@

$(BINDIR)/auto.o: $(SRCDIR)/well/auto.f03
	$(FC) $(FFLAGS) -J $(MODDIR) -c $< -o $@

$(BINDIR)/crystalbase.o: $(SRCDIR)/crystal/crystalbase.f03
	$(FC) $(FFLAGS) -J $(MODDIR) -c $< -o $@

$(BINDIR)/edata.o: $(SRCDIR)/edata.f03
	$(FC) $(FFLAGS) -J $(MODDIR) -c $< -o $@

$(BINDIR)/analysis.o: $(SRCDIR)/analysis.f03
	$(FC) $(FFLAGS) -J $(MODDIR) -c $< -o $@

$(BINDIR)/main.o: $(SRCDIR)/main.f03
	$(FC) $(FFLAGS) -J $(MODDIR) -c $< -o $@


clean:
	@rm -rf $(BINDIR) $(MODDIR)

	


