module global

  implicit none
    
    integer(8) :: N, N_RUNS
    real(8) :: beta
    real(8), allocatable :: sum_r_mean(:), rsqr(:), rsqrsqr(:)
    real(8), allocatable :: sum_weight(:)
    integer, allocatable :: num_N_poly(:)

contains

    subroutine alloc_global

        N = 250
        N_RUNS = 10
        beta = 1._8
        allocate(sum_r_mean(N))
        allocate(rsqr(N))
        allocate(rsqrsqr(N))
        allocate(sum_weight(N))
        allocate(num_N_poly(N))
        sum_r_mean = 0._8
        rsqr = 0._8
        rsqrsqr = 0._8
        sum_weight = 0._8
        num_N_poly = 0
    end subroutine

    subroutine init_vectors
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
