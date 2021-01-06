program tri
      implicit none

      integer, parameter:: n = 10;
      
      real, dimension(n):: v
      data v/0.7, 0.3, 0.4, 1.9, 0.2, 0.1, 0.5, 0.6, 0.7, 0.9/

      call tri_bulle(v, n)

      print *, 'tri croissant', v

end program tri


subroutine tribulle(t,m)

      implicit none

      ! déclarations des paramètres et de leur mode
      real, dimension(m), intent(inout):: t
      integer, intent(in):: m

      ! déclarations des variables locales
      integer:: i, j
      real:: aux

      do i = 1, m-1
         do j = 1, m-i
            if(t(j+1)<t(j)) then
                aux = t(j+1)
                t(j+1) = t(j)
                t(j) = aux
            end if
            ! t(j) < t(j+1)
         end do
      end do
end subroutine tribulle
