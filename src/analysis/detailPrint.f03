!------------------------------------------------------------------------------------------------------------------------
! Imprime as informações do crystal bem como as informações calculadas pelos métodos ou analize_fix_ord, ou analize_fix_level, de forma detalhada
!------------------------------------------------------------------------------------------------------------------------

subroutine detailPrint(this, int_ord, theta)
    class(intData), intent(in) :: this
    integer,intent(in)        :: int_ord
    real, intent(in)          :: theta
    integer ::  i_
    character(len=32) ::  fmt2, e_format

    !-------------------------------------------------------------------------------------!
    !---------------------------------Formata as saidas-----------------------------------!
    !-------------------------------------------------------------------------------------!


    write(fmt2, '(A,I0,A,A)') '(A4,A33, ', this%size, '(F7.2, A5) ,', ')'
    write(e_format, '(A,I0,A)') '(5x,', this%size, '(EN12.4,A))'


    !------------------------------------------------------------------------------------!
    !-------------------------------Imprime as informações ------------------------------!
    !------------------------------------------------------------------------------------!

    call this%crystal%printCrystalData()

    write(*,fmt2)     "    ",'Interação (eV)               |  ',  (this%avgInteraction(i_),"  | ",   i_=1,this%size)
    print*, ""
    write(*,fmt2)     "    ",'〈 ΔE 〉(meV)               |  ',  (this%avgEnergyGap(i_)*1000 ," | ",  i_ = 1, this%size )
    print*, ""
    write(*,fmt2)     "    ",'σ²(ΔE) (meV)               |  ',  (this%varEnergyGap(i_)*1000 ," | ",  i_ = 1, this%size )
    print*, ""
    print*, ""
    print*, ""
    Write(*,*) "--------------------------------------Detalhes------------------------------------------------"
    print*, ""
    print*, ""
    call this%printVeff(int_ord, int_ord, 1, theta)!Nmax_lbco( i6) - (delta_n-1))

end subroutine