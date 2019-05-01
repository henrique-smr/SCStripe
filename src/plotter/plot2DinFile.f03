!---------------------------------------------------------------------------------------------------
!------- escreve duas colunas no arquivo indicado por 'F'. Cada coluna corresponde às matrizes x, y
!---------------------------------------------------------------------------------------------------
subroutine plot2DinFile(x,y,F)
    real*8, intent(in), dimension(:) :: y
    real, intent(in), dimension(:)   :: x
    character(*),intent(in)     :: F
    character(len=64)                :: path
    integer :: size_x, size_y,i
    size_x=size(x)
    size_y=size(y)
    write(path,'(A,A)') 'Output/plotdata/',F
    write(*,*)('OUTPUT:  '), (path)
    if(size_x /= size_y) then
        print*, "Discrepancia nos valores de entrada"
    else
        call system('mkdir -p Output/plotdata')
        open(unit=1, file=path ,position='append', action="write")
        do i=1,size_x
            write(1,*) x(i), y(i)
        end do
    end if
end subroutine