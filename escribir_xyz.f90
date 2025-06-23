subroutine escribir_xyz(paso)
  use modDM
  implicit none
  integer, intent(in) :: paso
  character(len=20) :: str_paso
  character(len=50) :: filename
  integer :: i

  ! Convertir entero a string
  write(str_paso, '(I0)') paso
  filename = 'conf_' // trim(adjustl(str_paso)) // '.xyz'

  open(unit=10, file=filename, status='unknown')
  write(10,*) Npar
  write(10,*) "Paso de tiempo:", paso

  do i = 1, Npar
     write(10,'(A1,3F12.6)') 'H', vr(i,1), vr(i,2), vr(i,3)
  end do

  close(10)
end subroutine escribir_xyz

