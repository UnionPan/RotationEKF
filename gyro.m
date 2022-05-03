function yg = gyro(w_x, w_y, w_z ,bias)
 eta = 1.5 * 1e-4 *randn(3,1)
 yg = [w_x; w_y; w_z] + bias + eta;
end