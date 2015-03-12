module growing

  use global
  use monte_carlo

  implicit none

contains

  subroutine chain_grow()
    
    real(8) :: pol_weight = 1
    integer :: L = 3

    call add_bead(pos, pol_weight, L)

  end subroutine chain_grow


  recursive subroutine add_bead(position, pol_weight, pos_now)

    real(8), intent(inout) :: position(:,:)
    real(8), intent(inout) :: pol_weight
    integer, intent(in) :: pos_now

    real(8) :: new_weight, new_pos(2)

    call weight_calc(position, pos_now, new_weight, new_pos)

    position(:,pos_now) = new_pos
    pol_weight = pol_weight * new_weight

    if (pos_now < N) then
       call add_bead(position, pol_weight, pos_now+1)
    end if

  end subroutine add_bead

end module
