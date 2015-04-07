module global

  implicit none
    
    integer(8) :: N, N_POLY
    real(8) :: beta
    real(8), allocatable :: sum_r_mean(:), rsqr(:), rsqrsqr(:)
    real(8), allocatable :: sum_weight(:)
    integer, allocatable :: num_N_poly(:)

contains

    subroutine alloc_global

        ! Number of beads 
        N = 250
        ! Number of polymers in case of PERM
        N_POLY = 1000
        ! Temperature (defined as the beta = 1/kT)
        beta = 1._8

        ! Allocation of the vectors
        allocate(sum_r_mean(N))
        allocate(rsqr(N))
        allocate(rsqrsqr(N))
        allocate(sum_weight(N))
        allocate(num_N_poly(N))

        ! Initialization of the vectors
        sum_r_mean = 0._8
        rsqr = 0._8
        rsqrsqr = 0._8
        sum_weight = 0._8
        num_N_poly = 0

    end subroutine

    subroutine init_vectors

        ! Initialize the vectors, as beads 1 and 2 are fixed
        rsqr(1) = rsqr(1) + 0
        sum_weight(1) = sum_weight(1) + 1   
        num_N_poly(1) = num_N_poly(1) + 1

        rsqr(2) = rsqr(2) + 1
        rsqrsqr(2) = rsqrsqr(2) + 1
        sum_weight(2) = sum_weight(2) + 1
        num_N_poly(2) = num_N_poly(2) + 1
    end subroutine init_vectors

end module
