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
    call intLBCO_hucker%set_analysis_data('Input/LBCO-hucker.txt', v0, theta)
    call intYBCO_hucker%set_analysis_data('Input/YBCO-hucker.txt', v0, theta)
    call intYBCO_blanco%set_analysis_data('Input/YBCO-blanco.txt', v0, theta)
    call intHg_tabis%set_analysis_data('Input/Hg1201-tabis.txt', v0, theta)
    Print*, " Done!"
end subroutine read_input

subroutine display()
    implicit none
    call intLBCO_hucker%standartPrint()
    call intYBCO_hucker%standartPrint()
    call intYBCO_blanco%standartPrint()
    call intHg_tabis%standartPrint()
end subroutine display

subroutine display_all()
    implicit none
    call intLBCO_hucker%detailPrint(int_ord,theta)
    call intYBCO_hucker%detailPrint(int_ord,theta)
    call intYBCO_blanco%detailPrint(int_ord,theta)
    call intHg_tabis%detailPrint(int_ord,theta)
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
    call intLBCO_hucker%export_analysis('Output/plotdata/')
    call intYBCO_hucker%export_analysis('Output/plotdata/')
    call intHg_tabis%export_analysis('Output/plotdata/')
    call intYBCO_blanco%export_analysis('Output/plotdata/')

end subroutine

subroutine finish()
    call intLBCO_hucker%closeData()
    call intYBCO_hucker%closeData()
    call intYBCO_blanco%closeData()
    call intHg_tabis%closeData()

end subroutine  finish

subroutine quit()
    implicit none
    Print*, "============================================================================================"
    Print*, "====================================      BYE!!      ======================================="
    Print*, "============================================================================================"
    stop
end subroutine quit