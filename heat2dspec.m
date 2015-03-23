clear all
N = 32; h = 2*pi/N; x = h*(1:N); y = h*(1:N); t = 0; dt = .01;
[X,Y] = meshgrid(x,y);
v = cos(X) +sin(2.*Y) +cos(Y) +sin(2.*Y);
c=.5;

  tmax = 100; tplot = .15; clf, drawnow, set(gcf,'renderer','zbuffer')
  plotgap = round(tplot/dt); dt = tplot/plotgap;
  nplots = round(tmax/tplot);
  data=zeros(N,N,nplots);
  data(:,:,1) = v; 
tdata = t;
bx= [0:N/2 -N/2+1:-1]; by=bx;
[BX,BY]=meshgrid(bx,by);
for i = 1:nplots
    for n = 1:plotgap
      t = t+dt;
      vy_hat = fft2(v);
      wy_hat = -1*(BY.^2).* vy_hat;
      wy = real(ifft2(wy_hat));
      vx_hat = fft2(v);
      wx_hat = -1*(BX.^2).* vx_hat;
      wx = real(ifft2(wx_hat)); 
      vnew = v + c^2*dt.*(wx+wy);  v = vnew;
%         mesh(X,Y,v)
%         shg
%         pause(.1)
      
    end
   data(:,:,i+1) = v; 
tdata = [tdata; t];
end
  
for i=1:nplots
    mesh(X,Y,data(:,:,i));
    shg
    pause(.1)
end
  