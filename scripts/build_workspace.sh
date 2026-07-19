#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
workspace_root="$(cd -- "${script_dir}/.." && pwd)"
ros_setup="/opt/ros/humble/setup.bash"

if [[ ! -f "${ros_setup}" ]]; then
  echo "ROS 2 Humble was not found at ${ros_setup}." >&2
  exit 1
fi

# shellcheck disable=SC1090
source "${ros_setup}"
cd "${workspace_root}"
colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release
