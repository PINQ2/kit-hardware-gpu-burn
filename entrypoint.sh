#!/bin/sh

# Create output directories in writable /tmp location
mkdir -p /tmp/outputs /tmp/logs
chmod 755 /tmp/outputs /tmp/logs


STRESS_ARGS=""
if [ -n "$GPU_INDEX" ] && [ "$GPU_INDEX" != 0 ]; then STRESS_ARGS="$STRESS_ARGS -n $GPU_INDEX"; fi
if [ -n "$TIME" ]; then STRESS_ARGS="$STRESS_ARGS $TIME"; fi

if [ -n "$STRESS_ARGS" ]; then
    echo "Starting gpu-burn stress with args: $STRESS_ARGS"
    ./gpu_burn -l $STRESS_ARGS
fi

exec "$@"
