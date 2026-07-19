# Architecture

## Data flow

```mermaid
flowchart LR
    GZ[Gazebo 3D LiDAR and IMU] --> RGB[ros_gz_bridge]
    RGB --> CONV[Gazebo point-cloud converter]
    RGB --> LIO[FAST-LIO]
    CONV --> LIO
    LIO -->|Odometry| PXB[PX4 ROS 2 odometry bridge]
    PXB -->|VehicleOdometry| PX4[PX4 EKF2 external vision]
    LIO -->|Registered point cloud| OCTO[OctoMap server]
    OCTO --> FRONTIER[Frontier visualization]
```

## Repository boundaries

The integration repository owns setup, launch orchestration, pinned dependency
metadata, and user documentation. Algorithm and simulator changes remain in
their respective forks so that upstream history, licensing, and future rebases
stay clear.

| Component | Planned source |
| --- | --- |
| Workspace orchestration and documentation | This repository |
| LiDAR-inertial odometry and Gazebo conversion | FAST-LIO ROS 2 fork |
| Odometry frame and message conversion | `px4bridge` |
| Occupancy mapping and frontier visualization | OctoMap mapping fork |
| Vehicle message definitions | Pinned upstream `px4_msgs` revision |
| Vehicle model and world | PX4 Gazebo models fork |
| Autopilot configuration | PX4-Autopilot mapping branch |

## Release boundary

The initial release targets a single x500 3D LiDAR demonstration. Competition
vehicles, unrelated worlds, planners, and multi-vehicle behavior are outside
the initial release scope.
