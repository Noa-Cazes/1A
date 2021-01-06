program validation
      use mat_tridiag_entrainement
      type(tridiag):: m1, m2, m3
      logical:: code

      integer:: i

      call create(m1, 10)
      call create(m2, 10)

      do i = 1, 10  ! i indice colonne, diag sur toutes les colonnes
         m1%diag(i) = 1.0
         m2%diag(i) = 2.0
      end do

      do i = 1, 9 ! diag inf présente de 1 à 9
         m1%diaginf(i) = 1.0
         m2%diaginf(i) = 2.0
      end do

      do i = 2, 10 ! diagsup présente de 2 à 10
         m1%diagsup(i) = 1.0
         m2%diagsup(i) = 2.0
      end do

      call somme(m1, m2, m3, code)

      if (code) then
          call affiche(m3)
      else
          print *, "erreur de dimension"
      end if


end program validation
