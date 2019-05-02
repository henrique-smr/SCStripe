module IO

implicit none


type :: input_data_files

    character (len=32), dimension(:), allocatable  ::  manifest
!---------------------!
contains
!---------------------!
    procedure, public   :: create_input_manifest

end type input_data_files


contains

#include <../src/IO/create_input_manifest.f03>
    
end module IO