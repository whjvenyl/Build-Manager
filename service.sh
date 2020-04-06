#!/system/bin/sh
# Do NOT assume where your module will be located.
# ALWAYS use $MODDIR if you need to know where this script
# and module is placed.
# This will make sure your module will still work
# if Magisk change its mount point in the future
MODDIR=${0%/*}

# This script will be executed in late_start service mode

iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination 1.1.1.1:53
iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination 1.0.0.1:53
iptables -t nat -I OUTPUT -p tcp --dport 53 -j DNAT --to-destination 1.1.1.1:53
iptables -t nat -I OUTPUT -p udp --dport 53 -j DNAT --to-destination 1.0.0.1:53

# Virtual memory tweaks / internet speed tweaks
stop perfd
echo '5' > /proc/sys/vm/swappiness
echo '0' > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
echo '80' > /proc/sys/vm/vfs_cache_pressure
echo '0' > /proc/sys/vm/extra_free_kbytes
echo '128' > /sys/block/mmcblk0/queue/read_ahead_kb
echo '128' > /sys/block/mmcblk1/queue/read_ahead_kb
echo '4096' > /proc/sys/vm/min_free_kbytes
echo '0' > /proc/sys/vm/oom_kill_allocating_task
echo "0" > /proc/sys/vm/panic_on_oom;
echo '5' > /proc/sys/vm/dirty_ratio
echo '20' > /proc/sys/vm/dirty_background_ratio
echo "0" > /proc/sys/net/ipv4/tcp_timestamps;
echo "0" > /proc/sys/vm/laptop_mode;
echo "1" > /proc/sys/net/ipv4/tcp_tw_reuse;
echo "1" > /proc/sys/net/ipv4/tcp_sack;
echo "1" > /proc/sys/net/ipv4/tcp_tw_recycle;
echo "1" > /proc/sys/net/ipv4/tcp_window_scaling;
echo "5" > /proc/sys/net/ipv4/tcp_keepalive_probes;
echo "30" > /proc/sys/net/ipv4/tcp_keepalive_intvl;
echo "30" > /proc/sys/net/ipv4/tcp_fin_timeout;
echo "404480" > /proc/sys/net/core/wmem_max;
echo "404480" > /proc/sys/net/core/rmem_max;
echo "256960" > /proc/sys/net/core/rmem_default;
echo "256960" > /proc/sys/net/core/wmem_default;
echo "4096,16384,404480" > /proc/sys/net/ipv4/tcp_wmem;
echo "4096,87380,404480" > /proc/sys/net/ipv4/tcp_rmem;
sleep 30
chmod 666 /sys/module/lowmemorykiller/parameters/minfree
chown root /sys/module/lowmemorykiller/parameters/minfree
echo '21816,29088,36360,43632,50904,65448' > /sys/module/lowmemorykiller/parameters/minfree
rm /data/system/perfd/default_values
start perfd