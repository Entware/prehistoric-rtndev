# Husky software suite has no Makefile for all bundle, so lets make it.

HUSKY_PACKAGES:=huskylib smapi fidoconf areafix hpt hptkill hptsqfix hpucode htick nltools sqpack bsopack areastat hptutil

all:
	@for dir in $(HUSKY_PACKAGES); do ( \
	    echo ===Compiling $$dir===; \
	    make -C "./$$dir" install; \
	); done
	@echo ===Done!===
	touch $@