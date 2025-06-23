SUBROUTINE fuerzas
  USE modDM
  implicit none
  integer :: i, j
  real(8) :: r(3), r2, r_2, r_6, r_12, f_lj
  real(8) :: wall_force, wall_dist, wall_strength = 100.d0  ! Wall parameters
  real(8) :: wall_position = 0.1d0  ! Distance from box edge where wall force starts

  Epot = 0.d0
  vF = 0.d0

  ! First, calculate interparticle forces
  do i = 1, Npar-1
     do j = i+1, Npar
        ! Vector distancia con condiciones periódicas
        r(:) = vr(i,:) - vr(j,:)
        r = r - L * Anint(r / L)
        r2 = dot_product(r, r)

        if (r2 < Rcut2) then
           r_2 = 1.d0 / r2
           r_6 = r_2**3
           r_12 = r_6**2

           ! Fuerza Lennard-Jones (ya sin epsilon ni sigma explícitos)
           f_lj = 24.d0 * r_2 * (2.d0 * r_12 - r_6)

           ! Acumulamos fuerzas (acción-reacción)
           vF(i,:) = vF(i,:) + f_lj * r(:)
           vF(j,:) = vF(j,:) - f_lj * r(:)

           ! Energía potencial Lennard-Jones
           Epot = Epot + 4.d0 * (r_12 - r_6)
        end if
     end do
  end do

  ! Now add wall forces to prevent teleportation
  do i = 1, Npar
     do j = 1, 3  ! For each dimension (x,y,z)
        ! Left wall (minimum boundary)
        wall_dist = vr(i,j) - (-0.5d0*L)
        if (wall_dist < wall_position) then
           wall_force = wall_strength * (1.d0/wall_dist - 1.d0/wall_position)
           vF(i,j) = vF(i,j) + wall_force
           Epot = Epot + wall_strength * (log(wall_dist/wall_position) + (1.d0 - wall_dist/wall_position))
        endif
        
        ! Right wall (maximum boundary)
        wall_dist = (0.5d0*L) - vr(i,j)
        if (wall_dist < wall_position) then
           wall_force = wall_strength * (1.d0/wall_dist - 1.d0/wall_position)
           vF(i,j) = vF(i,j) - wall_force
           Epot = Epot + wall_strength * (log(wall_dist/wall_position) + (1.d0 - wall_dist/wall_position))
        endif
     end do
  end do

  ! Energía por partícula (opcional según análisis)
  Epot = (Epot - Ecut) / Npar
END SUBROUTINE fuerzas


