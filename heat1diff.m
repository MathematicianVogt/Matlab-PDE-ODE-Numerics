clear all
% p6.m - variable coefficient wave equation

% Grid, variable coefficient, and initial data:
  N = 64; h = 2*pi/N; x = h*(1:N); t = 0; dt = .01;
  [a,DM]=fourdif(N,2);
  v = cos(x) +sin(2*x); 
  c=.1
% Time-stepping by leap frog formula:
  tmax = 8; tplot = .15; clf, drawnow, set(gcf,'renderer','zbuffer')
  plotgap = round(tplot/dt); dt = tplot/plotgap;
  nplots = round(tmax/tplot);
  data = [v; zeros(nplots,N)]; tdata = t;
  tic
  for i = 1:nplots
    for n = 1:plotgap
      t = t+dt;
      v_hat = fft(v);
      b= [0:N/2 -N/2+1:-1];
      w_hat = -1*(b.^2).* v_hat;
      w = real(ifft(w_hat)); 
      vnew = v + c*dt.*(DM*v);  v = vnew;
    end
    data(i+1,:) = v; tdata = [tdata; t];
  end
  toc
 
 for i=1:nplots
     plot(x,data(i,:))
     %axis([x(1) x(end),0 4])
     shg
     pause(.2)
 end