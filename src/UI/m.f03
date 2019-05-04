
subroutine read_input()
    implicit none
    call input_files%create_input_manifest('Input/data')
    Print*, " Done!"
end subroutine read_input

subroutine set_data()
    implicit none
    integer ::  i_, size_
    size_ = size(input_files%manifest)

    allocate (DATA(size_))
    do i_ = 1, size_
        call DATA(i_)%set_analysis_data(input_files%manifest(i_), v0, theta)
    end do
    
end subroutine set_data

subroutine display()
    implicit none
    integer ::  i_, size_

    size_ = size(input_files%manifest)
    do i_ = 1, size_
        call DATA(i_)%standartPrint()
    end do
end subroutine display

subroutine display_all()
    implicit none
    integer ::  i_, size_

    size_ = size(input_files%manifest)
    do i_ = 1, size_
        call DATA(i_)%detailPrint(int_ord, theta)
    end do
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
print *, "set_data                  1) Calcula as auto-energias (E_n) de cada poço quadrado, definidos pelos comprimentos"
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

subroutine export()
    implicit none
    integer ::  i_, size_
    call system('rm -r Output/plotdata/*')

    size_ = size(input_files%manifest)
    do i_ = 1, size_
        call DATA(i_)%export_analysis('Output/plotdata')
    end do    
end subroutine

subroutine plot()
    implicit none
    CALL SYSTEM ('gnuplot Input/styles/hg_tabis_energyGap.gp')
    CALL SYSTEM ('gnuplot Input/styles/ybco_hucker_energyGap.gp')
    CALL SYSTEM ('gnuplot Input/styles/ybco_blanco_energyGap.gp')
    CALL SYSTEM ('gnuplot Input/styles/lbco_hucker_energyGap.gp')
    CALL SYSTEM ('gnuplot Input/styles/LBCO-YBCO_hucker_interaction.gp')
    CALL SYSTEM ('gnuplot Input/styles/LBCO-YBCO_canosa_interaction.gp')
end subroutine plot

subroutine finish()
    implicit none
    integer ::  i_, size_

    size_ = size(input_files%manifest)
    do i_ = 1, size_
        call DATA(i_)%closeData()
    end do  
end subroutine  finish

subroutine quit()
    implicit none
    Print*, "============================================================================================"
    Print*, "====================================      BYE!!      ======================================="
    Print*, "============================================================================================"
    stop
end subroutine quit