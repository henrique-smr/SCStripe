!---------------------------------------------------------------------------------------------------------------------------------------
!----interpola uma tabela nX2, 'data', pelo método de legendre, com numero de pontos 'numOfPoints' e retorna uma tabela numOfPoints X 2
!---------------------------------------------------------------------------------------------------------------------------------------
function LegendreInterpolation (data_,numOfPoints) result(result)
        implicit none        

        real*8, intent(in), dimension(:,:) :: data_  !contem os dados (xi,yi)
        integer, intent(in)              :: numOfPoints
        real*8,                          :: result(numOfPoints,2)
        real*8, allocatable              :: ItpL(:)
        real                             :: x, dx_
        real*8                           :: q
        integer                          :: i_,j_,N!=size(data_)


        N = NINT(size(data_)*0.5)

        allocate(ItpL(N))    
        dx_= real(abs(data_(N,1) - data_(1,1))/numOfPoints)
        x=real(data_(1,1) - dx_)

        do i_= 1, numOfPoints         
              x = x + dx_  
              q=0         
             do j_=1,N
                q = q + data_(j_,2)*Lj(data_(:,1),j_,x)
             end do           
             result(i,1)  x 
             result(i,2)  q
        end do
end function
function LJ (data_,i,x) result(r_)
        implicit none        
        integer, intent(in)              :: i
        real*8, intent(in), dimension(:) :: data_  !contem os dados (xi,yi)
        real*8                           :: r_
        real                             :: x
        real*8                           :: prod
        integer                          :: k,N

        N = size(data_)

        prod = 1
        do  k=1,N
            if (k .ne. i) then
               prod = prod*( (x - data_(k))/(data_(i)-data_(k)) )
               
            end if                  
        enddo
        r_=prod
end function