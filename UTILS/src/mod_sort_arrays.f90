!< author: Arthur Francisco
!  version: 1.0.0
!  date: july, 23 2018
!
!  <span style="color: #337ab7; font-family: cabin; font-size: 1.5em;">
!     **Various routines to sort real/integer arrays**
!  </span>

module sort_arrays
use data_arch, only : I4, R8
implicit none

private

public :: init_order, sort_real, sort_integer, sort_real_1real, sort_real_2real, sort_int_1real, sort_int_1int_1real, sort_real_1int

contains

   !=========================================================================================
   subroutine init_order(order)
   implicit none
   integer(kind=I4), dimension(:), intent(out) :: order
      integer(kind=I4) :: i, l
      l = ubound(order,1)
      do i = 1, l
         order(i) = i
      enddo
   return
   endsubroutine init_order

   !=========================================================================================
   !<@note
   !   Subroutine to sort a vector of integers
   ! @endnote
   !-----------------------------------------------------------------------------------------
   recursive subroutine sort_integer(g, d, itabref)
      implicit none
      integer(kind=I4), intent(in)  :: g, d
      integer(kind=I4), dimension(:), intent(inout)  :: itabref
      integer(kind=I4) :: i, j, mil
      integer(kind=I4)  :: tmp, cle
      i = g
      j = d
      mil = (g+d)/2
      cle = itabref(mil)

      if (g>=d) return

      do while (i<=j)
         do while (itabref(i)<cle)
            i = i + 1
         enddo
         do while (itabref(j)>cle)
            j = j - 1
         enddo
         if (i<=j) then
            ! échange des éléments du tableau
            tmp = itabref(i)
            itabref(i) = itabref(j)
            itabref(j) = tmp
            ! échange des éléments du vecteur position
            i = i + 1
            j = j - 1
         endif
      enddo

      if (g<j) call sort_integer(g, j, itabref)
      if (d>i) call sort_integer(i, d, itabref)

   return
   endsubroutine sort_integer

   !=========================================================================================
   !<@note
   !   Subroutine to sort a vector of reals
   ! @endnote
   !-----------------------------------------------------------------------------------------
   recursive subroutine sort_real(g, d, rtabref)
      implicit none
      integer(kind=I4), intent(in)  :: g, d
      real(kind=R8), dimension(:), intent(inout)  :: rtabref
      integer(kind=I4) :: i, j, mil
      real(kind=R8)  :: tmp, cle
      i = g
      j = d
      mil = (g+d)/2
      cle = rtabref(mil)

      if (g>=d) return

      do while (i<=j)
         do while (rtabref(i)<cle)
            i = i + 1
         enddo
         do while (rtabref(j)>cle)
            j = j - 1
         enddo
         if (i<=j) then
            ! échange des éléments du tableau
            tmp = rtabref(i)
            rtabref(i) = rtabref(j)
            rtabref(j) = tmp
            ! échange des éléments du vecteur position
            i = i + 1
            j = j - 1
         endif
      enddo

      if (g<j) call sort_real(g, j, rtabref)
      if (d>i) call sort_real(i, d, rtabref)

   return
   endsubroutine sort_real

   !=========================================================================================
   !<@note
   !   Subroutine to sort a vector of reals, according a vector of reals
   ! @endnote
   !-----------------------------------------------------------------------------------------
   recursive subroutine sort_real_1real(g, d, rtabref, rtab1)
   implicit none
   integer(kind=I4), intent(in) :: g, d
   real(kind=R8), dimension(:), intent(inout) :: rtabref
   real(kind=R8), dimension(:), intent(inout) :: rtab1
      integer(kind=I4) :: i, j, mil
      real(kind=R8)    :: rtmp, cle
      i = g
      j = d
      mil = (g+d)/2
      cle = rtabref(mil)

      if (g>=d) return

      do while (i<=j)
         do while (rtabref(i)<cle)
            i = i + 1
         enddo
         do while (rtabref(j)>cle)
            j = j - 1
         enddo
         if (i<=j) then
            ! échange des éléments du tableau
            rtmp       = rtabref(i)
            rtabref(i) = rtabref(j)
            rtabref(j) = rtmp
            ! échange des éléments du vecteur 2
            rtmp     = rtab1(i)
            rtab1(i) = rtab1(j)
            rtab1(j) = rtmp

            i = i + 1
            j = j - 1
         endif
      enddo

      if (g<j) call sort_real_1real(g, j, rtabref, rtab1)
      if (d>i) call sort_real_1real(i, d, rtabref, rtab1)

   return
   endsubroutine sort_real_1real

   !=========================================================================================
   !<@note
   !   Subroutine to sort a vector of integers, according a vector of reals
   ! @endnote
   !-----------------------------------------------------------------------------------------
   recursive subroutine sort_real_1int(g, d, rtabref, itab1)
   implicit none
   integer(kind=I4), intent(in) :: g, d
   real(kind=R8),    dimension(:), intent(inout) :: rtabref
   integer(kind=I4), dimension(:), intent(inout) :: itab1
      integer(kind=I4) :: i, j, mil, itmp
      real(kind=R8)    :: rtmp, cle
      i = g
      j = d
      mil = (g+d)/2
      cle = rtabref(mil)

      if (g>=d) return

      do while (i<=j)
         do while (rtabref(i)<cle)
            i = i + 1
         enddo
         do while (rtabref(j)>cle)
            j = j - 1
         enddo
         if (i<=j) then
            ! échange des éléments du tableau
            rtmp       = rtabref(i)
            rtabref(i) = rtabref(j)
            rtabref(j) = rtmp
            ! échange des éléments du vecteur 2
            itmp     = itab1(i)
            itab1(i) = itab1(j)
            itab1(j) = itmp

            i = i + 1
            j = j - 1
         endif
      enddo

      if (g<j) call sort_real_1int(g, j, rtabref, itab1)
      if (d>i) call sort_real_1int(i, d, rtabref, itab1)

   return
   endsubroutine sort_real_1int


   !=========================================================================================
   !<@note
   !   Subroutine to sort 2 vectors of reals, according a vector of reals
   ! @endnote
   !-----------------------------------------------------------------------------------------
   recursive subroutine sort_real_2real(g, d, rtabref, rtab1, rtab2)
   implicit none
   integer(kind=I4), intent(in) :: g, d
   real(kind=R8), dimension(:), intent(inout) :: rtabref
   real(kind=R8), dimension(:), intent(inout) :: rtab1
   real(kind=R8), dimension(:), intent(inout) :: rtab2
      integer(kind=I4) :: i, j, mil
      real(kind=R8)    :: rtmp, cle
      i = g
      j = d
      mil = (g+d)/2
      cle = rtabref(mil)

      if (g>=d) return

      do while (i<=j)
         do while (rtabref(i)<cle)
            i = i + 1
         enddo
         do while (rtabref(j)>cle)
            j = j - 1
         enddo
         if (i<=j) then
            ! échange des éléments du tableau
            rtmp       = rtabref(i)
            rtabref(i) = rtabref(j)
            rtabref(j) = rtmp
            ! échange des éléments du vecteur 2
            rtmp     = rtab1(i)
            rtab1(i) = rtab1(j)
            rtab1(j) = rtmp
            ! échange des éléments du vecteur 3
            rtmp     = rtab2(i)
            rtab2(i) = rtab2(j)
            rtab2(j) = rtmp

            i = i + 1
            j = j - 1
         endif
      enddo

      if (g<j) call sort_real_2real(g, j, rtabref, rtab1, rtab2)
      if (d>i) call sort_real_2real(i, d, rtabref, rtab1, rtab2)

   return
   endsubroutine sort_real_2real


   !=========================================================================================
   !<@note
   !   Subroutine to sort a vector of reals and a vector of integers, according a vector of integers
   ! @endnote
   !-----------------------------------------------------------------------------------------
   recursive subroutine sort_int_1int_1real(g, d, itabref, itab1, rtab2)
   implicit none
   integer(kind=I4), intent(in) :: g, d
   integer(kind=I4), dimension(:), intent(inout) :: itabref
   integer(kind=I4), dimension(:), intent(inout) :: itab1
   real(kind=R8), dimension(:), intent(inout)    :: rtab2
      integer(kind=I4) :: i, j, mil, cle, itmp
      real(kind=R8)    :: rtmp
      i = g
      j = d
      mil = (g+d)/2
      cle = itabref(mil)

      if (g>=d) return

      do while (i<=j)
         do while (itabref(i)<cle)
            i = i + 1
         enddo
         do while (itabref(j)>cle)
            j = j - 1
         enddo
         if (i<=j) then
            ! échange des éléments du tableau
            itmp       = itabref(i)
            itabref(i) = itabref(j)
            itabref(j) = itmp
            ! échange des éléments du vecteur 2
            itmp     = itab1(i)
            itab1(i) = itab1(j)
            itab1(j) = itmp
            ! échange des éléments du vecteur 3
            rtmp     = rtab2(i)
            rtab2(i) = rtab2(j)
            rtab2(j) = rtmp

            i = i + 1
            j = j - 1
         endif
      enddo

      if (g<j) call sort_int_1int_1real(g, j, itabref, itab1, rtab2)
      if (d>i) call sort_int_1int_1real(i, d, itabref, itab1, rtab2)

   return
   endsubroutine sort_int_1int_1real


   !=========================================================================================
   !<@note
   !   Subroutine to sort a vector of reals, according a vector of integers
   ! @endnote
   !-----------------------------------------------------------------------------------------
   recursive subroutine sort_int_1real(g, d, itabref, rtab1)
   implicit none
   integer(kind=I4), intent(in) :: g, d
   integer(kind=I4), dimension(:), intent(inout) :: itabref
   real(kind=R8), dimension(:), intent(inout)    :: rtab1
      integer(kind=I4) :: i, j, mil, cle, itmp
      real(kind=R8)    :: rtmp
      i = g
      j = d
      mil = (g+d)/2
      cle = itabref(mil)

      if (g>=d) return

      do while (i<=j)
         do while (itabref(i)<cle)
            i = i + 1
         enddo
         do while (itabref(j)>cle)
            j = j - 1
         enddo
         if (i<=j) then
            ! échange des éléments du tableau
            itmp       = itabref(i)
            itabref(i) = itabref(j)
            itabref(j) = itmp
            ! échange des éléments du vecteur 3
            rtmp     = rtab1(i)
            rtab1(i) = rtab1(j)
            rtab1(j) = rtmp

            i = i + 1
            j = j - 1
         endif
      enddo

      if (g<j) call sort_int_1real(g, j, itabref, rtab1)
      if (d>i) call sort_int_1real(i, d, itabref, rtab1)

   return
   endsubroutine sort_int_1real


endmodule sort_arrays
