module growing

  use global
  use monte_carlo
  use physics
  use output_file

  implicit none

contains

  subroutine chain_grow(i, perm)

    integer(8), intent(in) :: i
    logical, intent(in) :: perm

    real(8) :: pol_weight
    real(8) :: pos(3,N)
    integer :: L, N_PERM

    ! Runs of the RR algorithm before starting PERM
    N_PERM = 50

    pos = 0._8
    pos(1,2) = 1._8
    pol_weight = 1._8
    L = 3
    if (perm .AND. i > N_PERM) then
      call add_bead(pos, pol_weight, L, .TRUE.)
    else
      call add_bead(pos, pol_weight, L, .FALSE.)
    end if

    ! Check the positions of the first polymers
    if (i<7 .AND. .NOT. perm) then
      call write_pos(pos)
    end if
  end subroutine chain_grow


  recursive subroutine add_bead(position, pol_weight, pos_now, perm)

    real(8), intent(inout) :: position(:,:)
    real(8), intent(inout) :: pol_weight
    integer, intent(in) :: pos_now
    logical, intent(in) :: perm

    real(8) :: new_weight, new_pos(3)
    real(8) :: up_limit, low_limit
    real(8) :: random

    call weight_calc(position, pos_now, new_weight, new_pos)

    position(:,pos_now) = new_pos
    pol_weight = pol_weight * new_weight
    call r_statistics(pos_now, position, pol_weight)
    call up_and_low_limit_calc(pos_now, up_limit, low_limit)
    if (perm) then
      if (pos_now < N .and. pol_weight > 0) then
        if (pol_weight > up_limit) then
          pol_weight = pol_weight * 0.5
          call add_bead(position, pol_weight, pos_now+1, perm)
          call add_bead(position, pol_weight, pos_now+1, perm)
        else if(pol_weight < low_limit) then
          call init_random_seed
          call random_number(random)
          if(random < 0.5_8) then
             pol_weight = pol_weight * 2
             call add_bead(position, pol_weight, pos_now+1, perm)
          end if
        else
          call add_bead(position, pol_weight, pos_now+1, perm)
        end if
      else
        if(pos_now == N .AND. num_N_poly(pos_now) < 6) then
          call write_pos(position)
        else
        end if
      end if
    else
      if (pol_weight > 0._8 .AND. pos_now < N) then
        call add_bead(position, pol_weight, pos_now+1, perm)
      end if
    end if

  end subroutine add_bead

  subroutine up_and_low_limit_calc(pos_now, up_limit, low_limit)

    real(8), intent(out) :: up_limit, low_limit
    integer, intent(in) :: pos_now
    real(8), parameter :: alpha_low = 0.1, alpha_up = 5
    real(8) :: weight_avg

    if (num_N_poly(pos_now) .GE. 5) then
      weight_avg = sum_weight(pos_now)/num_N_poly(pos_now)
      up_limit = alpha_up * weight_avg
      low_limit = alpha_low * weight_avg
    else
      ! set limits such as to run RR
      up_limit = 1d100
      low_limit = 0
    end if

  end subroutine up_and_low_limit_calc

end module
