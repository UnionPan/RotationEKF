function [state_estimates, P] = extended_kf(current_estimates, gyro_input, acc_output, current_P, dt)
 theta_x = current_estimates(1);
 theta_y = current_estimates(2);
 %linearize the system dynamics model around the current estimates
 bias = [0.2 ; 0.1; 0.15];
 A = [cos(theta_x)*tan(theta_y)*(gyro_input(2) - bias(2)) - sin(theta_x)*tan(theta_y)* (gyro_input(3) - bias(3)), sin(theta_x)/(cos(theta_y)^2) + cos(theta_x)/(cos(theta_y)^2) ,  0; 
     -sin(theta_x)*(gyro_input(2) - bias(2)) - cos(theta_x)*(gyro_input(3) - bias(3)), 0 , 0;
     cos(theta_x)* (gyro_input(2) - bias(2)) / cos(theta_y) - sin(theta_x)* (gyro_input(3) - bias(3)) / cos(theta_y), (sin(theta_x) * sin(theta_y))/(cos(theta_y)^2)*(gyro_input(2) - bias(2)) - (cos(theta_x) * sin(theta_y))/(cos(theta_y)^2)*(gyro_input(3) - bias(3)), 0 ];
 B = [1, sin(theta_x)*tan(theta_y), cos(theta_x) * tan(theta_y);
     0, cos(theta_x), -sin(theta_y); 
     0, sin(theta_x)/cos(theta_y), cos(theta_x)/cos(theta_y)];
 %linearize the observer model around current estimates
 C = [0 , -cos(theta_y), 0; 
     cos(theta_y) * cos(theta_y) , -sin(theta_y)*sin(theta_x), 0;
     -cos(theta_y) * sin(theta_x), -cos(theta_x) * sin(theta_y), 0] ;
 F = - [1, sin(theta_x)*tan(theta_y), cos(theta_x) * tan(theta_y)
     0, cos(theta_x), -sin(theta_y);
     0,sin(theta_x)/cos(theta_y), cos(theta_x)/cos(theta_y)];
 V = 1.5e-4;
 %C' * sqrt(0.001)^(-1)
 Q = F*V*F';
 U = C'* sqrt(0.001)^(-1);
 %[P, L, H] = care(A, U, Q);
 dP = A * current_P + current_P * A' + Q - current_P * U * U' * current_P;
 P = current_P + dP * dt;
 G = P * C' * 0.001^(-1);
 state_change =  get_theta_dot(current_estimates, gyro_input) + G * (acc_output - acc_meter(current_estimates));
 %acc_output - acc_meter(current_estimates)
 state_estimates = current_estimates +  state_change * dt;
end