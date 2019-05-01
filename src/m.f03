subroutine fit_data(dataX, dataY)
    implicit none
    real, intent(in) :: dataX(:), dataY(:)
    real,allocatable :: out(:)
    integer          :: n
    print*, "qual ordem"
    read(*,*) n
    allocate(out(n+1))
    

    out = fit_polinomial (dataX, dataY, n)

    print*, out
end subroutine fit_data




subroutine plot()
    implicit none
    CALL SYSTEM ('gnuplot Input/styles/hg_tabis_energyGap.gp')
    CALL SYSTEM ('gnuplot Input/styles/ybco_hucker_energyGap.gp')
    CALL SYSTEM ('gnuplot Input/styles/ybco_blanco_energyGap.gp')
    CALL SYSTEM ('gnuplot Input/styles/lbco_hucker_energyGap.gp')
end subroutine plot


subroutine read_input()
    implicit none
    call LBCO_hucker%setCrystal('Input/LBCO-hucker.txt')
    Print*, LBCO_hucker%name, " Done!"
    call YBCO_hucker%setCrystal('Input/YBCO-hucker.txt')
    Print*, YBCO_hucker%name, " Done!"
    call YBCO_blanco%setCrystal('Input/YBCO-blanco.txt')
    Print*, YBCO_blanco%name, " Done!"
    call Hg_tabis%setCrystal('Input/Hg1201-tabis.txt')
    Print*, Hg_tabis%name, " Done!"
end subroutine read_input

subroutine analyze_data()
    implicit none

    call LBCO_hucker%setWells(v0)
    call intLBCO_hucker%set_analysis_data(LBCO_hucker,int_ord,int_ord,1,theta)
    call YBCO_hucker%setWells(v0)
    call intYBCO_hucker%set_analysis_data(YBCO_hucker,int_ord,int_ord,1,theta)
    call YBCO_blanco%setWells(v0)
    call intYBCO_blanco%set_analysis_data(YBCO_blanco,int_ord,int_ord,1,theta)
    call Hg_tabis%setWells(v0)
    call intHg_tabis%set_analysis_data(Hg_tabis,int_ord,int_ord,1,theta)

    Print*, "Done analysing data!"
end subroutine


subroutine display()
    implicit none
    call standartPrint(intLBCO_hucker,LBCO_hucker)
    call standartPrint(intYBCO_hucker,YBCO_hucker)
    call standartPrint(intYBCO_blanco,YBCO_blanco)
    call standartPrint(intHg_tabis,Hg_tabis)
end subroutine display

subroutine display_all()
    implicit none
    call detailPrint(intYBCO_hucker,YBCO_hucker,int_ord,theta)
    call detailPrint(intLBCO_hucker,LBCO_hucker,int_ord,theta)
    call detailPrint(intHg_tabis,Hg_tabis,int_ord,theta)
    call detailPrint(intYBCO_blanco,YBCO_blanco,int_ord,theta)
end subroutine display_all

subroutine print_to_file()
    implicit none
    
end subroutine print_to_file

subroutine print_help()
    implicit none
print *, ""
print *, "Comandos:"
print *, ""
print *, "quick                     Executa os comandos read_input e analyze em sequência"
print *, ""
print *, "read_input                Lê as informações sobre os cristais e suas CDW's"
print *, ""
print *, "analyze                   1) Calcula as auto-energias (E_n) de cada poço quadrado, definidos pelos comprimentos"
print *, "                             de correlação de cada CDW, e pelo seu potencial, para cada dopagem do cristal"
print *, "                          2) Calcula a interação BCS média, a diferença média das auto-energias, a variância"
Print *, "                              das diferenças de auto-energias e afins."
Print *, "                          3) Armazena as informações para uso futuro"
print *, ""
print *, "out_plot_data             Escreve as informações obtidas pelo comando set_interaction, necessárias para gerar"
print *, "                           os gráficos pelo gnuplot®. As saídas estão localizadas em Output/plotdata"
Print *, ""
print *, "plot                      Gera gráficos, utilizando as saídas obtidas pelo comando out_plot_data, executando"
print *, "                           o programa gnuplot® a partir das configurações contidas no arquivo style.gnu"
Print *, ""
print *, "display                   Escreve na tela as informações resumidas sobre os cristais analisado"
print *, ""
print *, "display_all               Escreve na tela as informações detalhadas sobre as informações obtidas em analyze"
print *, ""
print *, "print_to_file             Escreve as informações detalhadas em no arquivo resultados.dat"

