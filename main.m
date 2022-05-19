%Main Function
%cases


% w=(pi/4)
% Y_int=[-0.7765 0 0.045 0 0 0];
%qint=[0.193 -2.59 0.637 0 0 0];
    
% Y_int=[-0.5 -0.1 0 0 0 0];
%qint=[0.49 -2.16 -0.32 0 0 0];

w=(pi/2)
 %Y_int=[-0.7765 0 0.045 0 0 0];
 %qint=[0.193 -2.59 0.637 0 0 0];
   
 Y_int=[-0.5 -0.1 0 0 0 0];
 qint=[0.49 -2.16 -0.32 0 0 0];

tspan=[0 20];

%ODE
[t,y]=ode45(@(t,y) odefn(t,y,Y_int,w),tspan,qint);

%Plot Grafics
q=y(:,1:3);
qdot_new=y(:,4:6);
[a,b]=size(q);
Y=zeros(a,b);
Yd=zeros(a,b);
for i=1:a
    q1=q(i,1);
    q2=q(i,2);
    q3=q(i,3);
    
    Y(i,1)=-0.02032*cos(q1)*cos(q2+q3) + 0.43307*cos(q1)*sin(q2+q3) + 0.4318*cos(q1)*cos(q2) - 0.14909*sin(q1);
    Y(i,2)=-0.02032*sin(q1)*cos(q2+q3) + 0.43307*sin(q1)*sin(q2+q3) + 0.4318*sin(q1)*cos(q2) + 0.14909*cos(q1);
    Y(i,3)=0.02032*sin(q2+q3) + 0.43307*cos(q2+q3) - 0.4318*sin(q2);
    
    Yd(i,1)=-0.2165*cos(w*t(i))-0.56;
    Yd(i,2)=0.25*sin(w*t(i));
    Yd(i,3)=0.125*cos(w*t(i))-0.08;
end

figure(1)
plot(t,q)
title('q')
xlabel('Time')
ylabel('q')
legend('q1','q2','q3')

figure(2)
plot(t,Y)
title('Position')
xlabel('Time')
ylabel('xyz')
legend('x','y','z')
error=Yd-Y;

figure(3)
plot(t,error*1000)
title('Position Error ')
xlabel('Time')
ylabel('Error mm')
legend('Error-x','Error-y','Error-z')


for i=1:a
[J]=jacobian_plot(q(i,:));
Ydot(i,:)=(J*qdot_new(i,:).').';


Yddot(i,1)= 0.2165*sin(w*t(i))*w;
Yddot(i,2)= 0.25*cos(w*t(i))*w;
Yddot(i,3)= -0.125*sin(w*t(i))*w;
end

error_dot=Yddot-Ydot;
error=Yd-Y;

figure(3)
subplot(2,1,1);
plot(t,error*1000)
title('4): ω = π/2 , Y˙ (0) = 0, and Y (0) = [−0.5m, −0.1m, 0.0m]T')
xlabel('Time')
ylabel('Position Error mm')
legend('Error-x','Error-y','Error-z')

subplot(2,1,2);
plot(t,error_dot)

xlabel('Time')
ylabel('Velocity Error')
legend('Error Dot-x','Error Dot-y','Error Dot-z')

