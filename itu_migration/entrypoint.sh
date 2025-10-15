#!/bin/sh
# entrypoint.sh (수정된 버전)

# 웹 루트 디렉토리(/var/www/html)의 소유권을 www-data 사용자와 그룹으로 변경합니다.
# 이 스크립트는 컨테이너가 시작될 때마다 실행되므로, 권한이 항상 올바르게 유지됩니다.
chown -R www-data:www-data /var/www/html

# 기존의 서비스 시작 명령어들
# PHP-FPM을 백그라운드에서 실행
php-fpm &

# Nginx를 포그라운드에서 실행
nginx -g "daemon off;"