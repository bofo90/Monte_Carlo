module output_file
    
    use global
    
    implicit none

    integer, parameter :: fRsqr = 1001
    integer, parameter :: fPos = 1002
    integer, parameter :: fGyr = 1003

contains

    subroutine init_files(fname)

        character(len=*), intent(in) :: fname

        open(unit = fRsqr, file = "./data/rsq_" // fname // ".dat")
        open(unit = fPos, file = "./data/position_" // fname // ".dat")
        open(unit = fGyr, file = "./data/gyr_" // fname // ".dat")

        call insert_header(fRsqr)
        call insert_header(fGyr)

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
          write(fRsqr, *) i, mean_rsqr, sqrt((rsqrsqr(i)/sum_weight(i) - mean_rsqr**2)/num_N_poly(i))
        end do

    end subroutine write_rsqr

    subroutine write_gyr

        integer(8) :: i
        real(8) :: mean_rsqr

        mean_rsqr = 0
        do i = 1, N
          mean_rsqr = mean_rsqr + rsqr(i)/sum_weight(i)
          write(fGyr, *) i, mean_rsqr/i - sum_r_mean(i)/sum_weight(i)
        end do

    end subroutine write_gyr

    subroutine write_pos(position)

        real(8), intent(in) :: position(:,:)
        integer(8) :: i
        do i = 1, size(position, 2)
          write(fPos, *) position(1,i), position(2,i), position(3,i)
        end do

    end subroutine write_pos

    subroutine close_files

        close(fRsqr)
        close(fPos)

    end subroutine close_files


end module
