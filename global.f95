module global

  implicit none
    
    integer(8) :: N, N_RUNS
    real(8), allocatable :: pos(:,:)
    real(8) :: beta
    real(8), allocatable :: rsqr(:),rsqrsqr(:), sum_weight(:)
    integer, allocatable :: num_N_poly(:)
    real(8), allocatable :: unweight_rsq(:)

contains

    subroutine alloc_global

        N = 250
        N_RUNS = 1000
        beta = 1._8
        allocate(pos(2,N))
        allocate(rsqr(N))
        allocate(rsqrsqr(N))
        allocate(sum_weight(N))
        allocate(num_N_poly(N))
        allocate(unweight_rsq(N))
        rsqr = 0._8
        rsqrsqr = 0._8
        sum_weight = 0._8
        num_N_poly = 0
        unweight_rsq = 0._8
    end subroutine

    subroutine init_vectors
        pos = 0._8
        pos(2,2) = 1._8 
        rsqr(1) = rsqr(1) + 0
        rsqrsqr(1) = rsqrsqr(1) + 0**2
        sum_weight(1) = sum_weight(1) + 1   
        num_N_poly(1) = num_N_poly(1) + 1
        rsqr(2) = rsqr(2) + 1
        rsqrsqr(2) = rsqrsqr(2) + 1**2
        sum_weight(2) = sum_weight(2) + 1
        num_N_poly(2) = num_N_poly(2) + 1
    end subroutine init_vectors

end module
