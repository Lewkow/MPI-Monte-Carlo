program mc_pi
    include 'mpif.h'

    integer, parameter :: n_test_particles=1e8
    integer :: particle_now, particle_hits, rank_n_test_particles
    integer :: sum_particle_hits
    real(kind=8) :: hit_percentage, simulated_pi, theoretical_pi, rand_x, rand_y, error, t1, t2
    integer :: process_rank, rank_size, ierror, tag

    call MPI_INIT(ierror)
    call MPI_COMM_SIZE(MPI_COMM_WORLD, rank_size, ierror)
    call MPI_COMM_RANK(MPI_COMM_WORLD, process_rank, ierror)
    
    t1 = MPI_WTIME()

    rank_n_test_particles = n_test_particles / rank_size

    if (process_rank == 0) then
        if (rank_n_test_particles * rank_size < n_test_particles) then
            rank_n_test_particles = rank_n_test_particles + (n_test_particles - (rank_n_test_particles * rank_size))
        end if
    end if

    particle_now = 0
    particle_hits = 0
    theoretical_pi = 4 * atan(1.0_8)

    do while (particle_now < rank_n_test_particles)
        call random_number(rand_x)
        call random_number(rand_y)
        if ((rand_x**2 + rand_y**2) <= 1.0) then
            particle_hits = particle_hits + 1
        end if
        particle_now=particle_now+1
    end do

    call MPI_REDUCE(particle_hits, sum_particle_hits, 1, MPI_INTEGER, MPI_SUM, 0, MPI_COMM_WORLD, ierror)

    t2 = MPI_WTIME()

    if (process_rank == 0) then
        hit_percentage = real(sum_particle_hits) / real(n_test_particles)
        simulated_pi = hit_percentage * real(4)
        theoretical_pi = 4 * atan(1.0_8)
        error = abs(simulated_pi - theoretical_pi) * 100 / theoretical_pi
        print *, "---------------------------------------"
        print *, "parallel processes: ", rank_size
        print *, "total test darts: ", n_test_particles
        print *, "runtime (sec): ", (t2-t1)
        print *, "theoretical pi: ", theoretical_pi 
        print *, "simulated pi: ", simulated_pi
        print *, "percent error: ", error
    end if

    call MPI_FINALIZE(ierror)

end program mc_pi