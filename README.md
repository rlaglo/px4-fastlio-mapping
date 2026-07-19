# PX4 SITL FAST-LIO Mapping

Reproducible 3D LiDAR-inertial mapping with PX4 SITL, Gazebo, ROS 2,
FAST-LIO, and OctoMap.

> [!IMPORTANT]
> This repository is being prepared for its first reproducible release. Source
> revisions and setup commands will be published after clean-clone validation.

## Goal

This project provides an end-to-end simulation pipeline:

```text
PX4 SITL + Gazebo 3D LiDAR/IMU
              |
              v
         ros_gz_bridge
              |
              v
           FAST-LIO
          /        \
         v          v
PX4 external      OctoMap
   vision        3D mapping
```

The first release will use an x500 multicopter with a simulated 3D LiDAR as
the reference vehicle.

## Reference environment

- Ubuntu 22.04
- ROS 2 Humble
- PX4 SITL with Gazebo
- FAST-LIO
- OctoMap

Exact upstream and fork revisions will be pinned in `dependencies.repos`.

## Repository policy

- Modified third-party projects are maintained as forks with their upstream
  history and licenses preserved.
- Unmodified dependencies are pinned to an upstream tag or commit.
- Generated workspaces, maps, logs, and build artifacts are not committed.
- A release is published only after validation from a clean checkout.

## Planned first release

- One-command dependency import and workspace build
- PX4 SITL and Gazebo launch script
- Gazebo-to-ROS LiDAR and IMU bridge
- FAST-LIO odometry and point-cloud mapping
- FAST-LIO odometry input to PX4 external vision
- OctoMap occupancy mapping and frontier visualization
- Topic, frame, and troubleshooting documentation

See [docs/architecture.md](docs/architecture.md) for the planned component
boundaries.

## License

The integration files in this repository are licensed under the BSD 3-Clause
License. Forked and imported projects retain their own licenses; they will be
listed separately before the first release.
