x=[3, 4, 5, 6, 7, 8, 9, 10];
y1=[1,1,4,4,22,67,173,334]
y2=[2,2,2,2,4,5,6,7]
y3=[1,3,2,3,3,3,4,5]
y4=[0,0,0,0,0,0,0,0]

x2=[100,500,1000,3000]


xlabel('N') % x-axis label
ylabel('Time in milliseconds ') % y-axis label

plot(x,y1,x,y2,x,y3,x,y4);
title('N range from 3-10');
legend('OPtsp', 'GreedyTSP', 'MSTTSP' ,'BitonicTSP');
axis([3 10 0 50])


% y1=[137,1768,6798,61087]
% y2=[115,127,642,15565]
% y3=[2,29,57,543]
% 
% 
% x=[100,500,1000,3000]
% xlabel('N') % x-axis label
% ylabel('Time in milliseconds ') % y-axis label
% 
% plot(x,y1,x,y2,x,y3);
% title('N range for large values');
% legend('GreedyTSP', 'MSTTSP' ,'BitonicTSP');
% axis([100 3000 0 62000])

