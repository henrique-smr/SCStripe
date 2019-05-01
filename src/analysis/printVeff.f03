!------------------------------------------------------------------------------------
! Imprime as Interações BCS usadas para tirar a Interação média, exprimindo o gap de energia e os diferentes níveis do poço quadrado que compões o gap (final - inicial),
! Tem como entrada as mesmas que o construtor da classe 'Crystal'
!`Usa diferenças de ordem fixa
!--------------------------------------------------------------------------------------
subroutine printVeff(this, i_int_ord, f_int_ord, startLevel, theta)
    implicit none
    class(intData), intent(in) :: this
    integer, intent(in)        :: i_int_ord, f_int_ord, startLevel
    real, intent(in)           :: theta    
    integer                    :: i_, j_, k_
    real*8                     :: delta_e, in_
    delta_e = 0
    in_ = 0
          

    do k_ = 1, this%size

        
        write(*,"(A29,F5.3,A26)") (' --------------------------  '),(this%crystal%dope(k_)),('--------------------------')
        write(*,*)               ('----------- ----------- ------------ -----------------------') !i1=1,npts_lbco)
        write(*,*)               ('     i     |     f     |      ΔE(eV)    |     Interação') !i1=1,npts_lbco)
        write(*,*)               ('----------- ----------- ---------------- -------------------') !i1=1,npts_lbco)

        do i_=i_int_ord, f_int_ord

            do j_=startLevel, this%crystal%Nmax(k_)-i_

                 if (((i_+j_) .le. size(this%crystal%well_E(k_)%E)) .and. (j_ .ge. 1)) then
                    delta_e = this%crystal%well(k_,i_+j_)-this%crystal%well(k_,j_)               
                    in_ = theta/((delta_e**2 - theta**2 ))
                    write(*, "(I7,A7,I5,A7,ES12.5,A5,EN15.5)")  j_,' | ', (i_+j_),' | ', delta_e,' | ', in_              
                end if
            end do
        enddo
        write(*,*)               ('----------- ----------- ------------ -----------------------')
    enddo
end subroutine