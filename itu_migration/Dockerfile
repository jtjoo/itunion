    # Dockerfile (기존 XE 마이그레이션용)
    # 베이스 이미지로 PHP 7.4-FPM Alpine 버전을 사용합니다.
    FROM php:7.4-fpm-alpine

    # Nginx 및 PHP 확장 모듈 설치에 필요한 의존성 패키지들을 설치합니다.
    RUN apk update && apk add --no-cache \
        nginx \
        freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        libzip-dev \
        zlib-dev

    # GD, mysqli, pdo_mysql, zip PHP 확장 모듈을 설치합니다.
    RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
        && docker-php-ext-install -j$(nproc) gd mysqli pdo_mysql zip

    # Nginx 설정 파일 복사
    COPY nginx.conf /etc/nginx/nginx.conf

    # 웹 루트 디렉토리 생성 및 권한 설정
    RUN mkdir -p /var/www/html && \
        chown -R www-data:www-data /var/www/html

    WORKDIR /var/www/html

    # 컨테이너 시작 시 실행될 스크립트 복사 및 실행 권한 부여
    COPY entrypoint.sh /entrypoint.sh
    RUN chmod +x /entrypoint.sh

    EXPOSE 80
    CMD ["/entrypoint.sh"]
    


