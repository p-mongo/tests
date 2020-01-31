#include "mongocrypt.h"

int main() {
  mongocrypt_binary_t *bin_p;
  mongocrypt_t *handle_p;
  mongocrypt_ctx_t *ctx_p;
  
  bin_p = mongocrypt_binary_new_from_data("", 0);
  handle_p = mongocrypt_new();
  mongocrypt_init(handle_p);
  ctx_p = mongocrypt_ctx_new(handle_p);
  mongocrypt_ctx_decrypt_init(ctx_p, bin_p);
}
