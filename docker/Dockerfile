# Dockerfile (DB 모듈 추가 버전)
# 베이스 이미지로 PHP 8.2-FPM Alpine 버전을 사용합니다.
FROM php:8.2-fpm-alpine

# Nginx 및 PHP 확장 모듈이 런타임에 필요로 하는 시스템 라이브러리들을 먼저 설치합니다.
RUN apk update && apk add --no-cache \
    nginx \
    freetype \
    libjpeg-turbo \
    libpng \
    libzip \
    zlib

# GD, mysqli, pdo_mysql, zip PHP 확장 모듈을 설치합니다.
# --virtual .build-deps 로 임시 그룹을 만들어 컴파일에 필요한 개발 도구와 -dev 패키지를 설치 후 깔끔하게 삭제합니다.
RUN apk add --no-cache --virtual .build-deps $PHPIZE_DEPS \
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    libzip-dev \
    zlib-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd mysqli pdo_mysql zip \
    && apk del .build-deps

# Nginx 설정 파일 복사
COPY nginx.conf /etc/nginx/nginx.conf
COPY xe.conf /etc/nginx/conf.d/xe.conf

# 웹 루트 디렉토리 생성 및 권한 설정
RUN mkdir -p /var/www/html && \
    chown -R www-data:www-data /var/www/html

# 컨테이너의 작업 디렉토리 설정
WORKDIR /var/www/html

# 컨테이너 시작 시 실행될 스크립트 복사 및 실행 권한 부여
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Nginx가 사용할 80번 포트 개방
EXPOSE 80

# 컨테이너 시작 명령어
CMD ["/entrypoint.sh"]