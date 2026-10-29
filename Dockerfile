# 공식 NGINX 이미지를 사용하고 실제 실습에서 확인한 digest를 고정한다.
FROM nginx:alpine@sha256:785835ea65db4bba6f021acc0f3be91b0fef76a53fe41f8588c6698d2aed0606
LABEL org.opencontainers.image.title="Codyssey development workstation"
LABEL org.opencontainers.image.source="https://github.com/pjmin19/dev-workstation-mission"
COPY site/ /usr/share/nginx/html/
EXPOSE 80
HEALTHCHECK --interval=10s --timeout=3s --start-period=5s --retries=3 CMD wget -q -O /dev/null http://127.0.0.1/ || exit 1
