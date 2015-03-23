#include "fintrf.h"
!Euler Program for the differential equation y'=2x on the interval -10 to 10, such that y(0)=100
!Will write the fortran program here and call this program from a MATLAB script, this will be used to plot with the use of MATLAB.


subroutine Euler
real deltat,start,end,y0,N,currentPos,newSol
integer endN
REAL, DIMENSION(1000) :: y,x,error

!deltat - time step
!start - start of where the approximation of the differential equation is taking place
!end - end of where the approximation of the differential equation is taking place
!N - number of steps taken between start and finish
y0=100
start=-10
end=10
endN=100
N=100
deltat=(end-start)/N
currentPos=start
x(1)=start
y(1)=y0
error(1)=0

write(*,*), deltat


	do i=2,endN
		currentPos=start + i*deltat
		newSol=y(i-1) + deltat*f(currentPos)
		x(i)=currentPos
		y(i)=newSol
		error(i)=abs((currentPos*currentPos)- newSol)

		
	end do

	do i=1,endN
		write(*,*), error(i)
	end do
end


subroutine f(x)
real x
evalFunc=2*x
return
end
