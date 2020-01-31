all: test-empty-bson test-handle-not-inited

test-empty-bson: test-empty-bson.c
	gcc -Idebian92/nocrypto/include/mongocrypt -Ldebian92/nocrypto/lib -otest-empty-bson test-empty-bson.c -lmongocrypt

test-handle-not-inited: test-handle-not-inited.c
	gcc -Idebian92/nocrypto/include/mongocrypt -Ldebian92/nocrypto/lib -otest-handle-not-inited test-handle-not-inited.c -lmongocrypt
