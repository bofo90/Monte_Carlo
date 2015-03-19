module physics

  use global
  
  implicit none

contains

  subroutine r_statistics()

    integer :: i

    do i = 1, N
       rsqr(N) = dot_product(pos(:,N), pos(:,N))
       rsqrsqr(N) = (rsqr(N)**2) * sum_weight(N)
       rsqr(N) = rsqr(N) * sum_weight(N)
    end do

  end subroutine r_statistics

end module physics