clear all
% p6.m - variable coefficient wave equation

% Grid, variable coefficient, and initial data:
  N = 32; h = 2/N; x = -1:h:1; t = 0; dt = .001;
  v = cos(x).^2 + exp(sin(x))-x.^5; 
  v(1)=0;
  v(end)=10;
  f=v;
  v=v';
  v2=v;
  [D,y]=cheb(N);
  D2=D^2;
  D2(1,1)=1;
  D2(1,2:end)=0;
  D2(end,end)=1;
  D2(end,1:end-1)=0;
  c=10;
  I=zeros(size(D2));
  I(2:N,2:N)=eye(N-1);
  I(1,:)=0;
  I(end,:)=0;
  realdif=I-c*dt*D2;
  realdif(1,1)=1;
  realdif(end,end)=1;

% Time-stepping by leap frog formula:
  tmax = 10; tplot = dt; %clf, drawnow, set(gcf,'renderer','zbuffer')
  plotgap = round(tplot/dt);
  nplots = round(tmax/tplot);
  data = [f; zeros(nplots,N+1)]; tdata = t;
  tic
  for i = 1:nplots
    for n = 1:plotgap
      t = t+dt;
      
      vnew = realdif\v;
       v = vnew;
     
    end
    data(i+1,:) = v; tdata = [tdata; t];
  end
  toc
 
 for i=1:nplots
     plot(x,data(i,:))
     %axis([x(1) x(end),0 4])
     shg
     pause(.3)
 end