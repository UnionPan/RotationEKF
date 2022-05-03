function ya = acc_meter(theta_x, theta_y)
 hx = 9.81 * [-sin(theta_y); cos(theta_y)*sin(theta_x); cos(theta_y)*cos(theta_x)];
 eta = 0.001 * randn(3,1);
 ya = hx + eta;
end