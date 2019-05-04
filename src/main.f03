

program main

    use data_fit
    use IO
    use Analysis    

    implicit none
    real                            :: theta = 0.2956,v0 = 2.0
    integer                         :: int_ord=2
    character(len=32)               :: asw
    type(input_data_files)          :: input_files
    type(intData), allocatable      :: DATA(:)
    Print *, "========================================================================================"
    Print *, "========================= SCStripe - Superconducting Stripes ==========================="
    Print *, "========================================================================================"


    open(unit=100, file='resultados.dat',position='append', action="write")

    25 continue

    call querry()

    goto 25    

    call finish()
    


    
contains

#include <../src/UI/m.f03>

    subroutine querry()
        implicit none
        print *, ''
        print *, 'Digite um comando'
        print *, ''
        read*, asw
        select case (asw)
            case("quick")
                call read_input()
                call set_data()
                call export()
            case("read_input")
                call read_input()
            case("set_data")
                call set_data()
            case("export")
                call export()
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
               ! call fit_data(LBCO_hucker%dope,LBCO_hucker%corr_L)
            case default
                print*, "Comando não reconhecido. Digite -help para uma lista de comandos"
        end select

    end subroutine


end program main