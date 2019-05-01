module crystalBase
    use auto

    implicit none

    real*8, parameter      :: a0=0.52917721067,h_=6.582119514d-16,pi_d = 3.1415926535897932384626433832795

    type Earray

        real*8, allocatable, dimension(:)   :: E

    end type
    !-------------------------------------------------------------------------------------------------------------------------------------
    !estrutura que mantém os dados dos cristais
    type crystal
        
        integer                        :: dataLEN                         !Número de pontos.
        real                           :: charge_mod                      !Modulação de de carga dentro do poço ()
        real                           :: unit_cell_100                   !Distancia [100] do cristal
        character(len=32)              :: name                            !Nome do cristal
    !-----------------------------------------------------------------------------------------------------------------------!
        real, allocatable                :: corr_L(:), ee_corr_L(:)         !Comprimento de correlação ; Erro sobre corr_L 
        real, allocatable                :: dope(:)                         !Dopagem do cristal (hole/unity cell)
        real*8, allocatable              :: E_0(:)                          !Parâmetro E_0
        integer(kind=2), allocatable     :: Nmax(:)                         !Nível de preenchimento dos elétrons sobre o poço quadrado
    !--------------------------------------------------------------------------------------------------------------------------------
        
        type(Earray), dimension(:), allocatable               :: well_E       !Array com as energias do poço quadrado com Comprimento 'corr_L'
        type(Earray), dimension(:), allocatable               :: well_E_par   !Array com as energias do poço quadrado com Comprimento 'corr_L' na simetria par
        type(Earray), dimension(:), allocatable               :: well_E_impar !Array com as energias do poço quadrado com Comprimento 'corr_L' na simetria impar
    !----------------------------------------------------------------------------------------------------------------------------------------
    contains
    !-----------------------------------------------
        procedure , private ::  setParams
        procedure , public  ::  setCrystal
        procedure , public  ::  setWells
        procedure , public  ::  closeCrystal
        procedure , public  ::  printCrystalData
        procedure , public  ::  Well
    !-----------------------------------------------
    end type

!-----------------------!


contains


!--------------------------------
#include <../scr/crystal/setWells.f03>

#include<../scr/crystal/setParams.f03>

#include<../scr/crystal/printCrystalData.f03>

#include<../scr/crystal/find_in_file.f03>

#include<../scr/crystal/setCrystal.f03>

!----------------------------------------------------------------------------------------------------
!Função para facilitar o acesso às auto-energias
!----------------------------------------------------------------------------------------------------
function well(this, i_, j_) result(c)
    class(crystal), intent(in) :: this
    integer, intent(in)        :: i_, j_
    real*8                     :: c

    c = this%well_E(i_)%E(j_)

end function


subroutine closeCrystal(this)
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
end subroutine closeCrystal



end module crystalBase
