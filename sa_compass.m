function yc = sa_compass(theta, std)
eta = std * randn()
yc = theta(3) + eta;
end