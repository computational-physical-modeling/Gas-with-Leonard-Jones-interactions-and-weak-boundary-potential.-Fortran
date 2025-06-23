subroutine escribir_trayectoria(paso)
  use modDM
  implicit none
  integer, intent(in) :: paso
  integer :: i
  character(len=50) :: filename
  real(8) :: pos(3)

  filename = 'trayectoria.xyz'

  open(unit=11, file=filename, status='unknown', position='append')

  write(11,*) Npar
  write(11,'(A,I6,A,F10.4)') 'Paso de tiempo: ', paso, ' L=', L

  do i = 1, Npar
     pos = vr(i,:) - L*anint(vr(i,:)/L)
     write(11,'(A1,3F12.6)') 'H', pos(1), pos(2), pos(3)
  end do

  close(11)
end subroutine escribir_trayectoria

