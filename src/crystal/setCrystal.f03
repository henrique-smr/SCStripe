!-----------------------------------
! Constructor da classe crystalData. 
!----------------------------------
    subroutine setCrystal(this, DATA)
        implicit none
        character(*), intent(in)        :: DATA
        character(100)                  :: aux
        class(crystal), intent (inout)  :: this
        
        Print*, "Reading data ..."

        aux = find_in_file(DATA,'crystal_name')
        read(aux,*) this%name

        aux =  find_in_file(DATA, 'data_len')
        read(aux,*) this%dataLEN

        call allocate_data()      

        aux =  find_in_file(DATA, 'charge_mod')
        read(aux,*) this%charge_mod

        aux = find_in_file(DATA, 'unit_cell_100')
        read(aux,*) this%unit_cell_100

        aux = find_in_file(DATA, 'correlation_len')
        read(aux,*) this%corr_L

        aux = find_in_file(DATA, 'error_corr_len')
        read(aux,*) this%ee_corr_L

        aux = find_in_file(DATA, 'dope')
        read(aux,*) this%dope   

        
    contains
            subroutine allocate_data()
                print*, "Allocating crystal data ..."
                allocate(this%corr_L(this%dataLEN))
                allocate(this%ee_corr_L(this%dataLEN))
                allocate(this%E_0(this%dataLEN))
                allocate(this%Nmax(this%dataLEN))
                allocate(this%dope(this%dataLEN))
                allocate(this%well_E(this%dataLEN))
                allocate(this%well_E_impar(this%dataLEN))
                allocate(this%well_E_par(this%dataLEN))  
            end subroutine

    end subroutine setCrystal