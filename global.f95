module global
    
    integer(8) :: N
    real(8), allocatable :: pos(:,:)
    real(8) :: beta

contains

    subroutine init_global

        N = 100
        beta = 1
        allocate(pos(2,N))
        pos = 0
        pos(2,2) = 1

    end subroutine


end module