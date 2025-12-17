1) Что такое systemd-юнит?

Юнит — это объект systemd: описание служб: например, таймера, точки монтирования и прочее. Хранится в .service, .timer, .mount, .socket, .target, .path, .slice, .swap, .device, .scope.

2) Проверить статус любого systemd-юнита. Что выводит команда?

```
systemctl list-unit-files --type=service
```

![](./screen-01.png)

3) Попробуйте остановить сервис

```
sudo systemctl stop bluetooth.service
systemctl is-active bluetooth.service
```

![](./screen-02.png)

4) Перезапустите его

```
sudo systemctl restart bluetooth.service
systemctl is-active bluetooth.service
```

![](./screen-03.png)

5) Удалите из автозагрузки

```
sudo systemctl disable cups.service
```

![](./screen-04.png)

6) Верните обратно

```
sudo systemctl enable cups.service
```

![](./screen-05.png)

7) Что такое таймеры?

Это планировщики systemd, запускают .service по расписанию. Может запускать по событию (OnBootSec, OnUnitActiveSec, OnUnitInactiveSec, т.д.), может запускать по календарю (OnCalendar=daily или Mon...Fri 09:00)

