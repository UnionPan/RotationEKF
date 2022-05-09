function pr = get_theta_dot(theta, w)
theta_x = theta(1);
theta_y = theta(2);
Jacobian = [[1, sin(theta_x)* tan(theta_y), cos(theta_x) * tan(theta_y)] ;
            [0, cos(theta_x), -sin(theta_x)] ;
            [0, sin(theta_x)/cos(theta_y), cos(theta_x)/cos(theta_y)] ];
pr = Jacobian * w;
end


