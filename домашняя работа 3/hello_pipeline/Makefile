# Makefile — Hello World pipeline

all: hello.txt

hello.txt: data.txt
	echo "Hello, world!" > hello.txt
	echo "Data from:" >> hello.txt
	cat data.txt >> hello.txt

clean:
	rm -f hello.txt
