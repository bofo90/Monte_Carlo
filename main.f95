program Polymer
  
  use global
  use growing
  use plotting

  implicit none
  
  call init_global()
  call chain_grow()

  !call plot()

  print "(2E10.2)", pos
  
end program Polymer
