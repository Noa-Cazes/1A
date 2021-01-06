programm validation

      use mat_tridiag
      type(tridiag):: m1, m2, m3

      integer:: i

      do i = 1, 10
         m1%diag(i) = 1.0
         m2%diag(i) = 2.0
      end do

      do i = 2, 10
         m1%diagsup(i) = 1.0
         m2%diagsup(i) = 2.0
      end do

      do i = 1, 9
         m1%diaginf(i) = 1.0
         m2%diaginf(i) = 2.0
      end do

      call somme(m1, m2, m3)
      call affiche(m3)

end program validation
