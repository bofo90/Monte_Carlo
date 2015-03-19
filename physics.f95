module physics

  use global
  
  implicit none

contains

  subroutine r_statistics(N, position, weight)

    integer, intent(in) :: N
    real(8), intent(in) :: position(:), weight

    real(8) :: distance

    num_N_poly(N) = num_N_poly(N) + 1
    distance = dot_product(position,position)
    rsqrsqr(N) = rsqrsqr(N) + (distance**2) * weight
    rsqr(N) = rsqr(N) + distance * weight
    sum_weight(N) = sum_weight(N) + weight
    unweight_rsq(N) = unweight_rsq(N) + distance

  end subroutine r_statistics

  subroutine gyration_r()

  end subroutine gyration_r

end module physics
