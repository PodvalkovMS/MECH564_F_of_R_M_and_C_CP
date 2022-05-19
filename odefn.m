function dydt = odefn(t,y,Y_int,w)


%Forward Kinematics
[Yd,Yddot,Yddot_double, Ynew_dot, Ynew]=kinematic(w,t,y); 
if t>0 
Y_int(1:3)=Ynew';
Y_int(4:6)=Ynew_dot';
end  

%Compute Jacobian
[J,Jdot,qdot]=jacobian(y);


%Linear  controller
e=Yd-Y_int(1:3).';
edot=Yddot-Y_int(4:6).';
kd=1.5
kp=1.7
u=Yddot_double+(kd*edot)+(kp*e);

  
%Compute Dynamics
[D,C,g] = dynamic(y);


% Non-linear Feedback
%u=[0 0 1]
Tou=D*inv(J)*(u-Jdot*qdot)+(C*qdot)+g;
y(4:6)=qdot.';

% Robot Dynamics
%Tou=[1; 0; 0];
qdot_double=inv(D)*(Tou-(C*y(4:6))-g);
dydt(1,1)=y(4);%q1-dot
dydt(2,1)=y(5);%q2-dot
dydt(3,1)=y(6);%q3-dot

dydt(4,1)=qdot_double(1);
dydt(5,1)=qdot_double(2);
dydt(6,1)=qdot_double(3);

end