1) Выведите содержимое fstab. Что хранится в fstab?

Файл /etc/fstab описывает постоянные точки монтирования: что монтировать (UUID/устройство) и куда.

```
cat /etc/fstab
```

![](./screen-01.png)

2) Добавьте в виртуальную машину ещё один диск

![](./screen-02.png)

3) Узнайте, как система видит ваш диск - выведите информацию о блочных устройствах

![](./screen-03.png)

Добавленный диск - /dev/vdb

4) Создайте на диске таблицу разделов и файловую систему ext4

```
parted -s /dev/vdb mklabel gpt
parted -s mkpart primary ext4 100MiB 100%

partprobe /dev/vdb

mkfs.ext4 -L DATA /dev/vdb

lsblk -f /dev/vdb /dev/vdb1
```

![](./screen-04.png)

5) Примонтируйте диск в каталог /mnt

```
mkdir -p /mnt
mount /dev/vdb /mnt

findmnt /mnt
```

![](./screen-05.png)

6) Зайдите в каталог и создайте там файлы

![](./screen-06.png)

7) Отмонтируйте диск и проверьте, остались ли файлы

```
umount /mnt

ls -la /mnt

mount /dev/vdb /mnt
ls -lh /mnt
```

![](./screen-07.png)

8) Настройте автоподключение при загрузке

```
UUID=$(blkid -s UUID -o value /dev/vdb)
echo "UUID=$UUID /mnt ext4 defaults,nofail 0 2" | tee -a /etc/fstab
```

![](./screen-08.png)

9) Проверьте корректность записей fstab перед перезагрузкой

```
umount /mnt 2>/dev/null
mount -av
findmnt /mnt
```

![](./screen-09.png)

10) Перезагрузите систему и убедитесь, что диск подключён

```
reboot
findmnt /mnt
```

![](./screen-10.png)