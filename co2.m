load -ASCII co2.mat 
t = co2(:,1)';
y = co2(:,2)';
plot(t,y,'-o')