!---------------------------------------------------------------------------------
! Construtor da classe intData, responsável pela análise da interação BCS:
! 
! Tem como input um tipo 'crystal'- 'cryst'. 
! Um inteiro i_int_ord, que é a ordem inicial das diferenças de energia em que a interção vai ser calculada. 
! Um inteiro f_int_ord, que é a ordem final das diferenças de energia em que a interção vai ser calculada. 
! O nível de energia inicial, start_level, que a interação média começa a se calculada
! A energia da quasipartícula que os elétrons estão acolplados, theta
! 

subroutine set_analysis_data(this, crystInfoPath, v0,theta, i_int_ord, f_int_ord, startLevel)
    class(intData), intent(inout)   :: this
    character(*)                    :: crystInfoPath
    type (crystal)                  :: cryst
    integer,optional, intent(in)    :: i_int_ord, f_int_ord, startLevel
    real, intent(in)                :: theta, v0

    call cryst%setCrystal(crystInfoPath)
    call cryst%setWells(v0)

    this%crystal = cryst

    this%size  =  cryst%dataLEN

    call this%alloca()

    if(present(i_int_ord) .and.present(f_int_ord) .and. present(startLevel)) then
        call this%analize_fix_ord(theta, i_int_ord, f_int_ord, startLevel)
    else
        call this%analize_fix_ord(theta, 2, 2, 1)
    end if


end subroutine