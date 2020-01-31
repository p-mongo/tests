all: test-empty-bson test-handle-not-inited

test-empty-bson: test-empty-bson.c
	gcc -Idebian92/nocrypto/include/mongocrypt -Ldebian92/nocrypto/lib -lmongocrypt -otest-empty-bson test-empty-bson.c

test-handle-not-inited: test-handle-not-inited.c
	gcc -Idebian92/nocrypto/include/mongocrypt -Ldebian92/nocrypto/lib -lmongocrypt -otest-handle-not-inited test-handle-not-inited.c
