include 'IO.f03'

program teste
use IO
implicit none

type(input_data_files)   ::  input_files

call input_files%create_input_manifest('Input/data')



end program
