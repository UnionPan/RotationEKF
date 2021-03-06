rng(2022);    % For repeatable results
dt = 0.1;     % seconds
simTime = 20;   % seconds
tspan = 0:dt:simTime;
trueInitialState = 0.01 * randn(3,1);  % [theta_x; theta_y; theta_z; ]
numSteps = length(tspan);
trueStates = zeros(3,numSteps);
trueStates(:,1) = trueInitialState;
measurements = zeros(3,numSteps);
bias = [0.2 ; 0.1; 0.15];
%randomly generate the gyro reading as control inputs
gyro_inputs = [cos(tspan) + bias(1); sin(tspan) + bias(2); zeros(1, length(tspan)) + bias(3)] - 1.5 * 1e-2 * randn(3,numSteps);
%initialize the state estimation 
stateEstimates = zeros(3,numSteps);
stateEstimates(:,1) = 0.01 * randn(3,1);
P = zeros(3,3,numSteps);
P(:,:,1) = 0.0001 * eye(3);
for i = 2:length(tspan)
    if i ~=1
        trueStates(:,i) = stateModel(trueStates(:,i-1), gyro_inputs(:, i-1), dt);
    end
    measurements(:,i-1) = acc_meter(trueStates(:,i-1));
    [stateEstimates(:,i), P(:,:,i)] = extended_kf(stateEstimates(:, i-1), gyro_inputs(:,i-1), measurements(:,i-1), P(:,:,i-1), dt);
    P(:,:,i)
    %stateEstimates(:,i) - trueStates(:,i)
end
measurements(:,i) = acc_meter(trueStates(:,i));


figure(1)
plot3(trueStates(1,:), trueStates(2,:), tspan);
hold on
plot3(stateEstimates(1,:), stateEstimates(2,:), tspan);
xlabel('\theta_x')
ylabel('\theta_y')

figure(2)
plot3(gyro_inputs(1,:), gyro_inputs(2,:), tspan);
xlabel('w_x')
ylabel('w_y')

figure(3)
subplot(2,1,1)
plot(tspan, measurements(1,:))
xlabel('time')
ylabel('\theta_x')
subplot(2,1,2)
plot(tspan, measurements(2,:))
xlabel('time')
ylabel('\theta_y')







