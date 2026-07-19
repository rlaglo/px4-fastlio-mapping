#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
workspace_root="$(cd -- "${script_dir}/.." && pwd)"
ros_distro="${ROS_DISTRO:-humble}"

if [[ "${ros_distro}" != "humble" ]]; then
  echo "This release supports ROS 2 Humble; got ROS_DISTRO=${ros_distro}." >&2
  exit 1
fi

ros_setup="/opt/ros/${ros_distro}/setup.bash"
if [[ ! -f "${ros_setup}" ]]; then
  echo "ROS 2 Humble was not found at ${ros_setup}." >&2
  exit 1
fi

for command_name in vcs rosdep; do
  if ! command -v "${command_name}" >/dev/null 2>&1; then
    echo "Missing command: ${command_name}" >&2
    echo "Install python3-vcstool and python3-rosdep, then retry." >&2
    exit 1
  fi
done

# shellcheck disable=SC1090
source "${ros_setup}"

mkdir -p "${workspace_root}/src"
vcs import --recursive "${workspace_root}/src" < "${workspace_root}/dependencies.repos"

if [[ ! -d /etc/ros/rosdep/sources.list.d ]]; then
  echo "rosdep is not initialized. Run 'sudo rosdep init' once, then retry." >&2
  exit 1
fi

rosdep update
rosdep install \
  --from-paths "${workspace_root}/src" \
  --ignore-src \
  --rosdistro "${ros_distro}" \
  --yes

if [[ ! -f /usr/local/lib/liblivox_lidar_sdk_shared.so ]]; then
  cat >&2 <<'EOF'
Livox-SDK2 was not detected. Install it before building:
https://github.com/Livox-SDK/Livox-SDK2#installation
EOF
  exit 1
fi

echo "Workspace sources and system dependencies are ready."
