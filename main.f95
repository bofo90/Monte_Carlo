program Polymer
  
  use global
  use growing
  use plotting

  implicit none
  
  call init_global()
  call chain_grow()
  call r_statistics()

  !call plot()

  print "(2E20.8)", pos
  
end program Polymer
