
module Analysis
    use crystalBase
    implicit none
    type :: intData
        real*8, allocatable :: bottomEnergyGap(:)
        real*8, allocatable :: topEnergyGap   (:)
        real*8, allocatable :: avgInteraction (:)
        real*8, allocatable :: avgEnergyGap   (:)
        real*8, allocatable :: varEnergyGap   (:)
        integer             :: size
    contains
        procedure, private        :: analize_fix_ord
        procedure, private        :: analize_fix_lev
        procedure, public,nopass  :: printVeff
        procedure, public         :: set_analysis_data
        procedure, public         :: dealoc
    end type intData    


contains
    
    subroutine set_analysis_data(this, cryst, i_int_ord, f_int_ord, startLevel, theta)
        class(intData), intent(inout)   :: this
        type(crystal), intent(in)       :: cryst
        integer, intent(in)             :: i_int_ord, f_int_ord, startLevel
        real, intent(in)                :: theta

        this%size  =  cryst%dataLEN
        allocate(this%avgInteraction(cryst%dataLEN))
        allocate(this%avgEnergyGap(cryst%dataLEN))
        allocate(this%varEnergyGap(cryst%dataLEN))
        allocate(this%topEnergyGap(cryst%dataLEN))
        allocate(this%bottomEnergyGap(cryst%dataLEN))

        call this%analize_fix_ord(cryst, i_int_ord, f_int_ord, startLevel, theta)
    end subroutine

    subroutine dealoc(this)
        class(intData), intent(inout)   :: this
        deallocate(this%bottomEnergyGap)
        deallocate(this%avgInteraction)
        deallocate(this%avgEnergyGap)
        deallocate(this%varEnergyGap)
        deallocate(this%topEnergyGap)
    end subroutine

    subroutine analize_fix_ord (this, cryst, i_int_ord, f_int_ord, startLevel, theta)
        class(intData), intent(inout)   :: this
        type(crystal), intent(in)       :: cryst
        integer, intent(in)             :: i_int_ord, f_int_ord, startLevel
        real, intent(in)                :: theta
        integer             :: i_, j_, k_, NTOTAL
        real*8              :: delta_e, in_, sum1_, sum2_, sum3_, top_, bottom_


        do i_ = 1, cryst%dataLEN
        sum2_ = 0
        sum1_ = 0
        sum3_ = 0
        delta_e = 0
        in_ = 0

            do j_=i_int_ord,f_int_ord
                do k_=startLevel, cryst%Nmax(i_)-j_
                     
                     if (((j_+k_) .le. size(cryst%well_E(i_)%E)) .and. (k_ .ge. 1)) then
                        
                        delta_e = cryst%well(i_, j_ + k_) - cryst%well(i_, k_)
                        in_ = theta/((delta_e**2 - theta**2 ))
                        sum1_ = sum1_ + delta_e
                        sum2_ = sum2_ + delta_e**2
                        sum3_ = sum3_ + in_ 
                    endif
                enddo
            enddo
            
            top_   = cryst%well(i_ , INT(cryst%Nmax(i_)) ) - cryst%well(i_, cryst%Nmax(i_) - 2)
            bottom_= cryst%well(i_ , 3) - cryst%well(i_, 1)
            
            NTOTAL= NINT(( cryst%Nmax(i_) - startLevel + 1 - (i_int_ord+f_int_ord)*0.5 )*( f_int_ord - i_int_ord + 1))
            sum3_ = sum3_/NTOTAL
            sum2_ = sum2_/NTOTAL
            sum1_ = sum1_/NTOTAL

            
            this%avgInteraction(i_) = sum3_
            this%avgEnergyGap(i_)   = sum1_
            this%varEnergyGap(i_)   = sqrt(sum2_ - sum1_**2)
            this%topEnergyGap(i_)   = top_
            this%bottomEnergyGap(i_)= bottom_
        end do
        Print*, "Calculating interaction between electrons..."
        print*, "Calculating the electrons average energy..." 
        print*, "Calculating the electrons average energy deviation..." 
        print*, "Calculating the electrons top energy gap..." 
        print*, cryst%name,(" Done!")

    end subroutine

    subroutine analize_fix_lev (this, cryst, i_int_level, f_int_level, startLevel, theta)
        class(intData), intent(inout)   :: this
        type(crystal), intent(in)       :: cryst
        integer, intent(in)             :: i_int_level, f_int_level, startLevel
        real, intent(in)                :: theta
        integer             :: i_, j_, k_, NTOTAL
        real*8              :: delta_e, in_, sum1_, sum2_, sum3_, top_



        do i_ = 1, cryst%dataLEN
            sum2_ = 0
            sum1_ = 0
            sum3_ = 0
            delta_e = 0
            in_ = 0
            do k_=i_int_level,f_int_level
                do j_=startLevel, cryst%Nmax(i_)-k_
                     
                     if (((j_+k_) .le. size(cryst%well_E(i_)%E)) .and. (k_ .ge. 1)) then
                        
                        delta_e = cryst%well(i_, j_ + k_) - cryst%well(i_, k_)
                        in_ = theta/((delta_e**2 - theta**2 ))
                        sum1_ = sum1_ + delta_e
                        sum2_ = sum2_ + delta_e**2
                        sum3_ = sum3_ + in_

                    endif

                enddo
            enddo
            NTOTAL= NINT(( cryst%Nmax(i_) - startLevel + 1 - (i_int_level+f_int_level)*0.5 )*( f_int_level - i_int_level + 1))

            top_ = cryst%well(i_, cryst%Nmax(i_) + 1) - cryst%well(i_, cryst%Nmax(i_) -1)

            sum3_ = sum3_/NTOTAL
            sum2_ = sum2_/NTOTAL
            sum1_ = sum1_/NTOTAL
            this%avgEnergyGap(i_)   = sum1_
            this%varEnergyGap(i_)   = sqrt(sum2_ - sum1_**2)
            this%avgInteraction(i_) = sum3_
            this%topEnergyGap(i_) = top_
        enddo

    end subroutine

    subroutine printVeff(cryst, i_int_ord, f_int_ord, startLevel, theta)
        implicit none
        integer, intent(in)        :: i_int_ord, f_int_ord, startLevel
        real, intent(in)           :: theta
        class(crystal), intent(in) :: cryst
        integer                    :: i_, j_, k_
        real*8                     :: delta_e, in_
        delta_e = 0
        in_ = 0
              

        do k_ = 1, cryst%dataLEN

            
            write(*,"(A29,F5.3,A26)") (' --------------------------  '),(cryst%dope(k_)),('--------------------------')
            write(*,*)               ('----------- ----------- ------------ -----------------------') !i1=1,npts_lbco)
            write(*,*)               ('     i     |     f     |      ΔE(eV)    |     Interação') !i1=1,npts_lbco)
            write(*,*)               ('----------- ----------- ---------------- -------------------') !i1=1,npts_lbco)

            do i_=i_int_ord, f_int_ord

                do j_=startLevel, cryst%Nmax(k_)-i_

                     if (((i_+j_) .le. size(cryst%well_E(k_)%E)) .and. (j_ .ge. 1)) then
                        delta_e = cryst%well(k_,i_+j_)-cryst%well(k_,j_)               
                        in_ = theta/((delta_e**2 - theta**2 ))
                        write(*, "(I7,A7,I5,A7,ES12.5,A5,EN15.5)")  j_,' | ', (i_+j_),' | ', delta_e,' | ', in_              
                    end if
                end do
            enddo
            write(*,*)               ('----------- ----------- ------------ -----------------------')
        enddo
    end subroutine

    subroutine standartPrint(data, cryst)
        type(intData), intent(in) :: data
        type(crystal), intent(in) :: cryst
        integer ::  i_
        integer :: dataLEN
        character(len=32) ::  fmt2, e_format

        dataLEN = data%size
        !-------------------------------------------------------------------------------------!
        !---------------------------------Formata as saidas-----------------------------------!
        !-------------------------------------------------------------------------------------!


        write(fmt2, '(A,I0,A,A)') '(A4,A33, ', dataLEN, '(F7.2, A5) ,', ')'
        write(e_format, '(A,I0,A)') '(5x,', dataLEN, '(EN12.4,A))'


        !------------------------------------------------------------------------------------!
        !-------------------------------Imprime as informações ------------------------------!
        !------------------------------------------------------------------------------------!

        call cryst%printCrystalData()

        write(*,fmt2)     "    ",'Interação (eV)               |  ',  (data%avgInteraction(i_),"  | ",   i_=1,dataLEN)
        print*, ""
        write(*,fmt2)     "    ",'〈 ΔE 〉(meV)                 |  ',  (data%avgEnergyGap(i_)*1000 ," | ",  i_ = 1, dataLEN )
        print*, ""
        write(*,fmt2)     "    ",'σ²(ΔE) (meV)                 |  ',  (data%varEnergyGap(i_)*1000 ," | ",  i_ = 1, dataLEN )
        print*, ""
        print*, ""

    end subroutine
    subroutine detailPrint(data, cryst, int_ord, theta)
        type(intData), intent(in) :: data
        type(crystal), intent(in) :: cryst
        integer,intent(in)        :: int_ord
        real, intent(in)          :: theta
        integer ::  i_
        integer :: dataLEN
        character(len=32) ::  fmt2, e_format

        dataLEN = data%size
        !-------------------------------------------------------------------------------------!
        !---------------------------------Formata as saidas-----------------------------------!
        !-------------------------------------------------------------------------------------!


        write(fmt2, '(A,I0,A,A)') '(A4,A33, ', dataLEN, '(F7.2, A5) ,', ')'
        write(e_format, '(A,I0,A)') '(5x,', dataLEN, '(EN12.4,A))'


        !------------------------------------------------------------------------------------!
        !-------------------------------Imprime as informações ------------------------------!
        !------------------------------------------------------------------------------------!

        call cryst%printCrystalData()

        write(*,fmt2)     "    ",'Interação (eV)               |  ',  (data%avgInteraction(i_),"  | ",   i_=1,dataLEN)
        print*, ""
        write(*,fmt2)     "    ",'〈 ΔE 〉(meV)               |  ',  (data%avgEnergyGap(i_)*1000 ," | ",  i_ = 1, dataLEN )
        print*, ""
        write(*,fmt2)     "    ",'σ²(ΔE) (meV)               |  ',  (data%varEnergyGap(i_)*1000 ," | ",  i_ = 1, dataLEN )
        print*, ""
        print*, ""
        print*, ""
        Write(*,*) "--------------------------------------Detalhes------------------------------------------------"
        print*, ""
        print*, ""
        call printVeff(cryst, int_ord, int_ord, 1, theta)!Nmax_lbco( i6) - (delta_n-1))

    end subroutine
end module Analysis