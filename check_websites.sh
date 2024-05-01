#!/bin/bash

# Файл для запису логів
logfile="website_status.log"

# Очищення файлу логів перед виконанням
echo "" > $logfile

# Функція для перевірки доступності сайту
check_site() {
    url=$1
    response=$(curl -s -o /dev/null -w "%{http_code}" $url)
    if [ "$response" -eq 200 ]; then
        echo "$url is UP"
        echo "$url is UP" >> $logfile
    else
        echo "$url is DOWN"
        echo "$url is DOWN" >> $logfile
    fi
}

# Перевірка на наявність аргументів командного рядка
if [ $# -eq 0 ]; then
    # Використання значень за замовчуванням, якщо аргументи не надані
    sites=("https://google.com" "https://facebook.com" "https://twitter.com")
else
    # Використання аргументів командного рядка як список сайтів
    sites=("$@")
fi

# Цикл для перевірки кожного сайту зі списку
for site in "${sites[@]}"
do
    check_site $site
done

echo "Results have been logged to $logfile"
