program init_matrice

      implicit none

      integer, dimension(4,4):: A
      integer:: i,j

      call init_mat(A, 3, 3)

      do j = 1,3
         do i = 1,3
            write(*,*) i, j, A(i,j)
         end do
      end do

end program init_matrice


subroutine init_mat(A, n, m)

      implicit none
      integer, intent(out), dimension(n,m):: A
      integer, intent(in):: n, m
      integer:: valeur
      integer:: i, j

      valeur = 0
      do j = 1, m
         do i = 1, n
            valeur = valeur + 1
            A(i,j) = valeur
         end do
      end do

end subroutine init_mat
