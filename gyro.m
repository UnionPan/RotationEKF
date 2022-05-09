function yg = gyro(w ,bias)
 eta = sqrt(1.5 * 1e-4) *randn(3,1);
 yg = w + bias + eta;
end