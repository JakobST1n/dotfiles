#!/bin/sh

set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
REPO_ROOT=$(CDPATH= cd -- "${SCRIPT_DIR}/.." && pwd)
DEVCONTAINER_DIR="${REPO_ROOT}/Common/devcontainer"
DEVCONTAINER_DIR="DT_DOTFILES_DIR/Common/devcontainer"
WORKDIR=$(pwd)
HOMEDIR=${HOME}
CONTAINER_TOOL=${CONTAINER_TOOL:-}
DEFAULT_VARIANT=base
BASE_CONTAINER_PORT=7778
OPENCODE_CONTAINER_PORT=4096

detect_container_tool() {
    if [ -n "${CONTAINER_TOOL}" ]; then
        if command -v "${CONTAINER_TOOL}" >/dev/null 2>&1; then
            printf '%s\n' "${CONTAINER_TOOL}"
            return 0
        fi

        printf 'Configured container tool not found: %s\n' "${CONTAINER_TOOL}" >&2
        return 1
    fi

    if command -v podman >/dev/null 2>&1; then
        printf 'podman\n'
        return 0
    fi

    if command -v docker >/dev/null 2>&1; then
        printf 'docker\n'
        return 0
    fi

    printf 'Neither podman nor docker is available.\n' >&2
    return 1
}

ENGINE=

require_engine() {
    if [ -z "${ENGINE}" ]; then
        ENGINE=$(detect_container_tool) || exit 1
        printf 'Container runtime: %s\n' "${ENGINE}" >&2
    fi
}

usage() {
    cat <<EOF
Usage: $(basename "$0") [command] [options]

Commands:
  start                 Start or replace the devcontainer for the current directory
  stop                  Stop the devcontainer for the current directory
  restart               Restart the devcontainer for the current directory
  status                Show container status and mapped ports for the current directory
  ports                 Show mapped ports for the current directory
  shell                 Open an interactive shell in the current directory's container
  nvim [args...]        Run nvim inside the current directory's container
  opencode              Print the opencode URL for the current directory's container
  open <target>         Open one of: shell, nvim, opencode
  images                List available image variants from Common/devcontainer
  help                  Show this help

Options:
  -i, --image <name>    Image variant to use for start/restart (default: ${DEFAULT_VARIANT})

Examples:
  $(basename "$0") start --image python
  $(basename "$0") status
  $(basename "$0") open opencode
EOF
}

available_variants() {
    for file in "${DEVCONTAINER_DIR}"/Dockerfile*; do
        [ -f "${file}" ] || continue
        name=$(basename "${file}")
        case "${name}" in
            Dockerfile)
                printf 'base\n'
                ;;
            Dockerfile-*.m4)
                ;;
            Dockerfile-*)
                printf '%s\n' "${name#Dockerfile-}"
                ;;
        esac
    done | sort -u
}

variant_exists() {
    wanted=$1
    available_variants | grep -Fx -- "${wanted}" >/dev/null 2>&1
}

image_for_variant() {
    variant=$1
    if [ "${variant}" = "base" ]; then
        printf 'devcontainer-base\n'
        return 0
    fi

    printf 'devcontainer-%s\n' "${variant}"
}

sanitize_name() {
    printf '%s' "$1" | tr '[:upper:]' '[:lower:]' | tr -cs 'a-z0-9' '-'
}

dir_hash() {
    printf '%s\n' "${WORKDIR}" | cksum | awk '{print $1}'
}

container_name() {
    base=$(basename "${WORKDIR}")
    safe_base=$(sanitize_name "${base}")
    printf 'devco-%s-%s\n' "${safe_base}" "$(dir_hash)"
}

container_exists() {
    require_engine
    name=$(container_name)
    "${ENGINE}" container inspect "${name}" >/dev/null 2>&1
}

container_running() {
    require_engine
    name=$(container_name)
    state=$("${ENGINE}" inspect --format '{{.State.Running}}' "${name}" 2>/dev/null || true)
    [ "${state}" = "true" ]
}

require_container() {
    if ! container_exists; then
        printf 'No devcontainer exists for "%s".\n' "${WORKDIR}" >&2
        exit 1
    fi
}

