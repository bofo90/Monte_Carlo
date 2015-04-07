module monte_carlo

  use global

  implicit none

  real(8), parameter :: PI = 4d0*atan(1d0)
  integer :: N_theta, N_phi, N_tot
  real(8), allocatable :: possible_pos(:,:)
  real(8), allocatable :: weights(:)
  logical :: is2d

contains
  
  subroutine define_mc_param(run_2d)

    logical, intent(in) :: run_2d

    is2d = run_2d
    if (run_2d) then
      N_theta = 6
      N_phi = 1
    else
      N_theta = 5
      N_phi = 4
    end if

    N_tot = N_phi*N_theta

    allocate(weights(N_tot))
    allocate(possible_pos(3,N_tot))

  end subroutine define_mc_param

  subroutine weight_calc(position, pos_now, new_weight, new_pos)

    real(8), intent(in) :: position(:,:) 
    integer, intent(in) :: pos_now
    real(8), intent(out) :: new_weight, new_pos(:)
    real(8), parameter :: eps = 0.25, sigma2 = 0.64
    real(8) :: distance(3)
    real(8) :: dist2, energy, dist2_cut, energy_bias
    integer(8) :: i, j

    ! Initialize possible positions
    call all_new_pos(position(:,pos_now-1))
    ! cutoff distance is chosen to be double the potential minimum
    dist2_cut = 2**(7d0/3)*sigma2
    energy_bias = 127d0/16384
    !dist2_cut = 100*sigma2
    !energy_bias = 0    
    new_weight = 0
    do i = 1, N_tot
       energy = 0
       do j = 1, pos_now-1
          distance = possible_pos(:,i)-position(:,j)
          dist2 = dot_product(distance, distance)
          if (dist2 .LE. dist2_cut) then
            if (dist2 < 0.01*sigma2) then
              ! Avoid overflow by use an infinity energy
              ! ensure that when we increase N this value will increase
              energy = energy + N*1000
            else
              ! Calculate the energy with a maximum cutoff.
              ! We ensure that the energy is zero at cutoff.
              energy = energy + 4d0*beta*eps*((sigma2/dist2)**6d0 - (sigma2/dist2)**3d0 + energy_bias)
            end if
          end if
       end do
       ! Cut the energy to avoid underflow
       if (energy .GE. 40) then
          weights(i) = 0
       else
          weights(i) = exp(-energy)/N_tot
          new_weight = new_weight + weights(i)
       end if
    end do

    ! Normalize the weights
    weights = weights / new_weight
    call choose_pos(new_pos)

  end subroutine weight_calc

  subroutine up_and_low_limit_calc(pos_now, up_limit, low_limit)

    real(8), intent(out) :: up_limit, low_limit
    integer, intent(in) :: pos_now
    real(8), parameter :: alpha_low = 0.1, alpha_up = 5
    real(8) :: weight_avg

    if (num_N_poly(pos_now) .LE. 20) then
      up_limit = 1d10
      low_limit = 0
    else
      weight_avg = sum_weight(pos_now)/num_N_poly(pos_now)
      up_limit = alpha_up * weight_avg
      low_limit = alpha_low * weight_avg
    end if

  end subroutine up_and_low_limit_calc

  subroutine all_new_pos(prev_pos)

    real(8), intent(in) :: prev_pos(:)
    real(8) :: dr(3), theta, phi, theta_rnd(2)
    integer :: i, k

    call init_random_seed
    call random_number(theta_rnd)

    do i = 1, N_tot
      k = mod(i-1,N_theta)
      theta = 2._8*PI*(theta_rnd(1) + k)/N_theta
      if (is2d) then
        phi = 0
        dr(1) = cos(theta)
        dr(2) = sin(theta)
        dr(3) = 0._8
      else
        phi = PI*(theta_rnd(2) + (i-1-k)/N_theta)/N_phi
        dr(1) = sin(phi)*cos(theta)
        dr(2) = sin(phi)*sin(theta)
        dr(3) = cos(phi)
      end if
      possible_pos(:, i) = prev_pos + dr
    end do

  end subroutine all_new_pos

  subroutine choose_pos(new_pos)

    real(8), intent(out) :: new_pos(:)
    real(8) :: rnd_out, sum_weights
    integer :: i

    call init_random_seed
    call random_number(rnd_out)

    i = 1
    sum_weights = weights(i)
    do while (sum_weights < rnd_out .AND. i < N_tot)
       i = i + 1
       sum_weights = sum_weights + weights(i)
    end do

    new_pos = possible_pos(:, i)
  end subroutine choose_pos

  subroutine init_random_seed()
    ! Function to initialize the seed of the random
    ! number generator

    integer, allocatable :: seed(:)
    integer :: i, n, un, istat, dt(8), pid, t(2), s
    integer(8) :: count, tms

    call random_seed(size = n)
    allocate(seed(n))
    open(newunit=un, file="/dev/urandom", access="stream",&
         form="unformatted", action="read", status="old", &
         iostat=istat)
    if (istat == 0) then
       read(un) seed
       close(un)
    else
       call system_clock(count)
       if (count /= 0) then
          t = transfer(count, t)
       else
          call date_and_time(values=dt)
          tms = (dt(1) - 1970)*365_8 * 24 * 60 * 60 * 1000 &
               + dt(2) * 31_8 * 24 * 60 * 60 * 1000 &
               + dt(3) * 24 * 60 * 60 * 60 * 1000 &
               + dt(5) * 60 * 60 * 1000 &
               + dt(6) * 60 * 1000 + dt(7) * 1000 &
               + dt(8)
          t = transfer(tms, t)
       end if
       s = ieor(t(1), t(2))
       pid = getpid() + 1099279 ! Add a prime
       s = ieor(s, pid)
       if (n >= 3) then
          seed(1) = t(1) + 36269
          seed(2) = t(2) + 72551
          seed(3) = pid
          if (n > 3) then
             seed(4:) = s + 37 * (/ (i, i = 0, n - 4) /)
          end if
       else
          seed = s + 37 * (/ (i, i = 0, n - 1 ) /)
       end if
    end if
    call random_seed(put=seed)

  end subroutine init_random_seed


end module monte_carlo
