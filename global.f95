module global

  implicit none
    
    integer(8) :: N, N_RUNS
    real(8), allocatable :: pos(:,:)
    real(8) :: beta
    real(8), allocatable :: rsqr(:),rsqrsqr(:), sum_weight(:)

contains

    subroutine alloc_global

        N = 250
        N_RUNS = 10
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
    end subroutine

    subroutine init_vectors
        pos = 0._8
        pos(2,2) = 1._8      
    end subroutine init_vectors

end module
