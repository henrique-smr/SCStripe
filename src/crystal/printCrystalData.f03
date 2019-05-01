    subroutine printCrystalData(this)
            class(crystal), intent (in) :: this
            character(len=32) ::  my_fmt1, my_fmt2, my_fmt3
            integer :: i_
            write(my_fmt1, '(A,I0,A,A)') '(A4,A32, ', this%dataLEN, '(F7.3,A5) ', ')'
            write(my_fmt2, '(A,I0,A,A)') '(A4,A31, ', this%dataLEN, '(F7.1,A5) ', ')'
            write(my_fmt3, '(A,I0,A,A)') '(A4,A36, ', this%dataLEN, '(I2,A10) ', ')'

            write(*,*) ""
            write(*,*) ""
            write(*,*) ""
            write(*,*)              "*********************************************************************************************"
            write (*,*) '                                            ',this%name        
            write(*,*)              "*********************************************************************************************"
            write(*,*) ""
            write(*,my_fmt1)     "    ",'Dopagem (holes/planarCu)     |  ',  (this%dope(i_), "  |  ", i_=1,this%dataLEN)               
            write(*,*)           ""
            write(*,my_fmt2)     "    ",'Comp. Corr. (ξ)              | ',  (this%corr_L(i_),"    |",  i_=1,this%dataLEN)
            write(*,*) ""
            write(*,my_fmt3)     "    ",'Nº de níveis preenchidos     |      ',  (this%Nmax(i_), "     |    ", i_=1,this%dataLEN)              
            write(*,*) ""
            !write(*,*) ""
            !write(*,*)               "*******************************************************************************************"
    end subroutine