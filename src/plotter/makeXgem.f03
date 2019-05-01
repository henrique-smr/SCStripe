function makeXgem(x_start,x_end,n) result(x)
    integer, intent(in)  :: n!number of points
    real*8, dimension(n) :: x!vetor de valores
    integer              :: i!contador
    real*8               :: x_start,x_end,dx!respectivamente : intervalo total da gema, incremento dx

    dx = (x_end - x_start)/n
    x(1:n) = [(x_start + i*dx, i=0, n)]


end function makeXgem