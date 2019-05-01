subroutine dealloc(this)
    implicit none
    class(crystal), intent(inout) :: this
    deallocate(this%corr_L)
    deallocate(this%ee_corr_L)
    deallocate(this%E_0)
    deallocate(this%Nmax)
    deallocate(this%dope)
    deallocate(this%well_E)
    deallocate(this%well_E_impar)
    deallocate(this%well_E_par)  
end subroutine dealloc