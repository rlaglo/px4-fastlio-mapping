#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
workspace_root="$(cd -- "${script_dir}/.." && pwd)"
workspace_setup="${workspace_root}/install/setup.bash"

if [[ ! -f "${workspace_setup}" ]]; then
  echo "Workspace is not built. Run ./scripts/build_workspace.sh first." >&2
  exit 1
fi

# shellcheck disable=SC1090
source "${workspace_setup}"

bridges=(
  "/lidar/points@sensor_msgs/msg/PointCloud2[gz.msgs.PointCloudPacked"
  "/imu/data@sensor_msgs/msg/Imu[gz.msgs.IMU"
  "/clock@rosgraph_msgs/msg/Clock[gz.msgs.Clock"
)

exec ros2 run ros_gz_bridge parameter_bridge "${bridges[@]}"
