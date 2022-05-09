function ya = acc_meter(theta) 
 theta_x = theta(1);
 theta_y = theta(2);
 hx = 9.81 * [-sin(theta_y); cos(theta_y)*sin(theta_x); cos(theta_y)*cos(theta_x)];
 eta = sqrt(0.001) * randn(3,1);
 ya = hx + eta;
end