all: zizwindow

zizwindow: zizwindow.c
	gcc -fPIC -g -c -Wall -O2 zizwindow.c
	gcc -shared -Wl,-soname,libzizwindow.so -o libzizwindow.so zizwindow.o

4install: zizwindow.c
	gcc -DFORINSTALL -fPIC -g -c -Wall -O2 zizwindow.c
	gcc -shared -Wl,-soname,libzizwindow.so -o libzizwindow.so zizwindow.o
