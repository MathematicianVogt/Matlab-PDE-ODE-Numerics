clear all
% p6.m - variable coefficient wave equation

% Grid, variable coefficient, and initial data:
  N = 128; h = 2*pi/N; x = h*(1:N); t = 0; dt = .01;
  
  v = sin(x) +(1/2)*sin(x/2); 
  
  esp=.01;
% Time-stepping by leap frog formula:
  tmax = 8; tplot = .15; clf, drawnow, set(gcf,'renderer','zbuffer')
  plotgap = round(tplot/dt); dt = tplot/plotgap;
  nplots = round(tmax/tplot);
  data = [v; zeros(nplots,N)]; tdata = t;
  tic
  for i = 1:nplots
    for n = 1:plotgap
      t = t+dt;
      v_hatx = fft(v);
      w_hatx = 1i*[0:N/2-1 0 -N/2+1:-1] .* v_hatx;
      wx = real(ifft(w_hatx)); 
      v_hatxx = fft(v);
      b= [0:N/2 -N/2+1:-1]; %-(N/2) +1: 1: (N/2);
      w_hatxx = -1*(b.^2).* v_hatxx;
      wxx = real(ifft(w_hatxx)); 
      vnew = v+ dt.*(-wx.*v + esp.*wxx);  v = vnew;
    end
    data(i+1,:) = v; tdata = [tdata; t];
  end
  toc
 
 for i=1:nplots
     plot(x,data(i,:))
     %axis([x(1) x(end),0 4])
     shg
     pause(.5)
 end