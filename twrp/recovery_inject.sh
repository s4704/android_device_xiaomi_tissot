#!/bin/bash
#
#
DEVICE_RECOVERY_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TARGET_RECOVERY_ROOT_OUT=$1


echo ""
echo "----------------------------------------------------------------"
echo "[#] Performing TWRP touch-ups and Tissot Manager build..."

echo "    [#] Injecting recovery bootstrap service..."
sed -i 's/service recovery \/sbin\/recovery/service recovery \/sbin\/recovery\.sh/' "$TARGET_RECOVERY_ROOT_OUT/init.recovery.service.rc"

echo "    [#] Rewinding datestamp to fix 'downgrade not allowed' errors..."
sed -i 's/ro\.build\.date\.utc=.*/ro\.build\.date\.utc=0/' "$TARGET_RECOVERY_ROOT_OUT/prop.default"

echo "    [#] Zipping Aroma resources (for Tissot Manager gui)..."
rm "$TARGET_RECOVERY_ROOT_OUT/tissot_manager/tissot_manager.zip" > /dev/null 2>&1
cd "$DEVICE_RECOVERY_PATH/tissot_manager_resources"
zip -rq -1 "$TARGET_RECOVERY_ROOT_OUT/tissot_manager/tissot_manager.zip" *
cd "$DEVICE_RECOVERY_PATH"

echo "[i] All done!"
echo "----------------------------------------------------------------"
echo ""