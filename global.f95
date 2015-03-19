module global

  implicit none
    
    integer(8) :: N
    real(8), allocatable :: pos(:,:)
    real(8) :: beta

contains

    subroutine init_global

        N = 250
        beta = 1._8
        allocate(pos(2,N))
        pos = 0._8
        pos(2,2) = 1._8

    end subroutine


end module
