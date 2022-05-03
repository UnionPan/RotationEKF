function prrp= get_theta_dot_rp_free(theta,  w)
prrp = [1 0 0; 0 1 0] * get_theta_dot(theta,  w);
end