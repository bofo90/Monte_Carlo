program Polymer
  
  use global
  use growing
  use plotting
  use output_file

  implicit none

  integer(8) :: i
  
  call init_global()

  do i = 1, N_RUNS
    call chain_grow()
    call r_statistics()
    print *, i
  end do

  call init_files("test")
  call write_rsqr
  call close_files

  !call plot()
  
end program Polymer
