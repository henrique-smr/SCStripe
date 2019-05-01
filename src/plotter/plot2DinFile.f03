!---------------------------------------------------------------------------------------------------
!------- escreve duas colunas no arquivo indicado por 'F'. Cada coluna corresponde às matrizes x, y
!---------------------------------------------------------------------------------------------------
subroutine plot2DinFile(x,y,file_)
    real*8, intent(in), dimension(:) :: y
    real, intent(in), dimension(:)   :: x
    character(*),intent(in)     :: file_
    integer :: size_x, size_y,i
    size_x=size(x)
    size_y=size(y)
    if(size_x /= size_y) then
        print*, "Discrepancia nos valores de entrada"
    else
        print*, "OUTPUT "//file_ 
        open(unit=1, file=file_ ,position='append', action="write")
        do i=1,size_x
            write(1,*) x(i), y(i)
        end do
    end if
end subroutine