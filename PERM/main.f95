program Polymer
  
  use global
  use growing
  use output_file

  implicit none

  integer(8) :: i
  
  call alloc_global()
  call init_files("test")

  do i = 1, N_RUNS
    call init_vectors()
    call chain_grow()
    !call r_statistics()
  end do

  call write_rsqr
  call write_gyr
  call close_files

  !call plot()
  
end program Polymer
