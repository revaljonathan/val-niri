#!/bin/bash

profile=$(powerprofilesctl get)

case "$profile" in
    performance)
        echo "!! CRITICAL !!"
        ;;
    balanced)
        echo "STABLE"
        ;;
    power-saver)
        echo "|| FUEL EXHAUSTION ||"
        ;;
    *)
        echo "Unknown"
        ;;
esac
