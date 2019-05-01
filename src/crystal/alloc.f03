subroutine alloc(this)
    class(crystal), intent(inout)  ::  this
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