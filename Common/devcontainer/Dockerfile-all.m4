m4_ifdef(`DEF_BASEIMAGE', `', `m4_define(DEF_BASEIMAGE)m4_dnl
FROM BASEIMAGE')

m4_include(`Dockerfile-python.m4')
m4_include(`Dockerfile-svelte.m4')
