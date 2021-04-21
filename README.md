# raspberry-pi

## Befehle

```bash
sudo shutdown -h now                        RPi stoppen
sudo reboot                                 RPi neu starten
sudo raspi-config                           RPi konfigurieren

sudo mount -o remount,ro /                  Filesystem auf Read-Only ändern
sudo mount -o remount,rw /                  Filesystem auf Writeable ändern
sudo sync                                   RAM-Puffer auf SD-Karte speichern
df                                          DiscFree je Mount-Point anzeigen
mount                                       Mounts anzeigen
```

## RaspiOS installieren

* Download & Unzip raspios-buster-armhf-lite.zip
* Download & Start balenaEtcher-Portable.exe
* Etcher: flash from ... 2021-03-04-raspios-buster-armhf-lite.img
* Etcher: select target ... F: (SD-Karte 8GB .. 32GB)
* Etcher: flash button
* Kopieren: ssh (leer), wpa_supplicant.conf nach F:\

*wpa_supplicant.conf*

```
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=DE

network={
  ssid="WLAN-Name"
  psk="WLAN-Passwort"
  key_mgmt=WPA-PSK
  scan_ssid=1
}
```

In wpa_supplicant.conf werden die Zugangsdaten für das WiFi-Netzwerk hinterlegt.
Die leere Datei ssh startet den SSH-Dienst für den Login mit Putty.

**Login SSH**

* Download Putty.exe
* Putty: Host Name = raspberrypi (oder IP-Adresse 192.168.0.xxx)
* Putty: Connection Type = SSH
* Putty: Button Open
* Putty: login as = pi
* Putty: pi@raspberrypi's password: raspberry

## Beispiele

*df*

```
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/root       29764176 1180124  27342096   5% /
devtmpfs          187228       0    187228   0% /dev
tmpfs             220204       0    220204   0% /dev/shm
tmpfs             220204    3112    217092   2% /run
tmpfs               5120       0      5120   0% /run/lock
tmpfs             220204       0    220204   0% /sys/fs/cgroup
tmpfs             220204       0    220204   0% /var/tmp
tmpfs             220204      16    220188   1% /tmp
tmpfs             220204       8    220196   1% /var/log
/dev/mmcblk0p1    258095   48787    209309  19% /boot
tmpfs              44040       0     44040   0% /run/user/1000
```

*mount*

```
/dev/mmcblk0p2 on / type ext4 (ro,noatime)
devtmpfs on /dev type devtmpfs (rw,relatime,size=187228k,nr_inodes=46807,mode=755)
sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,relatime)
proc on /proc type proc (rw,relatime)
securityfs on /sys/kernel/security type securityfs (rw,nosuid,nodev,noexec,relatime)
tmpfs on /dev/shm type tmpfs (rw,nosuid,nodev)
devpts on /dev/pts type devpts (rw,nosuid,noexec,relatime,gid=5,mode=620,ptmxmode=000)
tmpfs on /run type tmpfs (rw,nosuid,nodev,mode=755)
tmpfs on /run/lock type tmpfs (rw,nosuid,nodev,noexec,relatime,size=5120k)
tmpfs on /sys/fs/cgroup type tmpfs (ro,nosuid,nodev,noexec,mode=755)
cgroup2 on /sys/fs/cgroup/unified type cgroup2 (rw,nosuid,nodev,noexec,relatime,nsdelegate)
cgroup on /sys/fs/cgroup/systemd type cgroup (rw,nosuid,nodev,noexec,relatime,xattr,name=systemd)
none on /sys/fs/bpf type bpf (rw,nosuid,nodev,noexec,relatime,mode=700)
cgroup on /sys/fs/cgroup/devices type cgroup (rw,nosuid,nodev,noexec,relatime,devices)
cgroup on /sys/fs/cgroup/blkio type cgroup (rw,nosuid,nodev,noexec,relatime,blkio)
cgroup on /sys/fs/cgroup/cpu,cpuacct type cgroup (rw,nosuid,nodev,noexec,relatime,cpu,cpuacct)
cgroup on /sys/fs/cgroup/net_cls,net_prio type cgroup (rw,nosuid,nodev,noexec,relatime,net_cls,net_prio)
cgroup on /sys/fs/cgroup/pids type cgroup (rw,nosuid,nodev,noexec,relatime,pids)
cgroup on /sys/fs/cgroup/freezer type cgroup (rw,nosuid,nodev,noexec,relatime,freezer)
cgroup on /sys/fs/cgroup/perf_event type cgroup (rw,nosuid,nodev,noexec,relatime,perf_event)
sunrpc on /run/rpc_pipefs type rpc_pipefs (rw,relatime)
mqueue on /dev/mqueue type mqueue (rw,relatime)
debugfs on /sys/kernel/debug type debugfs (rw,relatime)
systemd-1 on /proc/sys/fs/binfmt_misc type autofs (rw,relatime,fd=41,pgrp=1,timeout=0,minproto=5,maxproto=5,direct)
configfs on /sys/kernel/config type configfs (rw,relatime)
tmpfs on /var/tmp type tmpfs (rw,nosuid,nodev,relatime)
tmpfs on /tmp type tmpfs (rw,nosuid,nodev,relatime)
tmpfs on /var/log type tmpfs (rw,nosuid,nodev,relatime)
/dev/mmcblk0p1 on /boot type vfat (ro,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=ascii,shortname=mixed,errors=remount-ro)
tmpfs on /run/user/1000 type tmpfs (rw,nosuid,nodev,relatime,size=44040k,mode=700,uid=1000,gid=1000)
```
