module linear_system
    

contains

function cramer (M, v_0) result (v)
    real, dimension (:,:), intent (in)  :: M
    real, dimension (:,:,:), allocatable  :: Mrow
    real, dimension (:), intent(in)     :: v_0
    real, dimension (:), allocatable    :: v
    integer                             :: i,j, dataSize
    real                                :: det1
    dataSize = size (v_0)


    allocate(v(dataSize), Mrow(dataSize,dataSize,dataSize))

    det1 = determinant(M)

    do i = 1, dataSize
        Mrow(i,:,:) = M(:,:)
        Mrow(i,:,i) =  v_0(:)
    enddo

    do j = 1, dataSize
        v(j) = (determinant( Mrow(j,:,:)))/det1
    end do
end function

real function determinant(matrix)
    implicit none
    real, dimension(:,:), intent(in)  :: matrix
    real, dimension(:,:), allocatable :: A
    real                              :: m
    integer :: i, j, k, n


    !convert to upper triangular form
    n = size(matrix(1,:))

    allocate(A(n,n))

    A = matrix

    do k = 1, n-1
        do j = k+1, n
            m = A(j,k)/A(k,k)
            do i = k+1, n
                A(j,i) = A(j,i) - m*A(k,i)
            end do
        end do
    end do
   
    !calculate determinant by finding product of diagonal elements
    determinant = 1
    do i = 1, n
        determinant = determinant * A(i,i)
    end do
   
end function determinant

end module linear_system