#!/bin/bash
# Использование: ./parse_flagstat.sh path/to/flagstat.txt

FILE="$1"

# Найдём строку с "mapped ("
LINE=$(grep " mapped (" "$FILE")

# Пример строки:
# 123456 + 0 mapped (98.76% : N/A)

# Извлекаем процент
PERCENT=$(echo "$LINE" | grep -oP '\(\K[0-9.]+(?=%)')

# Выводим результат
echo "Mapped: $PERCENT%"

# Проверка качества
THRESHOLD=70
RESULT="NOT OK"

# Используем bc без [ ] или [[ ]] — сравнение через if + команду
if echo "$PERCENT > $THRESHOLD" | bc -l | grep -q 1; then
    RESULT="OK"
fi

echo "Result: $RESULT"
