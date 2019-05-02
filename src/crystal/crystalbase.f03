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
        character(:),allocatable       :: name                            !Nome do cristal
    !-----------------------------------------------------------------------------------------------------------------------!
        real, allocatable                :: corr_L(:), ee_corr_L(:)         !Comprimento de correlação ; Erro sobre corr_L 
        real, allocatable                :: dope(:)                         !Dopagem do cristal (hole/unity cell)
        real*8, allocatable              :: E_0(:)                          !Parâmetro E_0
        integer, allocatable             :: Nmax(:)                         !Nível de preenchimento dos elétrons sobre o poço quadrado
    !--------------------------------------------------------------------------------------------------------------------------------
        
        type(Earray), dimension(:), allocatable               :: well_E       !Array com as energias do poço quadrado com Comprimento 'corr_L'
        type(Earray), dimension(:), allocatable               :: well_E_par   !Array com as energias do poço quadrado com Comprimento 'corr_L' na simetria par
        type(Earray), dimension(:), allocatable               :: well_E_impar !Array com as energias do poço quadrado com Comprimento 'corr_L' na simetria impar
    !----------------------------------------------------------------------------------------------------------------------------------------
    contains
    !----------------------------------------------
        procedure , public  ::  setCrystal
        procedure , public  ::  setWells
        procedure , public  ::  printCrystalData
        procedure , public  ::  Well
        procedure , public  ::  closeCrystal
    !----------------------------------------------
        procedure , private  ::  setParams
        procedure , private  ::  alloc
        procedure , private  ::  dealloc
    !-----------------------------------------------
    end type

!-----------------------!


contains


!--------------------------------
#include<../src/crystal/setCrystal.f03>

#include<../src/crystal/setWells.f03>

#include<../src/crystal/setParams.f03>

#include<../src/IO/find_in_file.f03>

#include<../src/crystal/printCrystalData.f03>

#include<../src/crystal/well.f03>

#include<../src/crystal/closeCrystal.f03>

#include<../src/crystal/alloc.f03>

#include<../src/crystal/dealloc.f03>


end module crystalBase
