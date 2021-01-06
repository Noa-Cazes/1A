program test_solve

    implicit none

    integer :: i, j, ierr, n
    double precision, dimension (:,:), allocatable :: U
    double precision, dimension (:), allocatable :: x, b
    real:: start_left, finish_left, start_right, finish_right

    ! fonction utilisée
    double precision :: backward_error

    write(*,*)
    write(*,*) 'Choose the size n :'
    read(*,*) n
    write(*,*)

    ! Initialization: U is lower triangular
    write(*,*) 'Initialization ...'
    write(*,*)

    allocate(U(n,n), stat = ierr)
    if(ierr.ne.0) then
        write(*,*)'Could not allocate U(n,n) with n =', n
        write(*,*)
        goto 999
    end if

    allocate(x(n), stat = ierr)
    if(ierr.ne.0) then
        write(*,*)'Could not allocate x(n) with n =', n
        write(*,*)
        goto 999
    end if

    allocate(b(n), stat = ierr)
    if(ierr.ne.0) then
        write(*,*)'Could not allocate b(n) with n =', n
        write(*,*)
        goto 999
    end if

    U = 0.D0
    do i = 1, n
        U(i,i) = n + 1.D0
        do j = i+1, n
            U(i,j) = 1.D0
        end do
    end do
    b = 1.D0

    ! Left-looking triangular solve of Ux = b
    write(*,*) 'Solving with a left-looking method ...'
    
    call cpu_time(start_left)
    call left_looking_solve(U, x, b, n)
    call cpu_time(finish_left)

    write(*,*) 'Error for a left-looking method: '
    print *, backward_error(U, x, b, n)

    write(*,*) 'Execution time for a left-looking method: '
    print *, finish_left - start_left

    ! Right-looking triangular solve of Ux = b
    write(*,*) 'Solving with a right-looking method ...'

    call cpu_time(start_right)
    call right_looking_solve(U, x, b, n)
    call cpu_time(finish_right)
    
    write(*,*) 'Error for a right-looking method: '
    print *, backward_error(U, x, b, n)
    
    write(*,*) 'Execution time for a right-looking method: '
    print *, finish_right - start_right



999 if(allocated(U)) deallocate(U)
    if(allocated(x)) deallocate(x)
    if(allocated(b)) deallocate(b)

end program test_solve


! Procédure left_looking_solve
! Effectue la résolution sans report du système triangulaire Ux = b
! U:  matrice de taille n × n de nombres réels double précision
! b: second membre, vecteur de taille n de nombres réels double précision
! n: entier
! x: vecteur de taille n
! Pré-conditions:
!     U est initialisée et aucun terme de sa diagonale n'est nul
!     n > 0
! Post-condition:
!     x contient la solution de Ux = b .

subroutine left_looking_solve(U, x, b, n)
    implicit none
    integer, intent(in):: n
    double precision, dimension(1:n,1:n), intent(in):: U
    double precision, dimension(1:n), intent(in):: b
    double precision, intent(out), dimension(1:n):: x

    integer:: i, j
    
    x = b
 
    do j = n, 1, -1
       do i = n, j+1, -1
          x(j) = x(j) - U(j,i)*x(i)
       end do
       x(j) = x(j)/U(j,j)
   end do
   return
end subroutine left_looking_solve
    


! Procédure right_looking_solve
! Effectue la résolution avec report du système triangulaire Ux = b
! U:  matrice de taille n × n de nombres réels double précision (donnée)
! b: second membre, vecteur de taille n de nombres réels double précision (donnée)
! n: entier, dimension commune (donnée)
! x: vecteur de taille n (résultat)
! Pré-conditions:
!     U est initialisée et aucun terme de sa diagonale n'est nul
!     n > 0
! Post-condition:
!     x contient la solution de Ux = b .

 subroutine right_looking_solve(U, x, b, n)
    implicit none
    integer, intent(in):: n
    double precision, dimension(n,n), intent(in):: U
    double precision, dimension(n), intent(in):: b
    double precision, intent(out), dimension(n):: x

    integer:: i, j
 
    x = b

    do j = n, 1, -1
       x(j) = x(j)/U(j,j)
       do i = 1, j-1
          x(i) = x(i) - U(i,j)*x(j)
       end do
    end do
    return
end subroutine right_looking_solve


! Fonction backward_error
! Calcule l'erreur inverse ||Ux _ b||/||b||
! U:  matrice de taille n × n de nombres réels double précision (donnée)
! b: second membre, vecteur de taille n de nombres réels double précision (donnée)
! n: entier, dimension commune (donnée)
! x: vecteur de taille n (donnée)
! Pré-conditions:
!    n > 0


double precision function backward_error(U, x, b, n)
    implicit none
    integer, intent(in):: n
    double precision, dimension(n,n), intent(in):: U
    double precision, dimension(n), intent(in):: b
    double precision, intent(out), dimension(n):: x

    integer:: i
    real:: n_b, n_a
    real, dimension(n):: D
    n_b = 0.0
    n_a = 0.0
    backward_error = 0.D0
    D = matmul(U,x) - b
    
    do i = 1, n
       n_b = n_b + b(i)*b(i)
       n_a = n_a + D(i)*D(i)
    end do

    n_b = sqrt(n_b)
    n_a = sqrt(n_a)

    backward_error = n_a/n_b
    return
end function backward_error

! Différence de performance entre les deux algorithmes
! La méthode right_looking a en moyenne un temps d'execution plus faible que pour la méthode left_looking en raison du fait que dans
! l'implémentation la valeur divisée par u_jj n'est pas directement la valeur modifiée dans la deuxième boucle, contrairement à dans
! l'algorithme left_looking.
