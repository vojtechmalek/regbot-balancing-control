# REGBOT: self-balancing robot driving to a target position

Group assignment ("Note 2") for 34721 Linear Control Design 1 at the Technical University of Denmark, spring 2025.

The REGBOT is a two-wheeled robot that has to balance like an inverted pendulum, which is unstable without control. The goal was to make it drive to a given position while staying balanced. We built this from four nested controllers, each one wrapped around the one before:

1. **Wheel speed (PI):** controls wheel velocity from motor voltage, using a transfer function identified from experiments. Settling time about 0.26 s with no overshoot.
2. **Balance:** keeps the requested tilt angle. The linearised tilt dynamics have a pole in the right half-plane, so we stabilised them with a post-integrator and checked the result with a Nyquist plot.
3. **Velocity:** sets the forward speed by changing the tilt angle.
4. **Position:** drives the robot to a target distance.

We designed and simulated the controllers in MATLAB/Simulink, then ran them on the real robot in a test mission.

**Files**

- `Report.pdf`: the report, with Bode/Nyquist plots, step responses and test results
- `Controller.m`: controller design script
- `Note2_Final.mlx`: MATLAB live script with the full design process
- `regbot_1mg_full.slx`: Simulink model of the robot and controllers

**Video of the robot:** *(paste the video link from the report here)*
