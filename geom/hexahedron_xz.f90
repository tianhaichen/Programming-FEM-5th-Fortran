SUBROUTINE hexahedron_xz(iel,x_coords,y_coords,z_coords,coord,num)
! Used in p53
! This subroutine generates nodal coordinates and numbering for
! 8, 14 or 20-node "bricks" counting x-z planes in the y-direction.
!
 IMPLICIT NONE
 INTEGER,PARAMETER::iwp=SELECTED_REAL_KIND(15)
 INTEGER,INTENT(IN)::iel
 REAL(iwp),INTENT(IN)::x_coords(:),y_coords(:),z_coords(:)
 REAL(iwp),INTENT(OUT)::coord(:,:)
 INTEGER,INTENT(OUT)::num(:)
 REAL(iwp)::pt5=0.5_iwp
 INTEGER::fac1,fac2,ip,iq,is,iplane,nod,nxe,nze
 nxe=UBOUND(x_coords,1)-1
 nze=UBOUND(z_coords,1)-1
 nod=UBOUND(num,1)
 iq=(iel-1)/(nxe*nze)+1
 iplane=iel-(iq-1)*nxe*nze
 is=(iplane-1)/nxe+1 
 ip=iplane-(is-1)*nxe
 SELECT CASE(nod)
 CASE(8)
   fac1=(nxe+1)*(nze+1)*(iq-1)
   num(1)=fac1+is*(nxe+1)+ip
   num(2)=fac1+(is-1)*(nxe+1)+ip
   num(3)=num(2)+1
   num(4)=num(1)+1
   num(5)=(nxe+1)*(nze+1)*iq+is*(nxe+1)+ip
   num(6)=(nxe+1)*(nze+1)*iq+(is-1)*(nxe+1)+ip
   num(7)=num(6)+1
   num(8)=num(5)+1
!
   coord(1:2,1)=x_coords(ip)
   coord(5:6,1)=x_coords(ip)
   coord(3:4,1)=x_coords(ip+1)
   coord(7:8,1)=x_coords(ip+1)
!
   coord(1:4,2)=y_coords(iq)
   coord(5:8,2)=y_coords(iq+1)
!
   coord(2:3,3)=z_coords(is)
   coord(6:7,3)=z_coords(is)
   coord(1:4:3,3)=z_coords(is+1)
   coord(5:8:3,3)=z_coords(is+1)
!
 CASE(14)
   fac1=(2*nxe+1)*(2*nze+1)*(iq-1)
   fac2=(2*nxe+1)*(2*nze+1)*iq
   num(1)=fac1+is*(2*nxe+1)+ip
   num(2)=num(1)-(2*nxe+1)
   num(3)=num(2)+1
   num(4)=num(1)+1
   num(5)=num(2)+nxe+1
   num(6)=fac1+(nxe+1)*(nze+1)+nxe*nze+(is-1)*(2*nxe+1)+nxe+ip
   num(7)=num(6)-nxe
   num(8)=num(6)+1
   num(9)=num(8)+nxe
   num(10)=fac2+is*(2*nxe+1)+ip
   num(11)=num(10)-(2*nxe+1)
   num(12)=num(11)+1
   num(13)=num(10)+1
   num(14)=num(11)+nxe+1
!
   coord(1:2,1)=x_coords(ip)
   coord(6,1)=x_coords(ip)
   coord(10:11,1)=x_coords(ip)
   coord(5:9:2,1)=pt5*(x_coords(ip)+x_coords(ip+1))
   coord(14,1)=pt5*(x_coords(ip)+x_coords(ip+1))
   coord(3:4,1)=x_coords(ip+1)
   coord(8,1)=x_coords(ip+1)
   coord(12:13,1)=x_coords(ip+1)
!
   coord(1:5,2)=y_coords(iq)
   coord(6:9,2)=pt5*(y_coords(iq)+y_coords(iq+1))
   coord(10:14,2)=y_coords(iq+1)
!
   coord(2:3,3)=z_coords(is)
   coord(7,3)=z_coords(is)
   coord(11:12,3)=z_coords(is)
   coord(5:6,3)=pt5*(z_coords(is)+z_coords(is+1))
   coord(8:14:6,3)=pt5*(z_coords(is)+z_coords(is+1))
   coord(1:4:3,3)=z_coords(is+1)
   coord(9,3)=z_coords(is+1)
   coord(10:13:3,3)=z_coords(is+1)
!
 CASE(20)
   fac1=((2*nxe+1)*(nze+1)+(2*nze+1)*(nxe+1))*(iq-1)
   fac2=((2*nxe+1)*(nze+1)+(2*nze+1)*(nxe+1))*iq
   num(1)=fac1+(3*nxe+2)*is+2*ip-1
   num(2)=fac1+(3*nxe+2)*is-nxe+ip-1
   num(3)=num(1)-3*nxe-2
   num(4)=num(3)+1
   num(5)=num(4)+1
   num(6)=num(2)+1
   num(7)=num(1)+2
   num(8)=num(1)+1
   num(9)=fac2-(nxe+1)*(nze+1)+(nxe+1)*is+ip
   num(10)=num(9)-nxe-1
   num(11)=num(10)+1
   num(12)=num(9)+1
   num(13)=fac2+(3*nxe+2)*is+2*ip-1
   num(14)=fac2+(3*nxe+2)*is-nxe+ip-1
   num(15)=num(13)-3*nxe-2
   num(16)=num(15)+1
   num(17)=num(16)+1
   num(18)=num(14)+1
   num(19)=num(13)+2
   num(20)=num(13)+1 
!
   coord(1:3,1)=x_coords(ip)
   coord(9:10,1)=x_coords(ip)
   coord(13:15,1)=x_coords(ip)
   coord(5:7,1)=x_coords(ip+1)
   coord(11:12,1)=x_coords(ip+1)
   coord(17:19,1)=x_coords(ip+1)
   coord(4:8:4,1)=pt5*(x_coords(ip)+x_coords(ip+1))
   coord(16:20:4,1)=pt5*(x_coords(ip)+x_coords(ip+1))
!
   coord(1:8,2)=y_coords(iq)
   coord(13:20,2)=y_coords(iq+1)
   coord(9:12,2)=pt5*(y_coords(iq)+y_coords(iq+1))
!
   coord(1,3)=z_coords(is+1)
   coord(7:9,3)=z_coords(is+1)
   coord(12:13,3)=z_coords(is+1)
   coord(19:20,3)=z_coords(is+1)
   coord(3:5,3)=z_coords(is)
   coord(10:11,3)=z_coords(is)
   coord(15:17,3)=z_coords(is)
   coord(2:6:4,3)=pt5*(z_coords(is)+z_coords(is+1))
   coord(14:18:4,3)=pt5*(z_coords(is)+z_coords(is+1))
!
 CASE DEFAULT
   WRITE(11,'(a)')"Wrong number of nodes for hexahedral element"
   STOP
 END SELECT
RETURN
END SUBROUTINE hexahedron_xz
