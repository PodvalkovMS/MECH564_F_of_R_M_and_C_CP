%compute  trajectory
function [Yd,Yddot,Yddot_double, Ydot,Y]=kinematic(w,t,q)

    q1=q(1);
    q2=q(2);
    q3=q(3);
    qdot1=q(4)
    qdot2=q(5)
    qdot3=q(6)

Y(1,1)=-0.02032*cos(q1)*cos(q2+q3) + 0.43307*cos(q1)*sin(q2+q3) + 0.4318*cos(q1)*cos(q2) - 0.14909*sin(q1);
Y(2,1)=-0.02032*sin(q1)*cos(q2+q3) + 0.43307*sin(q1)*sin(q2+q3) + 0.4318*sin(q1)*cos(q2) + 0.14909*cos(q1);
Y(3,1)=0.02032*sin(q2+q3) + 0.43307*cos(q2+q3) - 0.4318*sin(q2);
    
Ydot(1,1)=0.02032*sin(q1)*cos(q2+q3)*(qdot1)+0.02032*cos(q1)*sin(q2+q3)*(qdot2+qdot3) - 0.43307*sin(q1)*sin(q2+q3)*qdot1+0.43307*cos(q1)*cos(q2+q3)*(qdot2+qdot3) - 0.4318*sin(q1)*cos(q2)*qdot1-0.4318*cos(q1)*sin(q2)*qdot2 -0.14909*cos(q1)*qdot1;
Ydot(2,1)=-0.02032*cos(q1)*cos(q2+q3)*qdot1+0.02032*sin(q1)*sin(q2+q3)*(qdot2+qdot3) + 0.43307*cos(q1)*sin(q2+q3)*qdot1+0.43307*sin(q1)*cos(q2+q3)*(qdot2+qdot3) + 0.4318*cos(q1)*cos(q2)*qdot1 -0.4318*sin(q1)*sin(q2)*qdot2- 0.14909*sin(q1)*qdot1;
Ydot(3,1)=0.02032*cos(q2+q3)*(qdot2+qdot3) -0.43307*sin(q2+q3)*(qdot2+qdot3) - 0.4318*cos(q2)*qdot2;

Yd(1,1)=-0.2165*cos(w*t)-0.56;
Yd(2,1)=0.25*sin(w*t);
Yd(3,1)=0.125*cos(w*t)-0.08;

Yddot(1,1)=0.2165*sin(w*t)*w;
Yddot(2,1)=0.25*cos(w*t)*w;
Yddot(3,1)=-0.125*sin(w*t)*w;

Yddot_double(1,1)=0.2165*cos(w*t)*w^2;
Yddot_double(2,1)=-0.25*sin(w*t)*w^2;
Yddot_double(3,1)=-0.125*cos(w*t)*w^2;
end