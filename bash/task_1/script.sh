#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

echo "=== Старт скрипта «Работа с файлами» ==="
workdir="$HOME/cli_lab"
mkdir -p "$workdir"

echo "1) Перемещаемся между директориями: ~ => /tmp => ~"
cd "$HOME"; pwd
cd /tmp;   pwd
cd "$HOME"; pwd
echo

echo "2) Список файлов (без скрытых) в домашней директории:"
ls -l "$HOME" | sed -n '1,30p' || true
echo

echo "3) Все файлы (включая скрытые) в текущей директории (~):"
ls -la "$HOME" | sed -n '1,30p' || true
echo "   Рекурсивно покажем только имена файлов в ~ (первые 20):"
find "$HOME" -type f 2>/dev/null | sed -n '1,20p' || true
echo

echo "4) Создаём папку с подпапками: $workdir/{input,output,tmp}"
mkdir -p "$workdir"/{input,output,tmp}
ls -R "$workdir" | sed -n '1,50p' || true
echo

echo "5) Внутри input создаём файл и записываем в него строки:"
cat > "$workdir/input/data.txt" << 'EOT'
pear
Apple
banana
apple
cherry
EOT
echo "   Содержимое файла:"
cat "$workdir/input/data.txt"
echo

echo "6) Перемещаем файл из input в tmp:"
mv "$workdir/input/data.txt" "$workdir/tmp/"
ls -l "$workdir/input" || true
ls -l "$workdir/tmp"
echo

echo "7) Копируем файл из tmp в output под новым именем:"
cp "$workdir/tmp/data.txt" "$workdir/output/data_copy.txt"
ls -l "$workdir/output"
echo

echo "8) Переименовываем скопированный файл в report.txt:"
mv "$workdir/output/data_copy.txt" "$workdir/output/report.txt"
ls -l "$workdir/output"
echo

echo "9) Сравниваем содержимое tmp/data.txt и output/report.txt:"
echo "   (Ожидаемо идентичны — diff без вывода)"
diff -u "$workdir/tmp/data.txt" "$workdir/output/report.txt" || true
echo "   Добавим строку 'strawberry' в report.txt и сравним снова:"
echo "strawberry" >> "$workdir/output/report.txt"
diff -u "$workdir/tmp/data.txt" "$workdir/output/report.txt" || true
echo

echo "10) Сортируем содержимое tmp/data.txt по возрастанию и убыванию:"
LC_ALL=C sort  "$workdir/tmp/data.txt" | tee "$workdir/tmp/sorted_asc.txt" >/dev/null
LC_ALL=C sort -r "$workdir/tmp/data.txt" | tee "$workdir/tmp/sorted_desc.txt" >/dev/null
echo "   Отсортировано (asc):"
cat "$workdir/tmp/sorted_asc.txt"
echo "   Отсортировано (desc):"
cat "$workdir/tmp/sorted_desc.txt"
echo

echo "11) Удаляем все созданные папки и файлы:"
rm -rf "$workdir"
if [ ! -e "$workdir" ]; then
  echo "   $workdir удалён"
else
  echo "   ВНИМАНИЕ: $workdir не удалён" >&2
  exit 1
fi

echo "=== Готово ==="
