module physics

  use global
  
  implicit none

contains

  subroutine r_statistics()

    integer(8) :: i

    do i = 1, N
       rsqr(i) = dot_product(pos(:,i), pos(:,i))
       rsqrsqr(i) = (rsqr(i)**2) * sum_weight(i)
       rsqr(i) = rsqr(i) * sum_weight(i)
    end do

  end subroutine r_statistics

end module physics
