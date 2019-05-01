

module instructools
    public ::operator(.kick.)


    type, public :: vec2
        real*8 :: a
        real*8 :: b
    end type
    interface vec2
        module procedure setvec2
    end interface
    interface operator(*)
        module procedure :: vec2multiply
    end interface
    interface assignment(=)
        module procedure :: vec2assign1
        module procedure :: vec2assign2
    end interface

    type, public :: limits
        type(vec2)  :: k_i, k_f
        integer :: n
    end type
    interface limits
        module procedure :: setlim
    end interface
contains
    subroutine vec2assign1 (this, other)
        type(vec2), intent(inout) :: this
        type(vec2), intent(in) :: other
         this%a = other%a
         this%b = other%b 
    end subroutine
    subroutine vec2assign2 (this, re)
        type(vec2), intent(inout) :: this
        real, intent(in) :: re
         this%a = re
         this%b = re
         end subroutine     
         function vec2multiply (this, i) result(c)
        type(vec2), intent(in) :: this
        type(vec2):: c
        integer, intent(in) :: i
        c%a=(this%a)*i
        c%b=(this%b)*i
    end function
     
    function setlim (n,ki,kf) result (lm)
        type(limits) :: lm
        type(vec2), intent(in),optional :: ki, kf
        integer, intent(in) :: n
        if(.not.present(ki)) then
            lm%k_i=0.0
            lm%k_f=0.0
        else
            lm%k_i=ki
            lm%k_f=kf                
        end if
        lm%n=n
    end function
    function setvec2 (a,b) result (ks)
        type(vec2) :: ks
        real*8, intent(in) :: a,b
        ks%a=a
        ks%b=b
    end function
end module instructools
