real function horner(a, n, x)
      implicit none

      real, intent(in), dimension(n+1):: a
      integer, intent(in):: n
      real, intent(in):: x

      integer:: i

      print *, horner
      horner = a(n+1)
      do i = n, 1, -1
          horner = horner*x + a(i)
      end do
      return
end function horner



program test_horner
      implicit none

      ! Degré du polynôme
      integer:: n

      ! Coeff du polynôme
      real, allocatable, dimension(:):: coef

      ! Valeur de l'inconnue
      real:: x

      ! Valeur finale du poly au point x
      real p 

      ! Indice de boucle
      integer:: i

      ! Retour du allocate
      integer:: retour

      ! fonction horner
      real:: horner

      n = -1

      do while(n<0)
         write(*,*) 'Entrez le degré du polynôme'
         read(*,*) n
      end do

      allocate(coef(n+1), stat = retour)

      if(retour.ne.0) stop

      do i = 1, n+1
         write(*,*) 'Entrez le coef de degré', i-1, ' : '
         read(*,*) coef(i)
      end do

      write(*,*) 'Liste des coef du poly'
      read(*,*) coef

      write(*,*) 'Entrez l'inconnue'
      read(*,*) x

      p = horner(coef, n, x)

      write(*, *) 'valeur du poly = ', p, ' en ', x

end program test_horner

