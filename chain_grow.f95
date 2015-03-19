module growing

  use global
  use monte_carlo
  use physics

  implicit none

 ! real(8) :: tot_weight(2, N)


contains

  subroutine chain_grow()
    
    real(8) :: pol_weight = 1
    integer :: L = 3

   ! tot_weight = 0._8
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
    sum_weight(pos_now) = sum_weight(pos_now) + pol_weight

    if (pos_now < N .AND. pol_weight > 0._8) then
       call add_bead(position, pol_weight, pos_now+1)
       ! putt it on file
    else
      print *, pos_now, pol_weight
    end if

  end subroutine add_bead

end module
