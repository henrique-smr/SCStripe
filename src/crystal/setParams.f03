!-------------------------------------------------------------------------------------
! Calcula os parametros E_0 e Nmax para cada dopagem, com base nas informações de DATA
!-------------------------------------------------------------------------------------------
    subroutine setParams(this) 
        implicit none
        class(crystal), intent (inout) :: this
        real    ::  ne
        integer :: i_
        !----------------------------------------------------------------------------------
        print*, ("Setting square well and CDW parameters for"), this%name,("...")
        do i_=1,this%dataLEN
                !Parametro E0
                this%E_0(i_) = ((pi_d*a0)**2)*(13.60025/(this%corr_L(i_)*this%corr_L(i_)))
                !Nº de elétrons
                ne = (3*(this%corr_L(i_))/(this%unit_cell_100)) *(1-this%dope(i_))*this%charge_mod
                this%Nmax(i_) = ceiling( NINT(ne)*0.5 )
        end do
    end subroutine setParams