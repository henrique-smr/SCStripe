!-------------------------------------------------------------------------------------------------------
!------- escreve três colunas no arquivo indicado por 'F'. Cada coluna corresponde às matrizes x, y, z
!-------------------------------------------------------------------------------------------------------
subroutine plot3DinFile(x,y,z,F)
    real*8, intent(in), dimension(:) :: y,z
    real  , intent(in), dimension(:) :: x
    character(*),intent(in)     :: F
    character(len=200)                :: path
    integer :: size_x, size_y,size_z,i
    size_x=size(x)
    size_y=size(y)
    size_z=size(z)
    write(path,'(A,A)') 'Output/plotdata/',F
    write(*,*)('OUTPUT:  '), (path)
    if(size_x /= size_y .or. size_x /= size_z .or. size_z /= size_y ) then
        print*, "Discrepancia nos valores de entrada"
    else
        call system('mkdir -p Output/plotdata')
        open(unit=1, file=path ,position='append', action="write")
        do i=1,size_x
            write(1,*) x(i), y(i), z(i)
        end do
    end if
end subroutine