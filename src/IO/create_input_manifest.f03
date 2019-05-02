subroutine create_input_manifest (this, directory_)
    implicit none
    class(input_data_files), intent(inout)  :: this
    character(len=100)                      :: buffer_
    character(*), intent(in)                :: directory_
    character(:),allocatable                :: manifest_
    integer                                 :: ios_=0
    integer                                 :: N_lines_
    integer                                 :: line_=0
    integer(kind=2), parameter              :: fn_ = 115

    manifest_ =  directory_//'/..'//'/manifest'

    write(buffer_,*) ('ls '//directory_//' > '//manifest_)
    
    call system(buffer_)

    open (fn_, file=manifest_, action='read', iostat=ios_)

    if (ios_ .ne. 0) then
        print*, "Não é possível abrir o arquivo ",manifest_
        
    else
        N_lines_ = 0

        do while (ios_==0)
            read(fn_,'(A)', iostat=ios_) buffer_
            N_lines_ = N_lines_ + 1
        enddo
        
        allocate (this%manifest(N_lines_ - 1))

        rewind(fn_)
        
        do line_ = 1, N_lines_ - 1
            read(fn_,'(A)',iostat = ios_) buffer_
            
            this%manifest(line_) = directory_//'/'//trim(adjustl(buffer_))
            print*, "Reading file: "//this%manifest(line_)
            
        enddo
        close(fn_) 

    end if
end subroutine