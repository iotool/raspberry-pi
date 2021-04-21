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

top                                         Auslastung RAM, laufende Prozesse
vcgencmd measure_temp                       Temperatur Prozessor
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

## RaspiOS konfigurieren

```
sudo raspi-config
```

* 1 System Options
  * S1 Wireless LAN
  * S2 Audio
  * S3 Password
  * S4 Hostname
  * S5 Boot / Auto Login => B2 Console + Autologin
  * S6 Network at Boot
  * S7 Splash Screen
  * S8 Power LED
* 2 Display Options
  * D1 Resolution
  * D2 Underscan
  * D3 Pixel Doubling
  * D4 Screen Blanking
* 3 Interface Options
  * P1 Camera
  * P2 SSH
  * P3 VNC
  * P4 SPI
  * P5 I2C
  * P6 Serial Port
  * P7 1-Wire
  * P8 Remote GPIO
* 4 Performance Options
  * P1 Overclock
  * P2 GPU Memory => 16 MB
  * P3 Overlay File System => overlay_yes (nur virtuelle Änderungen)
  * P4 Fan
* 5 Localisation Options
  * L1 Locale
  * L2 Timezone
  * L3 Keyboard
  * L4 WLAN Country
* 6 Advanced Options
  * A1 Expand Filesystem
  * A2 GL Driver
  * A3 Compositor
  * A4 Network Interface Name
  * A5 Network Proxy Settings 

Overlay = YES bewirkt, dass alle Änderungen am Filesystem nur virtuell sind.
Nach jedem Restart vom Raspberry ist der ursprüngliche Inhalt wieder vorhanden
Nach ein paar Monaten wird die SD-Karte defekt, weil das OS dauernd Logs usw schreibt.
Alternativ kann dass Filesystem auf Read-Only geändert werden.

## Beispiele

*df -h*

```
Filesystem      Size  Used Avail Use% Mounted on
/dev/root        29G  1.2G   27G   5% /
devtmpfs        183M     0  183M   0% /dev
tmpfs           216M     0  216M   0% /dev/shm
tmpfs           216M  3.1M  213M   2% /run
tmpfs           5.0M     0  5.0M   0% /run/lock
tmpfs           216M     0  216M   0% /sys/fs/cgroup
tmpfs           216M     0  216M   0% /var/tmp
tmpfs           216M   16K  216M   1% /tmp
tmpfs           216M  8.0K  216M   1% /var/log
/dev/mmcblk0p1  253M   48M  205M  19% /boot
tmpfs            44M     0   44M   0% /run/user/1000
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
