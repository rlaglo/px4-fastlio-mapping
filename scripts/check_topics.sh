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

required_topics=(
  /clock
  /lidar/points
  /imu/data
  /Odometry
  /cloud_registered_body
  /octomap_full
  /frontier/points
  /fmu/in/vehicle_visual_odometry
)

topic_list="$(ros2 topic list)"
missing=0

for topic_name in "${required_topics[@]}"; do
  if grep -Fxq "${topic_name}" <<< "${topic_list}"; then
    printf 'OK       %s\n' "${topic_name}"
  else
    printf 'MISSING  %s\n' "${topic_name}"
    missing=1
  fi
done

exit "${missing}"
