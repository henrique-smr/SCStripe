!-----------------------------------------------------------------------------------
! Tem as mesmas entradas do que o método set_analysis_data.
! Calcula o gap médio de energia, para um poço quadrado, indo da ordem de diferença i_int_ord até f_int_ord
! Calcula a interação BCS média para uma quasipartícula que se acopla com os elétrons, de energia theta
! calcula o gap de topo e o gap mais baixo do poço quadrado referente à um comprimento de correlação, conservando a simetria da função de onda dos elétrons
!-----------------------------------------------------------------------------------


subroutine analize_fix_ord (this, theta, i_int_ord, f_int_ord, startLevel)
    class(intData), intent(inout)   :: this
    !type(crystal), intent(in)       :: cryst
    integer, intent(in)             :: i_int_ord, f_int_ord, startLevel
    real, intent(in)                :: theta
    integer                         :: i_, j_, k_, NTOTAL
    real*8                          :: delta_e, in_, sum1_, sum2_, sum3_, top_, bottom_


    do i_ = 1, this%size
    sum2_ = 0
    sum1_ = 0
    sum3_ = 0
    delta_e = 0
    in_ = 0

        do j_=i_int_ord,f_int_ord
            do k_=startLevel, this%crystal%Nmax(i_)-j_
                 
                 if (((j_+k_) .le. size(this%crystal%well_E(i_)%E)) .and. (k_ .ge. 1)) then
                    
                    delta_e = this%crystal%well(i_, j_ + k_) - this%crystal%well(i_, k_)
                    in_ = theta/((delta_e**2 - theta**2 ))
                    sum1_ = sum1_ + delta_e
                    sum2_ = sum2_ + delta_e**2
                    sum3_ = sum3_ + in_ 
                endif
            enddo
        enddo
        
        top_   = this%crystal%well(i_ , INT(this%crystal%Nmax(i_)) ) - this%crystal%well(i_, this%crystal%Nmax(i_) - 2)
        bottom_= this%crystal%well(i_ , 3) - this%crystal%well(i_, 1)
        
        NTOTAL= NINT(( this%crystal%Nmax(i_) - startLevel + 1 - (i_int_ord+f_int_ord)*0.5 )*( f_int_ord - i_int_ord + 1))
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
    print*, this%crystal%name,(" Done!")

end subroutine