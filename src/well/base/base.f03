

module base
    use instructools
    real*8, parameter:: inv_hpi=0.63661977236758134307553505349006
    real*8, parameter:: hpi=1.5707963267948966192313216916398  
    real*8, parameter:: pi = 3.1415926535897932384626433832795
    

    type, public :: energys
        real*8, allocatable :: v(:)
        real*8, allocatable :: erro(:)
    contains
        procedure, public, pass(this) :: dealo
    end type
    
    interface energys
        module procedure :: aloc_e
    end interface energys
    
    type, abstract, public ::  basis
        type(energys)       :: e
        type(limits)       :: instruc
        character(len=5)   :: parity
        real*8        :: r
        procedure(inta), pointer,nopass, public :: phi
        procedure(inta), pointer,nopass, public :: gk
        procedure(intb), pointer,pass(this), public :: fj

    contains
        procedure(intk), deferred :: fkick
        generic :: operator(.kick.) => fkick
        procedure,public :: kill_tag 

    end type
    
!----------------------------------!
    abstract interface
        function intk(this,i) result(c)
            import :: basis
            import :: vec2
            class(basis),intent(in) :: this
            integer, intent(in)   :: i
            type(vec2)      :: c
    end function intk
        function inta (z) result (c)
            real*8  :: c
            real*8  ::t
            real*8, intent(in) :: z
        end function inta
        function intb (z,this) result (c)
            import :: basis
            class(basis), intent(in), optional:: this
            real*8  :: c
            real*8  ::t
            real*8, intent(in) :: z
        end function intb
     end interface

!"------------------------------------------------------------"

    !estabelecendo os procedimentos usados pelos cip's
    type, extends(basis) :: even
    contains
        private 
        procedure,public  :: fkick=>fek1
        procedure, nopass :: g1
        procedure, nopass :: f1
    end type
    interface even
        module procedure :: seteven1
    end interface even
    

    type, extends(basis) :: neven
    contains
        private
        procedure,public  :: fkick=>fnek2
        procedure, nopass :: g2
        procedure, nopass :: f2
    end type
    interface neven
        module procedure :: setneven1
    end interface
    
!----------------------------------------------------------------



!---------------!

contains

!---------------------------------------------!
!------------constructors---------------------!

     function seteven1(q,ins) result (this)
        type(even)::this
        type(limits), intent(in) :: ins
        real, intent(in) :: q
        this%gk=>g1
        this%fj=>f1
        this%r=q
        this%instruc=ins
        this%parity = "par"
     end function seteven1


     function setneven1(q,ins) result (this)
        type(neven)::this
        type(limits), intent(in) :: ins
        real, intent(in) :: q
        this%gk=>g2
        this%fj=>f2
        this%r=q
        this%instruc=ins
        this%parity = "impar"
     end function setneven1
!---------------------------------------------!
!------------iteration funcs------------------!



!---------------------------------------------!
!---------------------------------------------!
!-------------------par-----------------------!
!---------------------------------------------!

    function fek1(this,i) result(c)
        class(even),intent(in) :: this
        integer, intent(in)   :: i
        type(vec2)      :: c
        if(i==0)then
            c=this%instruc%k_i
        else
            if(i==this%instruc%n - 1) then
                c=this%instruc%k_f
            
            else
                c=vec2(2*i,0.9999*(2*i+1))
            end if
        end if
    end function fek1


    function g1 (z) result (c)
        implicit none
        real*8,intent (in) :: z
        real*8           :: c
        c = tan(hpi*z)
    end function g1

    function f1 (z,handler) result (c)
        implicit none
    class(basis), intent(in), optional :: handler
        real*8,intent (in) :: z
        real*8          :: c,t
        t=sqrt(handler%r-z*z)
        c = t/z
    end function f1

!---------------------------------------------!
!---------------------------------------------!
!-------------------impar---------------------!
!---------------------------------------------!

    function fnek2(this,i) result(c)
        class(neven),intent(in) :: this
        integer, intent(in)   :: i
        type(vec2)      :: c
        if(i==0)then

            c=this%instruc%k_i
        else
            if(i==this%instruc%n - 1) then
                c=this%instruc%k_f
            
            else
                c=vec2((2*i+1),0.9999*(2*i+2))
            end if
        end if
    end function fnek2
  

    function g2 (z) result (c)
        implicit none
        real*8,intent (in) :: z
        real*8           :: c
        !c = (cos(hpi*z))/(sin(hpi*z))
        c=1/tan(hpi*z)
    end function g2

    function f2 (z,handler) result (c)
        implicit none
    class(basis), intent(in), optional :: handler
        real*8,intent (in) :: z
        real*8          :: c,t
        t=-sqrt(handler%r-z*z)
        c = t/z
    end function f2
!!------------------------------------------------------------------------------

!---------------!


     subroutine kill_tag(this)
        class(basis),intent(out)::this
        nullify(this%fj)
        nullify(this%gk)
        nullify(this%phi)
     end subroutine
     
    function aloc_e(n) result(c)
        type(energys) :: c
        integer, intent(in) :: n
        
        allocate(c%v(n))
        allocate(c%erro(n))
    end function
    subroutine dealo(this)
        class(energys), intent(out) :: this
        deallocate(this%v)
        deallocate(this%erro)
    end subroutine
end module base




!------------------------------------------------------!
