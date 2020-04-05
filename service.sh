# Virtual memory tweaks
stop perfd
echo '5' > /proc/sys/vm/swappiness
echo '0' > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
echo '80' > /proc/sys/vm/vfs_cache_pressure
echo '0' > /proc/sys/vm/extra_free_kbytes
echo '128' > /sys/block/mmcblk0/queue/read_ahead_kb
echo '128' > /sys/block/mmcblk1/queue/read_ahead_kb
echo '4096' > /proc/sys/vm/min_free_kbytes
echo '0' > /proc/sys/vm/oom_kill_allocating_task
echo '5' > /proc/sys/vm/dirty_ratio
echo '20' > /proc/sys/vm/dirty_background_ratio
sleep 30
chmod 666 /sys/module/lowmemorykiller/parameters/minfree
chown root /sys/module/lowmemorykiller/parameters/minfree
echo '21816,29088,36360,43632,50904,65448' > /sys/module/lowmemorykiller/parameters/minfree
rm /data/system/perfd/default_values
start perfd
