!-----------------------------------------------------------------------------------------------
!Calcula, para cada dopagem do cristal, as auto-energias de um poço(well) com comprimento corr_L
!-----------------------------------------------------------------------------------------------
    subroutine setWells(this, v0_)
        implicit none
        class(crystal), intent (inout) :: this
        real  ,intent(in)  :: v0_
        integer            :: i_

        call this%setParams()
        !--------------------------------------------------------------------------------------------------
        print*, "Calculating square well eign-energies .... "
        do i_ = 1, this%dataLEN
            call calcular_autovalores(v0_, this%E_0(i_), this%well_E(i_)%E, this%well_E_par(i_)%E, this%well_E_impar(i_)%E) !Calcula as auto-energias
            !Os poços devem poder ABRIGAR todos os elétrons.!!!!!!!!
            if(size(this%well_E(i_)%E) .lt. this%Nmax(i_) ) then
                        print*, "ERRO: POTENCIAL MUITO PEQUENO PARA ABRIGAR PARTÍCULAS -- "
                        print*, "Crystal",  this%name
                        print*, "Dopagem: ",this%dope(i_)
                        print*, "Comp. de correlação: ", this%corr_L(i_)
                        stop
             endif

        enddo
    end subroutine setWells