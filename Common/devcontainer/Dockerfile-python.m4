m4_ifdef(`DEF_BASEIMAGE', `', `m4_define(DEF_BASEIMAGE)m4_dnl
FROM BASEIMAGE')


RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip && \
    rm -rf /var/lib/api/lists/*

RUN nvim --headless "+MasonInstallSync pywright" "+q!"

