 !-----------------------------------------------------------------------------------
! Tem as mesmas entradas do que o método set_analysis_data.
! Calcula o gap médio de energia, para um poço quadrado, variando o nível de referência, indo do nível i_int_level até f_int_level
! Calcula a interação BCS média para uma quasipartícula que se acopla com os elétrons, de energia theta
! calcula o gap de topo e o gap mais baixo do poço quadrado referente à um comprimento de correlação, conservando a simetria da função de onda dos elétrons
!-----------------------------------------------------------------------------------

    subroutine analize_fix_level (this, cryst, i_int_level, f_int_level, startLevel, theta)
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