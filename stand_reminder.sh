#!/bin/bash

# Alternates between 25-minute sit and 10-minute stand periods.
# Uses macOS modal dialogs for visibility — no sound.

SIT_MINUTES=25
STAND_MINUTES=10

echo "Stand reminder started. Sit period: ${SIT_MINUTES} min, Stand period: ${STAND_MINUTES} min."
echo "Press Ctrl+C to stop."

while true; do
    echo "Sitting... next reminder in ${SIT_MINUTES} minutes ($(date -v +${SIT_MINUTES}M '+%H:%M'))."
    sleep $((SIT_MINUTES * 60))

    osascript -e "display dialog \"You've been sitting for ${SIT_MINUTES} minutes — time to stand up!\" buttons {\"OK\"} default button \"OK\" with title \"Stand Up\" with icon caution"

    echo "Standing... next reminder in ${STAND_MINUTES} minutes ($(date -v +${STAND_MINUTES}M '+%H:%M'))."
    sleep $((STAND_MINUTES * 60))

    osascript -e "display dialog \"${STAND_MINUTES} minutes of standing — you can sit down now.\" buttons {\"OK\"} default button \"OK\" with title \"Sit Down\""
done
