module physics

  use global
  
  implicit none

contains

  subroutine r_statistics(N, position, weight)

    integer, intent(in) :: N
    real(8), intent(in) :: position(:), weight

    integer(8) :: i
    real(8) :: distance

    distance = dot_product(position,position)
    rsqrsqr(N) = rsqrsqr(N) + (distance**2) * weight
    rsqr(N) = rsqr(N) + distance * weight
    sum_weight(N) = sum_weight(N) + weight

  end subroutine r_statistics

  subroutine gyration_r()

  end subroutine gyration_r

end module physics
