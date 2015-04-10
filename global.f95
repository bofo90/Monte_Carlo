module global

  implicit none
    
    integer(8) :: N, N_POLY
    real(8) :: beta
    real(8), allocatable :: sum_r_mean(:), rsqr(:), rsqrsqr(:)
    real(8), allocatable :: sum_weight(:)
    integer, allocatable :: num_N_poly(:)

contains

    subroutine alloc_global(beta_in)

        real(8), intent(in) :: beta_in

        ! Number of beads 
        N = 250

        ! Number of polymers
        N_POLY = 1000
        ! Temperature (defined as the beta = 1/kT)
        beta = beta_in

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

    subroutine dealloc_global
        
        ! Allocation of the vectors
        deallocate(sum_r_mean)
        deallocate(rsqr)
        deallocate(rsqrsqr)
        deallocate(sum_weight)
        deallocate(num_N_poly)

    end subroutine dealloc_global

end module
