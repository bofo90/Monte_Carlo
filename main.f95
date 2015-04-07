program Polymer
  
  use global
  use growing
  use output_file
  use monte_carlo

  implicit none

  integer(8) :: i
  logical, parameter :: run_2d = .FALSE.
  logical, parameter :: perm = .TRUE.
  character(len=*), parameter :: suffix = "PERM_3D"
  
  call alloc_global()
  call init_files(suffix)
  call define_mc_param(run_2d)
  i = 1
  
  do while (minval(num_N_poly) < N_POLY)
    call init_vectors()
    call chain_grow(i, perm)
    print *, "Run->", i
    print *, "Min_N_Poly->", minval(num_N_poly)
    print *, "Min_N_Loc->", minloc(num_N_poly)
    print *, "Tot_Poly->", sum(num_N_poly)
    i = i+1
  end do

  call write_rsqr
  call write_Npoly
  call write_gyr
  call close_files
  
end program Polymer
