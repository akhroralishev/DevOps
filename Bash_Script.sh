#Oddiy bash Script
#!/bin/bash
echo "Salom, DevOps dunyosi!"

#Server yuklanmasini tekshirish, Agar server yuklanmasi 1,5dan oshsa ogohlantrrish beradi,
#!/bin/bash

CPU_LOAD=$(uptime | awk -F 'load average:' '{print $2}' | cut -d, -f1)

if (( $(echo "$CPU_LOAD > 1.5" | bc -l) )); then
  echo "CPU yuklamasi yuqori: $CPU_LOAD"
else
  echo "CPU normal holatda: $CPU_LOAD"
fi


#Disk bo`sh joyini tekshiradi, foydali tarafi bor chunki disk to`lib ketishini oldindan ogohlantiradi
##!/bin/bash

THRESHOLD=80
USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

if [ "$USAGE" -gt "$THRESHOLD" ]; then
  echo " Diskda bo‘sh joy kamaydi: $USAGE% band!"
else
  echo "Disk yetarli darajada bo‘sh: $USAGE% band."
fi


#Avtomatik Backup qiladi,Foydali tarafi bor chunki  har kuni serverdagi web-fayllarni zaxiralash uchun ishlatiladi.
#!/bin/bash

BACKUP_DIR="/backup"
SRC_DIR="/var/www/html"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
TAR_FILE="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"

mkdir -p $BACKUP_DIR
tar -czf $TAR_FILE $SRC_DIR

echo "Backup yaratildi: $TAR_FILE"


#Apache yoki Ngnix ishlayotganini tekshiradi, foydali tarafi agarda Apache ishdan chiqsa avtomatik qayta ishga tushirishi munkin, 
#!/bin/bash

if systemctl is-active --quiet apache2; then
  echo "Apache ishlayapti."
else
  echo "Apache ishlamayapti! Xizmatni qayta ishga tushirish:"
  systemctl restart apache2
fi


#Foydalanuvchi loginlarini log qiladi, kim qachon tizimga kirganini log qilib saqlaydi, 
#!/bin/bash

LOG_FILE="/var/log/user_logins.log"
LAST_LOGIN=$(last -n 1 | head -n 1)

echo "$(date): $LAST_LOGIN" >> $LOG_FILE
echo " Login yozildi: $LOG_FILE"



