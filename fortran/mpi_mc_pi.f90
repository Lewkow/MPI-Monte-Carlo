program mc_pi

    integer, parameter :: n_test_particles=100
    ! integer, parameter :: n_test_particles=1000000
    integer :: particle_now, particle_hits, particle_misses
    real(kind=8) :: hit_percentage, simulated_pi, theoretical_pi, rand_x, rand_y, error

    particle_now = 0
    particle_hits = 0
    particle_misses = 0
    theoretical_pi = 4 * atan(1.0_8)

    do while (particle_now < n_test_particles)
        call random_number(rand_x)
        call random_number(rand_y)
        if ((rand_x**2 + rand_y**2) <= 1.0) then
            particle_hits = particle_hits + 1
        else
            particle_misses = particle_misses + 1
        end if
        particle_now=particle_now+1
    end do

    hit_percentage = real(particle_hits) / real(n_test_particles)
    simulated_pi = hit_percentage * real(4)
    error = abs(simulated_pi - theoretical_pi) * 100 / theoretical_pi
    print *, n_test_particles, " test particles"
    print *, "simulated pi: ", simulated_pi
    print *, "error: ", error

end program mc_pi