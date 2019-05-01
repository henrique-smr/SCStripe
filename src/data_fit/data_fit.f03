

module data_fit
    use linear_system


    implicit none


contains

    function fit_polinomial (dataX, dataY, order) result (data_out)
        real, dimension (:), intent(in)     :: dataX, dataY
        integer, intent(in)                 :: order
        integer                             :: data_size, matrix_order, i, j
        real, dimension(order+1)            :: data_out
        real, dimension(:,:), allocatable   :: A
        real, dimension(:), allocatable     :: b

        data_size = size(dataX)
        matrix_order = order + 1
        allocate(A(matrix_order, matrix_order), b(matrix_order))


        do i = 1, matrix_order
            do j = 1, matrix_order
                    A(i,j) = sum( (dataX**(j-1))*(dataX**(i-1)) )
            end do
        end do
        do i =1, matrix_order
            b(i) = sum((dataX**(i-1))*dataY)
        enddo

        data_out = cramer(A,b)

    end function


end module data_fit