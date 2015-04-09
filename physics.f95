module physics

  use global
  
  implicit none

contains

  subroutine r_statistics(pos_now, position, weight)

    integer, intent(in) :: pos_now
    real(8), intent(in) :: position(:,:), weight

    real(8) :: distance
    real(8) :: r_mean(3)

    if(weight > 0._8) then
       num_N_poly(pos_now) = num_N_poly(pos_now) + 1
       distance = dot_product(position(:,pos_now),position(:,pos_now))
       rsqrsqr(pos_now) = rsqrsqr(pos_now) + (distance**2) * weight
       rsqr(pos_now) = rsqr(pos_now) + distance * weight
       sum_weight(pos_now) = sum_weight(pos_now) + weight
       
       r_mean = sum(position(:,:pos_now), dim=2)/pos_now
       sum_r_mean(pos_now) = sum_r_mean(pos_now) + dot_product(r_mean, r_mean) * weight
    end if

  end subroutine r_statistics

end module physics
