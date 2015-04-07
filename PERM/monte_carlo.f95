module monte_carlo

  use global

  implicit none

  real(8), parameter :: PI = 4d0*atan(1d0)
  integer, parameter :: N_theta = 4
  !integer, parameter :: N_phi = 3
  real(8) :: possible_pos(2, N_theta)
  real(8) :: weights(N_theta)
  real(8), parameter :: alpha_up = 2, alpha_low = 1.5

contains

  subroutine weight_calc(position, pos_now, new_weight, new_pos)

    real(8), intent(in) :: position(:,:) 
    integer, intent(in) :: pos_now
    real(8), intent(out) :: new_weight, new_pos(:)
    real(8), parameter :: eps = 0.25, sigma2 = 0.64
    real(8) :: distance(2)
    real(8) :: dist2, energy
    integer(8) :: i, j

    ! Initialize possible positions
    call all_new_pos(position(:,pos_now-1))

    new_weight = 0
    do i = 1, N_theta
       energy = 0
       do j = 1, pos_now-1
          distance = possible_pos(:,i)-position(:,j)
          dist2 = dot_product(distance, distance)
          if(dist2 < 0.78*sigma2)then
             energy = energy + N*1000 
             !ensure that when we increase N this value will increase,
             !so it becomes weight = 0
          else
             energy = energy + 4d0*beta*eps*((sigma2/dist2)**6d0 - (sigma2/dist2)**3d0)
          end if
       end do
       ! Cut the energy to avoid underflow
       if (energy >= 35) then
          weights(i) = 0
       else
          weights(i) = exp(-energy)
          new_weight = new_weight + weights(i)
       end if
    end do

    ! Normalize the weights
    weights = weights / new_weight
    call choose_pos(new_pos)

  end subroutine weight_calc

  subroutine all_new_pos(prev_pos)

    real(8), intent(in) :: prev_pos(:)
    real(8) :: dr(2), theta, theta_rnd
    integer :: i

    call init_random_seed
    call random_number(theta_rnd)

    do i = 1, N_theta
      theta = theta_rnd + 2._8*i*PI/N_theta
      dr(1) = cos(theta)
      dr(2) = sin(theta)
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
    do while (sum_weights < rnd_out .AND. i < N_theta)
       i = i + 1
       sum_weights = sum_weights + weights(i)
    end do

    new_pos = possible_pos(:, i)
  end subroutine choose_pos

  subroutine up_and_low_limit_calc(up_limit, low_limit, pos_now)

    real(8), intent(out) :: up_limit, low_limit
    integer, intent(in) :: pos_now

    up_limit = alpha_up * sum_weight(pos_now)/(num_N_poly(pos_now)*sum_weight(3))
    low_limit = alpha_low * sum_weight(pos_now)/(num_N_poly(pos_now)*sum_weight(3))

  end subroutine up_and_low_limit_calc

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