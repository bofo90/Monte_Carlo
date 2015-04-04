module growing

  use global
  use monte_carlo
  use physics
  use output_file

  implicit none

 ! real(8) :: tot_weight(2, N)


contains

  subroutine chain_grow()

    real(8) :: pol_weight
    real(8) :: pos(3,N)
    integer :: L = 3

   ! tot_weight = 0._8
    pos = 0._8
    pos(1,2) = 1._8
    pol_weight = 1._8
    call add_bead(pos, pol_weight, L)

  end subroutine chain_grow


  recursive subroutine add_bead(position, pol_weight, pos_now)

    real(8), intent(inout) :: position(:,:)
    real(8), intent(in) :: pol_weight
    integer, intent(in) :: pos_now

    real(8) :: new_weight, new_pos(3)
    real(8) :: up_limit, low_limit
    real(8) :: random

    call weight_calc(position, pos_now, new_weight, new_pos)

    position(:,pos_now) = new_pos
    new_weight = pol_weight * new_weight

    call r_statistics(pos_now, position, new_weight)
    call up_and_low_limit_calc(up_limit, low_limit, pos_now)
    print*, pos_now, new_weight, low_limit, up_limit
    if (pos_now < N) then
       if (new_weight /= up_limit) then
          !print*, "      live bitch"
          new_weight = new_weight * 0.5
          call add_bead(position, new_weight, pos_now+1)
          call add_bead(position, new_weight, pos_now+1)
!!$       else if(new_weight < low_limit) then
!!$          call random_number(random)
!!$          if(random < 0.5_8) then
!!$             !print*, "   die bitch"
!!$             new_weight = new_weight * 2
!!$             call add_bead(position, new_weight, pos_now+1)
!!$          end if
       else
          print*, "algo esta mal"
          call add_bead(position, new_weight, pos_now+1)
       end if
    else
       call write_pos(position)
       print*, "chain nr", num_N_poly(pos_now)
    end if
    
  end subroutine add_bead

end module
