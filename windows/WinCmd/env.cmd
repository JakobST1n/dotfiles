@echo off

TITLE Dette er en tulle-terminal

DOSKEY ls=dir
DOSKEY mv=move $*
DOSKEY cp=copy $*
DOSKEY rm=del $*
DOSKEY cdcode=cd %userprofile%\Documents\_code\
DOSKEY gvim=%userprofile%\Documents\_Programmer\ProgramFiler\Vim\vim80\gvim.exe $*
DOSKEY vim=%userprofile%\Documents\_Programmer\ProgramFiler\Vim\vim80\gvim.exe $*
DOSKEY cfgenv=%userprofile%\Documents\_Programmer\ProgramFiler\Vim\vim80\gvim.exe %userprofile%\Documents\_Programmer\ProgramFiler\CMD\env.cmd
DOSKEY openscad=%userprofile%\Documents\_Programmer\ProgramFiler\openscad\openscad.exe $* ^& %userprofile%\Documents\_Programmer\ProgramFiler\Vim\Vim80\gvim.exe $*

@echo on
