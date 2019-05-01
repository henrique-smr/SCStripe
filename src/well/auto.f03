
module auto
    use base
    use calculator
    use instructools

    implicit none
    type(even),private  :: eqPar
    type(neven), private:: eqImpar


contains


    subroutine calcular_autovalores(v0_,e0_,e_T,e_par,e_impar)    

        type(energys)       :: e1, e2
        type(limits)        :: instructionsPar,instructionsImpar
        real*8,allocatable,intent(out) :: e_T(:), e_par(:), e_impar(:)
        integer :: i_,np_, ni_, nt_
        real, intent (in)   ::  v0_
        real*8,intent(in)   ::  e0_
        real                :: r_


        r_ = real(v0_/e0_)
        call make_bodys(r_, instructionsPar, instructionsImpar)

        eqPar   = even(r_,instructionsPar)
        eqimPar = neven(r_,instructionsImpar)

        np_ = eqPar%instruc%n
        ni_ = eqImpar%instruc%n
        nt_ = np_ + ni_

        e1 = energys(np_)
        e2 = energys(ni_)

        e1 = get_a_values(eqPar)
        e2 = get_a_values(eqImpar)
        allocate (e_T(np_+ni_))
        allocate (e_impar(ni_))
        allocate (e_par(np_))
        do i_=1,np_
            e_T(2*i_-1) = e1%v(i_)
            e_par(i_)=e1%v(i_)
        enddo
        do i_=1,ni_
            e_T(2*i_) = e2%v(i_)
            e_impar(i_)=e2%v(i_)
        enddo
        e_T     = e_T*e_T*e0_
        e_par   = e_par*e_par*e0_
        e_impar = e_impar*e_impar*e0_
        !reshape(e_T(nt_+1:size(E_T)),e_impar(ni_+1:size(E_impar)), e_par(np_+1:size(E_par)) )
    end subroutine

    subroutine make_bodys(r, instructionsPar_,instructionsImpar_)
        !=========================================================================================================
        !Aqui declarei a entrada do parâmetro R e os objetos instruction{paridade}.
        !
        !Os objetos limits tem 4 entradas: Numero de raízes, intervalo de interação inicial e intervalo de interação inicial.
        !
        !Os intervalo de interação inicial e final são os intervalos onde vamos buscar a primeira e última raiz, respectivamente, 
        !calculados para não encontrar as regiões descontinuidades da função g(x) e das funções trigonométricas, delimitadas pela capacidade numérica.

        real, intent (in) :: r
        type(limits), intent(out) :: instructionsPar_,instructionsImpar_

        call solve_instrucs()

        !passa para os objetos eq{paridade} as instruções aqui calculadas
        


        contains  
    
        subroutine solve_instrucs()

            real*8, parameter :: err_ = 0.00001
            real*8, parameter:: pi = 3.1415926535897932384626433832795

            !===============================================================================================================================
            !As variaveis leftBoudry{paridade} e rightBoudry{paridade} são os limites do último intervalo (geralmente) onde é feito a busca
            ! pelas raízes, visto que é um intervalo especial, onde existe uma descontinuidade na função g(x) (que depende de R)
            
            real*8 :: a, leftBoudryPar,rightBoudryPar,leftBoudryImpar,rightBoudryImpar
            !===============================================================================================================================
            !nPar e nImpar são as quantidades de raizes que cada paridade do poço quadrado tem
            integer :: nPar,nImpar
            a=sqrt(r)
            !==============================================================================================================================
            !Quando R <ou= 1, não existe raízes impares. Contúdo sempre existe uma raiz par (sempre é possível confinar uma partícula).
            !Como g(x) é descontínua em x=0 e x=sqrt(R), precisamos definir um intervalo onde ainda exista soluçao para f(x) = 0, 
            !e que seja o mais preciso possível. Esolhemos um erro err_ e tomamos leftBoudry{paridade}=err_ e rightBoudry{paridade}=(1-err_)*sqrt(R)
            
            if(r .le. 1.0) then
                nPar=1
                leftBoudryPar = 0.1*err_
                rightBoudryPar = (1-err_)*a
                nImpar=0
            
                instructionsPar_ = limits(nPar, vec2(leftBoudryPar, rightBoudryPar),vec2(0,0))
                instructionsImpar_ = limits(0)                
            else
                
                nPar= floor(0.5*a)+1
                nImpar= floor(0.5*(a+1))
                
                leftBoudryPar = 2*(nPar-1)
                if(a .gt. (leftBoudryPar + 1)) then
                    rightBoudryPar = leftBoudryPar + (1-err_)
                else
                    rightBoudryPar = (1-err_)*a
                end if
                
                leftBoudryImpar = 2*(nImpar) - 1

                if(a .gt. (leftBoudryImpar + 1)) then
                    rightBoudryImpar = leftBoudryImpar + (1-err_)
                else
                    rightBoudryImpar = (1-err_)*a
                end if
                
                instructionsPar_ = limits(nPar, vec2(0.1*err_, (1-0.1*err_)), vec2(leftBoudryPar, rightBoudryPar) )
                instructionsImpar_ = limits(nImpar, vec2((1 + 0.1*err_), (2-0.1*err_)), vec2(leftBoudryImpar, rightBoudryImpar) )                
                
                if(a .lt. 2) then 
                    instructionsImpar_ = limits(nImpar, vec2(leftBoudryImpar, rightBoudryImpar), &
                                                       vec2(leftBoudryImpar, rightBoudryImpar))        
                end if 
            end if                

        end subroutine solve_instrucs
            
    end subroutine make_bodys

end module auto