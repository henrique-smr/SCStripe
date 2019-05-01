subroutine closeCrystal(this)
    class(crystal), intent(inout)  ::  this
    call this%dealloc()
end subroutine