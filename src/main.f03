

program main

    use data_fit
    use Analysis
    use plotter

    implicit none
    real                 :: theta = 0.2956,v0 = 2.0
    integer              :: int_ord=2, delta_n
    character(len=32)    :: asw, step
    type(crystal)        :: LBCO_hucker, YBCO_hucker, YBCO_blanco, Hg_tabis
    type(intData)        :: intLBCO_hucker, intYBCO_hucker, intYBCO_blanco, intHg_tabis
    Print *, "========================================================================================"
    Print *, "========================= SCStripe - Superconducting Stripes ==========================="
    Print *, "========================================================================================"


    open(unit=100, file='resultados.dat',position='append', action="write")



    10 continue

    call querry()

    goto 10    

    call finish()
    


    
contains

#include <../src/m.f03>

    subroutine querry()
        implicit none
        10 continue
        print *, ''
        print *, 'Digite um comando'
        print *, ''
        read*, asw
        select case (asw)
            case("quick")
                call read_input()
                !call analyze_data()
                call out_plot_data()
            case("read_input")
                call read_input()
            case("analyze")
                !call analyze_data()
            case("out_plot_data")
                call out_plot_data()
            case("reset")
                call finish()
            case("plot")
                call plot()
            case("display")
                call display()
            case("display_all")
                call display_all()
            case("print_to_file")
                call print_to_file()
            case("-help")
                call print_help()
            case("quit")
                call quit()
            case("fit")
                call fit_data(LBCO_hucker%dope,LBCO_hucker%corr_L)
            case default
                print*, "Comando não reconhecido. Digite -help para uma lista de comandos"
                goto 10
        end select

    end subroutine


end program main