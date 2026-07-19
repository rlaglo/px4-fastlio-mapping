# Architecture

## Data flow

```mermaid
flowchart LR
    GZ[Gazebo 3D LiDAR and IMU] --> RGB[ros_gz_bridge]
    RGB -->|/lidar/points| CONV[Gazebo point-cloud converter]
    RGB -->|/imu/data| LIO[FAST-LIO]
    CONV -->|/lio/raw_points| LIO
    LIO -->|Odometry| PXB[PX4 ROS 2 odometry bridge]
    PXB -->|VehicleOdometry| PX4[PX4 EKF2 external vision]
    LIO -->|Registered point cloud| OCTO[OctoMap server]
    OCTO --> FRONTIER[Experimental frontier visualization]
```

## Repository boundaries

The integration repository owns setup, launch orchestration, pinned dependency
metadata, and user documentation. Algorithm and simulator changes remain in
their respective forks so that upstream history, licensing, and future rebases
stay clear.

| Component | Source boundary |
| --- | --- |
| Workspace orchestration and documentation | This repository |
| LiDAR-inertial odometry and Gazebo conversion | [`rlaglo/FAST_LIO_ROS2`](https://github.com/rlaglo/FAST_LIO_ROS2) |
| Odometry frame and message conversion | [`rlaglo/px4bridge`](https://github.com/rlaglo/px4bridge) |
| Occupancy mapping and experimental frontier visualization | [`rlaglo/octomap_mapping`](https://github.com/rlaglo/octomap_mapping) |
| Vehicle message definitions | Pinned upstream [`PX4/px4_msgs`](https://github.com/PX4/px4_msgs) revision |
| Vehicle model and world | PX4 Gazebo models fork (publication pending) |
| Autopilot configuration | PX4-Autopilot mapping branch (publication pending) |

## Release boundary

The initial release targets a single x500 3D LiDAR demonstration. Competition
vehicles, unrelated worlds, planners, and multi-vehicle behavior are outside
the initial release scope. Frontier extraction remains experimental until its
detection behavior and topic interfaces are validated.
