# Dockerfile (수정된 버전)
# 베이스 이미지로 PHP 8.2-FPM Alpine 버전을 사용합니다.
FROM php:8.2-fpm-alpine

# Nginx, 그리고 PHP 확장 모듈 설치에 필요한 라이브러리들을 먼저 설치합니다.
RUN apk update && apk add --no-cache \
    nginx \
    # GD 라이브러리 의존성
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    # ZIP 라이브러리 의존성
    zlib-dev

# GD, mysqli, zip PHP 확장 모듈을 설치합니다.
# docker-php-ext-install 스크립트는 내부적으로 컴파일을 위해 build-base 같은 개발 도구를 필요로 합니다.
# --virtual .build-deps 옵션으로 임시 그룹을 만들어 설치 후 깔끔하게 삭제할 수 있습니다.
RUN apk add --no-cache --virtual .build-deps $PHPIZE_DEPS \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd mysqli zip \
    && apk del .build-deps

# Nginx 설정 파일 복사
COPY nginx.conf /etc/nginx/nginx.conf

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