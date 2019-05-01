

module calculator
    use base
    class(basis), pointer :: itf
    integer :: n_i

contains
    function get_a_values(f) result(c)
        implicit none
    class(basis), intent(inout),target :: f
    type(energys) :: c
    integer :: i_0,i_f,j,n

    call set_param()
    
    if(n .ne. 0) then
        c=energys(n)
            call solve()
    else
        c=energys(1)
        c%v(1)=0
        c%erro(1)=0
    end if
    nullify(itf)
    contains
        subroutine set_param()
            itf => f
            n=itf%instruc%n
            i_0=0
            i_f=itf%instruc%n - 1
            
                    
        
        end subroutine
        
        subroutine solve()
            type(vec2) :: bis
            j=1
            do n_i= i_0, i_f
                bis=bissec(itf.kick.n_i,5000,1.0e-12)
                c%v(j)=bis%a
                c%erro(j)=bis%b
                j=j+1        
            enddo
            
        end subroutine
    end function get_a_values
    

    function bissec(k,m,e) result (q)
        implicit none
        type(vec2), intent(in) :: k
        type(vec2)         :: q
        integer, intent(in) :: m
        real,intent(in) :: e
        real*8 :: a,b,x,d
        integer :: i        
        
        i=0
        a=k%a
        b=k%b
        x=(a+b)*0.5
        d=1
        if(h(a)*h(b) .le. 0.0) then
            call get_root()
        else
            call error_out()
        end if
        
        
    contains
        subroutine get_root()
            do while((i.le.m).and.(d.ge.e))
                x=(a+b)*0.5
                if(h(x)*h(b) .lt. 0.0) then
                    a=x
                else
                    b=x
                end if
                d=abs(h(x))
                i=i+1
            end do
            q=vec2(x,d)
        end subroutine
    
        subroutine error_out()
            print *, "erro! : fora do intervalo - metodo de bisseccao"
                print *, "tipo:",itf%parity
                print *, "na energia:",n_i 
                print *, "a=",a, &
                         "delta(a)=", h(a)
                print *, "b=",b, &
                         "delta(b)=", h(b)
                print*,  "gk(a)=",itf%gk(a), &
                     "gk(b)=",itf%gk(b)
                print*,  "fj(a)=",itf%fj(a), &
                     "fj(b)=",itf%fj(b)
                q=0.0
        end subroutine
    
    end function bissec
    
    function h(z) result(c)
        real*8 :: z,c
        c=itf%gk(z)-itf%fj(z)
    end function

end module calculator
