# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=GunMetal by YaAlex @ xda-developers
do.devicecheck=1
do.modules=0
do.cleanup=1
do.cleanuponabort=1
device.name1=Z010D
device.name2=Z010DD
device.name3=
device.name4=
device.name5=
supported.versions=6.0-9.0
'; } # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
chmod -R 750 $ramdisk/*;
chown -R root:root $ramdisk/*;


## AnyKernel install
dump_boot;

# begin ramdisk changes

# insert init.spectrum.rc in init.rc
insert_line init.rc "import /init.gunmetal.rc" after "import /init.usb.configfs.rc" "import /init.gunmetal.rc";

if [ -f /sys/devices/soc0/soc_id ]; then
    soc_id=`cat /sys/devices/soc0/soc_id`
else
    soc_id=`cat /sys/devices/system/soc/soc0/id`
fi

case "$soc_id" in
    "206" | "247" | "248" | "249" | "250")
		# Apply MSM8916 specific gunmetal profiles
		# insert init.gunmetal.rc in init.rc
		rm /tmp/anykernel/ramdisk/init.gunmetal.8939.rc
		mv /tmp/anykernel/ramdisk/init.gunmetal.8916.rc /tmp/anykernel/ramdisk/init.gunmetal.rc
	;;
    "239" | "241" | "263" | "268" | "269" | "270" | "271")
		# Apply MSM8939 specific gunmetal support.
		# insert init.gunmetal.rc in init.rc
		rm /tmp/anykernel/ramdisk/init.gunmetal.8916.rc
		mv /tmp/anykernel/ramdisk/init.gunmetal.8939.rc /tmp/anykernel/ramdisk/init.gunmetal.rc
	;;
esac
write_boot;
## end install