require_running_container() {
    require_container
    if ! container_running; then
        printf 'Devcontainer exists for "%s" but is not running.\n' "${WORKDIR}" >&2
        exit 1
    fi
}

port_for() {
    require_engine
    name=$(container_name)
    port=$1
    "${ENGINE}" port "${name}" "${port}/tcp" 2>/dev/null | awk -F: 'NR==1 {print $NF}'
}

show_ports() {
    require_running_container
    nvim_port=$(port_for "${BASE_CONTAINER_PORT}")
    opencode_port=$(port_for "${OPENCODE_CONTAINER_PORT}")
    printf 'nvim:      %s\n' "${nvim_port:-not mapped}"
    printf 'opencode:  %s\n' "${opencode_port:-not mapped}"
    if [ -n "${opencode_port:-}" ]; then
        printf 'URL:       http://127.0.0.1:%s\n' "${opencode_port}"
    fi
}

start_container() {
    if [ "$1" != "base" ]; then
# Check if the Dockerfile exists for the requested variant
            if [ ! -f "${DEVCONTAINER_DIR}/Dockerfile-$1" ]; then
                # Check if the Makefile exists
                if [ -f "${DEVCONTAINER_DIR}/Makefile" ]; then
                    # Run the Makefile to build the Dockerfile
                    make -C "${DEVCONTAINER_DIR}" VARIANT=$1
                    
                    if [ $? -ne 0 ]; then
                        printf 'Failed to build Dockerfile for variant %s.\n' "$1" >&2
                        exit 1
                    fi
                else
                    printf 'Makefile not found in %s directory.\n' "${DEVCONTAINER_DIR}" >&2

                    printf 'To build this variant, create a Dockerfile-%s file in the %s directory.\n' "$1" "${DEVCONTAINER_DIR}"
                    exit 1
                fi
            fi

    
    # Rest of the start_container function

    variant=$1

    if ! variant_exists "${variant}" && [ "${variant}" != base ]; then
        printf 'Unknown image variant: %s\n' "${variant}" >&2
        printf 'Available variants:\n' >&2
        available_variants | sed 's/^/  - /' >&2
        exit 1
    fi

    image=$(image_for_variant "${variant}")
    name=$(container_name)

    if container_exists; then
        "${ENGINE}" rm -f "${name}" >/dev/null 2>&1 || true
    fi

    printf 'Starting devcontainer for "%s"\n' "${WORKDIR}"
    printf 'Image: %s\n' "${image}"
    printf 'Container: %s\n' "${name}"

    require_engine

    "${ENGINE}" run \
        --rm \
        --detach \
        --name "${name}" \
        --label devcontainer.managed=true \
        --label "devcontainer.dir=${WORKDIR}" \
        --label "devcontainer.variant=${variant}" \
        -p :${BASE_CONTAINER_PORT} \
        -p :${OPENCODE_CONTAINER_PORT} \
        -v "${HOMEDIR}/.local/share/opencode:/root/.local/share/opencode" \
        -v "${WORKDIR}:/workspace" \
        "${image}" >/dev/null

        printf 'Directory: %s\n' "${WORKDIR}"
        printf 'Container: %s\n' "${name}"
        show_ports
    fi

    # Rest of the start_container function



    # Rest of the start_container function

    variant=$1

        if ! variant_exists "${variant}" && [ "${variant}" != base ]; then



        exit 1
    fi

    image=$(image_for_variant "${variant}")
    name=$(container_name)

    if container_exists; then
        "${ENGINE}" rm -f "${name}" >/dev/null 2>&1 || true
    fi

    printf 'Starting devcontainer for "%s"\n' "${WORKDIR}"
    printf 'Image: %s\n' "${image}"
    printf 'Container: %s\n' "${name}"

    require_engine

    "${ENGINE}" run \
        --rm \
        --detach \
        --name "${name}" \
        --label devcontainer.managed=true \
        --label "devcontainer.dir=${WORKDIR}" \
        --label "devcontainer.variant=${variant}" \
        -p :${BASE_CONTAINER_PORT} \
        -p :${OPENCODE_CONTAINER_PORT} \
        -v "${HOMEDIR}/.local/share/opencode:/root/.local/share/opencode" \
        -v "${WORKDIR}:/workspace" \
        "${image}" >/dev/null

        printf 'Directory: %s\n' "${WORKDIR}"
        printf 'Container: %s\n' "${name}"
        show_ports
}

