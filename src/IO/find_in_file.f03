!------------------------------------------------------------------------------------------------
!--------Busca no arquivo 'file' a identificação 'label' e retorna o valor correnspondente-------
!------------------------------------------------------------------------------------------------

function find_in_file(file_, label_) result(result)
    character(len=100)            :: id, result
    character(*), intent(in)      :: label_, file_    
    character(len=100)            :: buffer_
    integer                       :: ios_=0
    integer                       :: pos_
    integer                       :: line_=0
    integer(kind=2), parameter    :: fn_ = 115
    open (fn_, file=file_, iostat=ios_)
    
    rewind(fn_)

    if (ios_ .ne. 0) then
        print*, "Não é possível abrir o arquivo ",file_
    else
        do while (ios_==0)
            read(fn_,'(A)', iostat=ios_) buffer_            
            line_ = line_ + 1
            !Encontrar a igualdade '='
            pos_ = scan(buffer_,'=')
            id = buffer_(1:pos_-1)
            buffer_ = buffer_(pos_+1:)

            if(id == label_) then
                result = trim(adjustl(buffer_))
                close(fn_)
                return
            end if
        enddo
        close(fn_)
        print *, "Label '", label_, "' not find!"
        print*, "Stoping program to prevent memory mismatch"
        stop
    end if


end function