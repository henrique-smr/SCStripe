!-----------------------------------
! Constructor da classe crystalData. 
!----------------------------------
    subroutine setCrystal(this, crystalInfoPath)
        implicit none
        character(*), intent(in)        :: crystalInfoPath
        character(100)                  :: aux
        class(crystal), intent (inout)  :: this
        

        aux = find_in_file(crystalInfoPath,'crystal_name')

        this%name = trim(adjustl(aux))

        print*, this%name

        aux =  find_in_file(crystalInfoPath, 'data_len')

        print*, aux

        read(aux,*) this%dataLEN
!-------------------------------------------------
        call this%alloc()
!------------------------------------------------
        aux =  find_in_file(crystalInfoPath, 'charge_mod')
        read(aux,*) this%charge_mod

        aux = find_in_file(crystalInfoPath, 'unit_cell_100')
        read(aux,*) this%unit_cell_100

        aux = find_in_file(crystalInfoPath, 'correlation_len')
        read(aux,*) this%corr_L

        aux = find_in_file(crystalInfoPath, 'error_corr_len')
        read(aux,*) this%ee_corr_L

        aux = find_in_file(crystalInfoPath, 'dope')
        read(aux,*) this%dope   

        

    end subroutine setCrystal