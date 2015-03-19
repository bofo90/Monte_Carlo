module output_file
    
    use global
    
    implicit none

    integer, parameter :: fRsqr = 1001

contains

    subroutine init_files(fname)

        character(len=*), intent(in) :: fname

        open(unit = fRsqr, file = "./data/energy_" // fname // ".dat")

        call insert_header(fRsqr)

    end subroutine init_files

    subroutine insert_header(file)

        integer, intent(in) :: file

        write(file, *) "BETA->", beta

    end subroutine

    subroutine write_rsqr

        integer(8) :: i
        real(8) :: mean_rsqr

        do i = 1, N
          mean_rsqr = rsqr(i)/sum_weight(i)
          write(fRsqr, *) i, mean_rsqr, sqrt(rsqrsqr(i)/sum_weight(i) - mean_rsqr**2)
        end do

    end subroutine write_rsqr

    subroutine close_files

        close(fRsqr)

    end subroutine close_files


end module