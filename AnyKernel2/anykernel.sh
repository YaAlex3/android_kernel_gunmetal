# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() {
kernel.string=GunMetal by YaAlex @ xda-developers
do.devicecheck=0
do.modules=0
do.cleanup=1
do.cleanuponabort=0
device.name1=Z010D
device.name2=Z010DD
device.name3=
device.name4=
device.name5=
} # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;

## AnyKernel install
dump_boot;

# Ramdisk changes

# insert init.spectrum.rc in init.rc
insert_line init.rc "import /init.spectrum.rc" after "import /init.usb.configfs.rc" "import /init.spectrum.rc";

if [ -f /sys/devices/soc0/soc_id ]; then
    soc_id=`cat /sys/devices/soc0/soc_id`
else
    soc_id=`cat /sys/devices/system/soc/soc0/id`
fi

case "$soc_id" in
    "206" | "247" | "248" | "249" | "250")
		# Apply MSM8916 specific spectrum profiles
		# insert init.spectrum.rc in init.rc
		rm /tmp/anykernel/ramdisk/init.spectrum.8939.rc
		mv /tmp/anykernel/ramdisk/init.spectrum.8916.rc /tmp/anykernel/ramdisk/init.spectrum.rc
	;;
    "239" | "241" | "263" | "268" | "269" | "270" | "271")
		# Apply MSM8939 specific spectrum support.
		# insert init.spectrum.rc in init.rc
		rm /tmp/anykernel/ramdisk/init.spectrum.8916.rc
		mv /tmp/anykernel/ramdisk/init.spectrum.8939.rc /tmp/anykernel/ramdisk/init.spectrum.rc
	;;
esac

write_boot;

## end install

