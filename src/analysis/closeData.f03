subroutine closeData(this)
    implicit none
    class(intData), intent(inout)   ::  this
    call this%dealloca()
    call this%crystal%closeCrystal()
    
end subroutine closeData