stop_container() {
    require_container
    name=$(container_name)
    printf 'Stopping %s\n' "${name}"
    "${ENGINE}" stop "${name}" >/dev/null
}

status_container() {
    if ! container_exists; then
        printf 'No devcontainer exists for "%s".\n' "${WORKDIR}"
        return 0
    fi

    name=$(container_name)
    running=false
    if container_running; then
        running=true
    fi

    variant=$("${ENGINE}" inspect --format '{{ index .Config.Labels "devcontainer.variant" }}' "${name}" 2>/dev/null || true)
    image=$("${ENGINE}" inspect --format '{{.Config.Image}}' "${name}" 2>/dev/null || true)

    printf 'Directory: %s\n' "${WORKDIR}"
    printf 'Container: %s\n' "${name}"
    printf 'Running:   %s\n' "${running}"
    printf 'Image:     %s\n' "${image}"
    printf 'Variant:   %s\n' "${variant}"

    if [ "${running}" = true ]; then
        show_ports
    fi
}

open_shell() {
    require_running_container
    "${ENGINE}" exec -it "$(container_name)" /bin/bash
}

open_nvim() {
    require_running_container
    "${ENGINE}" exec -it "$(container_name)" nvim "$@"
}

open_opencode() {
    require_running_container
    opencode_port=$(port_for "${OPENCODE_CONTAINER_PORT}")
    if [ -z "${opencode_port}" ]; then
        printf 'Could not determine the opencode port.\n' >&2
        exit 1
    fi

    url="http://127.0.0.1:${opencode_port}"
    printf '%s\n' "${url}"

    if command -v xdg-open >/dev/null 2>&1; then
        xdg-open "${url}" >/dev/null 2>&1 || true
    fi
}

list_images() {
    available_variants
}

COMMAND=${1:-start}
if [ $# -gt 0 ]; then
    shift
fi

IMAGE_VARIANT=${DEFAULT_VARIANT}

while [ $# -gt 0 ]; do
    case "$1" in
        -i|--image)
            if [ $# -lt 2 ] || [ "$2" = "" ]; then
                printf 'Missing value for %s\n' "$1" >&2
                exit 1
            fi
            IMAGE_VARIANT=$2
            shift 2
            ;;
        --help|-h)
            usage
            exit 0
            ;;
        --)
            shift
            break
            ;;
        *)
            break
            ;;
    esac
done

case "${COMMAND}" in
    start)
        start_container "${IMAGE_VARIANT}"
        ;;
    stop)
        stop_container
        ;;
    restart)
if container_running || [ "$1" != "base" ]; then
            stop_container
elif container_exists; then
                
    
            # Removing an exited container avoids a replace failure when --rm was not triggered.
            "${ENGINE}" rm "$(container_name)" >/dev/null 2>&1 || true
        fi
        start_container "${IMAGE_VARIANT}"
        ;;
    status)
        status_container
        ;;
    ports)
        show_ports
        ;;
    shell)
        open_shell
        ;;
    nvim)
        open_nvim "$@"
        ;;
    opencode)
        open_opencode
        ;;
    open)
        target=${1:-}
        shift || true
        case "${target}" in
            shell)
                open_shell
                ;;
            nvim)
                open_nvim "$@"
                ;;
            opencode)
                open_opencode
                ;;
            *)
                printf 'Unknown open target: %s\n' "${target}" >&2
                printf 'Supported targets: shell, nvim, opencode\n' >&2
                exit 1
                ;;
        esac
        ;;
    images)
        list_images
        ;;
    help)
        usage
        ;;
    *)
        printf 'Unknown command: %s\n' "${COMMAND}" >&2
        usage >&2
        exit 1
        ;;
esac
