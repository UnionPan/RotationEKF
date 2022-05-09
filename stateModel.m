function next_state = stateModel(current_state, gyro_input, dt)
   eta = sqrt(1.5) * 1e-2 *randn(3,1);
 
   bias = [0.2; 0.1; 0.15];
   w = gyro_input - bias - eta;
   
   next_state = current_state + get_theta_dot(current_state, w)  * dt;
end