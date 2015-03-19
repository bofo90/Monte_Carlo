module global

  implicit none
    
    integer(8) :: N
    real(8), allocatable :: pos(:,:)
    real(8) :: beta
    real(8), allocatable :: rsqr(:),rsqrsqr(:), sum_weight(:)

contains

    subroutine init_global

        N = 100
        beta = 1._8
        allocate(pos(2,N))
        allocate(rsqr(N))
        allocate(rsqrsqr(N))
        allocate(sum_weight(N))
        rsqr = 0._8
        rsqrsqr = 0._8
        sum_weight = 0._8
        sum_weight(1) = 1
        sum_weight(2) = 1
        pos = 0._8
        pos(2,2) = 1._8

    end subroutine


end module
