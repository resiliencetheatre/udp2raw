# buildroot makefile
FLAGS= -std=c++11   -Wall -Wextra -Wno-unused-variable -Wno-unused-parameter -Wno-missing-field-initializers ${OPT}
COMMON=main.cpp lib/md5.cpp lib/pbkdf2-sha1.cpp lib/pbkdf2-sha256.cpp encrypt.cpp log.cpp network.cpp common.cpp  connection.cpp misc.cpp fd_manager.cpp client.cpp server.cpp -lpthread
SOURCES0= $(COMMON) lib/aes_faster_c/aes.cpp lib/aes_faster_c/wrapper.cpp
SOURCES= ${SOURCES0} my_ev.cpp -isystem libev
SOURCES_AES_ACC= $(COMMON) $(wildcard lib/aes_acc/aes*.c) my_ev.cpp -isystem libev
PCAP="-lpcap"
MP="-DUDP2RAW_MP"
NAME=udp2raw

all:git_version
	rm -f ${NAME}
	$(CXX) -o ${NAME} -I. ${SOURCES} ${FLAGS} -lrt -ggdb  -O2
	
clean:
	rm -f ${NAME}
	rm -f git_version.h

git_version:
	    echo "const char *gitversion = \"$(shell git rev-parse HEAD)\";" > git_version.h
