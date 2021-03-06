%Ryan Vogt
%3d heat equation with dirchetlet condtions
%going to implement solution with neumann later.
%I'll implement implict burgers and thin film with pseudo spectral and
% newtons method 2/3/2015
clear all
N = 8; h = 2/N; x = -1:h:1; y = -1:h:1; z = -1:h:1; t = 0; dt = h/4;
[X,Y,Z] = meshgrid(x,y,z);

v = X.^2 +Y.^2 +Z.^2;
c=.01;

%set up cheb matrix and cheb operator for 3d space
[D,y]=cheb(N);
I=eye(N+1);
D2=D^2;
Dx2 = kron(I,kron(I,D2));
Dy2 = kron(I,kron(D2,I));
Dz2 = kron(D2,kron(I,I));
L = Dx2+Dy2+Dz2;
realdif=eye(length(L))-c*dt*L;

boundval=0;
  
  for i=1:N+1
        v(1,:,i)=boundval;
        v(end,:,i)=boundval;
        for j=2:length(v)-1
            v(j,1,i)=boundval;
            v(j,length(v),i)=boundval;
        end
  end
  v(:,:,1)=boundval;
  v(:,:,end)=boundval;
  
  
  tmax = 20; tplot = .15; %clf, drawnow, set(gcf,'renderer','zbuffer')
  plotgap = round(tplot/dt); dt = tplot/plotgap;
  nplots = round(tmax/tplot);
  data=zeros(N+1,N+1,N+1,nplots);
  data(:,:,:,1) = v; 
  tdata = t;
  g=v(:);
  
  

  %realdif(1:(N+1)^2,1:(N+1)^2)=eye((N+1)^2);
  %realdif(end+1-(N+1)^2:end,end+1-(N+1)^2:end)=eye((N+1)^2);
%   for i=1:N+1
%     realdif(i,:)=0;
%     realdif(i,i)=1; 
%         
% end
% for i=1:N+1
% 
%     realdif(end+1-i,:)=0;
%     realdif(end+1-i,end+1-i)=1;
%     
% end
%   
% squared = (N+1)^2;
% cubed = (N+1)^3;
% 
% for t=squared: squared: cubed - squared
%      for i = 1:squared
%        if t+i<=N+1
%            realdif(i+t,:)=0;
%            realdif(i+t,i+t)=1;
%        
%        elseif mod(i+t,squared)==1 || mod(i+t,squared)==0
%               realdif(i+t,:)=0;
%               realdif(i+t,i+t)=1;
%        
%        elseif(i+t>= squared-(N+1))
%                realdif(i+t,:)=0;
%               realdif(i+t,i+t)=1;
%         end
%                
%                
%      end
%     
% end
% tic
px=find(X==1 | X==-1);
py=find(Y==1 | Y==-1);
pz=find(Z==1 | Z==-1);
g(px)=0;
g(py)=0;
g(pz)=0;
realdif(px)=1;
realdif(py)=1;
realdif(pz)=1;

for i=1:length(px)
        realdif(px(i),:)=0;
        realdif(px(i),px(i))=1;
end

for i=1:length(py)
        realdif(py(i),:)=0;
        realdif(py(i),py(i))=1;
end

for i=1:length(pz)
        realdif(pz(i),:)=0;
        realdif(pz(i),pz(i))=1;
end
% toc
% for i=1:(N+1)^3
%     if realdif(i,i)==1;
%         realdif(i,:)=0;
%         realdif(i,i)=1;
%     end
%     
% end

 %keyboard

  
  %solve implict heat equation system.
  for i = 1:nplots
    for n = 1:plotgap
      t = t+dt;
      gnew = realdif\g;  g = gnew;
%         mesh(X,Y,gnew)
%         shg
%         pause(.1)
      j=reshape(g,(N+1),(N+1),N+1);
    end
   data(:,:,:,i+1) = j; 
tdata = [tdata; t];
end
figure;
colormap jet;
xslice = [-.5,0,.5]; 
yslice = 1; 
zslice = [-1,0,1];





for i=1:nplots
   
    slice(X,Y,Z,data(:,:,:,i),xslice,yslice,zslice)
    axis([-1 1 -1 1 -1 1]);
    colorbar;
    ylabel('y');
    
    F(i)=getframe;
  
end

% for i=1:nplots
%     patch(isosurface(X,Y,Z,data(:,:,:,i),10));
%     axis([-1 1 -1 1 0 5]);
%     F(i)=getframe;
%   
% end

  