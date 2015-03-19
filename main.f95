program Polymer
  
  use global
  use growing
  use plotting

  implicit none

  integer(8) :: i
  
  call init_global()

  do i = 1, N_RUNS
    call chain_grow()
    call r_statistics()
    print *, i
  end do

  !call plot()
  
end program Polymer
