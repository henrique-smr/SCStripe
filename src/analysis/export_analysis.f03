subroutine export_analysis(this, path)
    implicit none
    class (intData),intent(in)  :: this
    character(*)               :: path

    call plot2DinFile(this%crystal%dope,this%avgEnergyGap*1000, trim(path//'avgEnergyGap-'//this%crystal%name)//'.dat')
    call plot2DinFile(this%crystal%dope,this%varEnergyGap*1000, path//'varEnergyGap-'//this%crystal%name//'.dat')
    call plot2DinFile(this%crystal%dope,this%topEnergyGap*1000, path//'topEnergyGap-'//this%crystal%name//'.dat')
    call plot2DinFile(this%crystal%dope,this%bottomEnergyGap*1000, path//'bottomEnergyGap-'//this%crystal%name//'.dat')
    call plot2DinFile(this%crystal%dope,this%avgInteraction*1000, path//'avgInteraction-'//this%crystal%name//'.dat')

contains

#include <../src/plotter/plot2DinFile.f03>
    
end subroutine export_analysis










