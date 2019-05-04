subroutine export_analysis(this, path)
    implicit none
    class (intData),intent(in)  :: this
    character(*), intent(in)    :: path

    call system("mkdir -p '"//path//'/'//this%crystal%name//"'")
    
    call plot2DinFile(this%crystal%dope,this%avgEnergyGap*1000,     trim(path//'/'//this%crystal%name)//'/'//'avgEnergyGap.dat')
    call plot2DinFile(this%crystal%dope,this%varEnergyGap*1000,     trim(path//'/'//this%crystal%name)//'/'//'varEnergyGap.dat')
    call plot2DinFile(this%crystal%dope,this%topEnergyGap*1000,     trim(path//'/'//this%crystal%name)//'/'//'topEnergyGap.dat')
    call plot2DinFile(this%crystal%dope,this%bottomEnergyGap*1000,  trim(path//'/'//this%crystal%name)//'/'//'bottomEnergyGap.dat')
    call plot2DinFile(this%crystal%dope,this%avgInteraction,   trim(path//'/'//this%crystal%name)//'/'//'avgInteraction.dat')

contains

#include <../src/plotter/plot2DinFile.f03>
    
end subroutine export_analysis










