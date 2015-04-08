program Polymer
  
  use global
  use growing
  use output_file
  use monte_carlo

  implicit none

  integer(8) :: i, j
  real(8) :: betas(3) = (/ 1d0, 0.98d0, 0.96d0 /)
  logical, parameter :: run_2d = .FALSE.
  logical, parameter :: perm = .TRUE.
  character(len=7) :: suffix
  character(len=3) :: beta_str

  call define_mc_param(run_2d)
  
  do j = 1, size(betas)

    write(beta_str, "(I0.3)") int(100*betas(j))

    suffix = "BETA" // beta_str

    print *, suffix

    call alloc_global(betas(j))
    call init_files(suffix)
    i = 1
    
    do while (minval(num_N_poly) < N_POLY .AND. i .LE. 2d4)
      call init_vectors()
      call chain_grow(i, perm)
      if (mod(i,10) == 0) then
        print *, "Run->", i
        print *, "Min_N_Poly->", minval(num_N_poly)
        print *, "Min_N_Loc->", minloc(num_N_poly)
        print *, "Tot_Poly->", sum(num_N_poly)
      end if
      i = i+1
    end do

    call write_rsqr
    call write_Npoly
    call write_gyr
    call close_files

    call dealloc_global

  end do
  
end program Polymer
