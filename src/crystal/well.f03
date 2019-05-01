!----------------------------------------------------------------------------------------------------
!Função para facilitar o acesso às auto-energias
!----------------------------------------------------------------------------------------------------
function well(this, i_, j_) result(c)
    class(crystal), intent(in) :: this
    integer, intent(in)        :: i_, j_
    real*8                     :: c

    c = this%well_E(i_)%E(j_)

end function