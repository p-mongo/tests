all: bin/test-empty-bson bin/test-handle-not-inited

bin/test-empty-bson: src/test-empty-bson.c
	mkdir -p bin
	gcc -Ilmc/include -Llmc/lib -obin/test-empty-bson src/test-empty-bson.c -lmongocrypt

bin/test-handle-not-inited: src/test-handle-not-inited.c
	mkdir -p bin
	gcc -Ilmc/include -Llmc/lib -obin/test-handle-not-inited src/test-handle-not-inited.c -lmongocrypt
