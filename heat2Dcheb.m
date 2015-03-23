
clear all
N = 16; h = 2/N; x = -1:h:1; y = -1:h:1; t = 0; dt = .1;
[X,Y] = meshgrid(x,y);
%v=X.*Y;
v = cos(X) +sin(2.*Y) +cos(Y) +sin(2.*Y);
%v= zeros(size(X));
%v((N+2)/2,(N+2)/2)=1;

boundval=0;
v(1,:)=boundval;
v(end,:)=boundval;
for i=2:length(v)-1
    v(i,1)=boundval;
    v(i,length(v))=boundval;
end


c=.1;
% Time-stepping by leap frog formula:
  tmax = 100; tplot = .15; clf, drawnow, set(gcf,'renderer','zbuffer')
  plotgap = round(tplot/dt); dt = tplot/plotgap;
  nplots = round(tmax/tplot);
  data=zeros(N+1,N+1,nplots);
  data(:,:,1) = v; 
tdata = t;
[D,y]=cheb(N);
D2=D^2;
uxx=kron(eye(N+1),D2);
uyy=kron(D2,eye(N+1));
L=uxx+uyy;
realdif=eye(length(L))-c*dt*L;
g=v(:);
for i=1:N+1
    realdif(i,:)=0;
    realdif(i,i)=1; 
        
end
for i=1:N+1

    realdif(end+1-i,:)=0;
    realdif(end+1-i,end+1-i)=1;
    
end

for i=N+2:N+1:(N^2)-(N-2)
   realdif(i,:)=0;
   realdif(i,i)=1;
   realdif(i+N,:)=0;
   realdif(i+N,i+N)=1;
end




for i = 1:nplots
    for n = 1:plotgap
      t = t+dt;
      gnew = realdif\g;  g = gnew;
%         mesh(X,Y,gnew)
%         shg
%         pause(.1)
      j=reshape(g,N+1,N+1);
    end
   data(:,:,i+1) = j; 
tdata = [tdata; t];
end
figure;
colormap colorcube;
for i=1:nplots
    mesh(X,Y,data(:,:,i));
    axis([-1 1 -1 1 0 5]);
    F(i)=getframe;
  
end
movie(F)