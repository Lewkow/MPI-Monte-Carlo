program mc_pi

    integer, parameter :: n_test_particles=100
    integer :: particle_now, particle_hits, particle_misses
    real(kind=8) :: hit_percentage, simulated_pi, theoretical_pi

    particle_now = 0
    particle_hits = 0
    particle_misses = 0

    do while (particle_now < n_test_particles)
        print *, particle_now
        particle_now=particle_now+1
    end do



end program mc_pi