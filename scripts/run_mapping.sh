#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
workspace_root="$(cd -- "${script_dir}/.." && pwd)"
workspace_setup="${workspace_root}/install/setup.bash"
rviz="${1:-true}"

if [[ "${rviz}" != "true" && "${rviz}" != "false" ]]; then
  echo "Usage: $0 [true|false]" >&2
  exit 2
fi

if [[ ! -f "${workspace_setup}" ]]; then
  echo "Workspace is not built. Run ./scripts/build_workspace.sh first." >&2
  exit 1
fi

# shellcheck disable=SC1090
source "${workspace_setup}"
exec ros2 launch fast_lio mapping.launch use_sim_time:=true rviz:="${rviz}"
