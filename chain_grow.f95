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

    call write_pos(pos)
  end subroutine chain_grow


  recursive subroutine add_bead(position, pol_weight, pos_now)

    real(8), intent(inout) :: position(:,:)
    real(8), intent(inout) :: pol_weight
    integer, intent(in) :: pos_now

    real(8) :: new_weight, new_pos(3)

    call weight_calc(position, pos_now, new_weight, new_pos)

    position(:,pos_now) = new_pos
    pol_weight = pol_weight * new_weight
    if (pol_weight > 0._8) then
      call r_statistics(pos_now, position, pol_weight)
      if (pos_now < N) then
        call add_bead(position, pol_weight, pos_now+1)
      else
        print*, "N_max->", pos_now
        print *, "Weight->", pol_weight
      end if
    else
       print*, "N_max->", pos_now
       print *, "Weight->", pol_weight
    end if

  end subroutine add_bead

end module