end subroutine print_help

subroutine out_plot_data()
    call system('rm -r Output/plotdata/*')

call plot3DinFile(LBCO_hucker%dope,intLBCO_hucker%avgEnergyGap*1000,intLBCO_hucker%varEnergyGap*1000,'avgEnergyGap_LBCO_hucker.dat')
    
call plot3DinFile(YBCO_hucker%dope,intYBCO_hucker%avgEnergyGap*1000,intYBCO_hucker%varEnergyGap*1000,'avgEnergyGap_YBCO_hucker.dat')

call plot3DinFile(Hg_tabis%dope,intHg_tabis%avgEnergyGap*1000,intHg_tabis%varEnergyGap*1000,'avgEnergyGap_Hg_tabis.dat')

call plot3DinFile(YBCO_blanco%dope,intYBCO_blanco%avgEnergyGap*1000,intYBCO_blanco%varEnergyGap*1000,'avgEnergyGap_YBCO_blanco.dat')
!===========================================================================================================================================

    call plot2DinFile(LBCO_hucker%dope,intLBCO_hucker%topEnergyGap*1000,'topEnergyGap_LBCO_hucker.dat')
    
    call plot2DinFile(YBCO_hucker%dope,intYBCO_hucker%topEnergyGap*1000,'topEnergyGap_YBCO_hucker.dat')

    call plot2DinFile(Hg_tabis%dope,intHg_tabis%topEnergyGap*1000,'topEnergyGap_Hg_tabis.dat')

    call plot2DinFile(YBCO_blanco%dope,intYBCO_blanco%topEnergyGap*1000,'topEnergyGap_YBCO_blanco.dat')
!===========================================================================================================================================

    call plot2DinFile(LBCO_hucker%dope,intLBCO_hucker%bottomEnergyGap*1000,'bottomEnergyGap_LBCO_hucker.dat')
    
    call plot2DinFile(YBCO_hucker%dope,intYBCO_hucker%bottomEnergyGap*1000,'bottomEnergyGap_YBCO_hucker.dat')

    call plot2DinFile(Hg_tabis%dope,intHg_tabis%bottomEnergyGap*1000,'bottomEnergyGap_Hg_tabis.dat')

    call plot2DinFile(YBCO_blanco%dope,intYBCO_blanco%bottomEnergyGap*1000,'bottomEnergyGap_YBCO_blanco.dat')
!===========================================================================================================================================

    call plot2DinFile(LBCO_hucker%dope,intLBCO_hucker%avgInteraction*1000,'avgInteraction_LBCO_hucker.dat')
    
    call plot2DinFile(YBCO_hucker%dope,intYBCO_hucker%avgInteraction*1000,'avgInteraction_YBCO_hucker.dat')

    call plot2DinFile(Hg_tabis%dope,intHg_tabis%avgInteraction*1000,'avgInteraction_Hg_tabis.dat')

    call plot2DinFile(YBCO_blanco%dope,intYBCO_blanco%avgInteraction*1000,'avgInteraction_YBCO_blanco.dat')
!==========================================================================================================================================

end subroutine

subroutine finish()
    call intLBCO_hucker%dealoc()
    call intYBCO_hucker%dealoc()
    call intYBCO_blanco%dealoc()
    call intHg_tabis%dealoc()
    call LBCO_hucker%closeCrystal()
    call YBCO_hucker%closeCrystal()
    call YBCO_blanco%closeCrystal()
    call Hg_tabis%closeCrystal()

end subroutine  finish

subroutine quit()
    implicit none
    Print*, "============================================================================================"
    Print*, "====================================      BYE!!      ======================================="
    Print*, "============================================================================================"
    stop
end subroutine quit