
require './libbit.rb'
require 'openssl'


## ECBモードにして同じブロックが同じ内容に暗号化されることを確かめる
key = "\x00\x11\x22\x33\x44\x55\x66\x77\x88\x99\xAA\xBB\xCC\xDD\xEE\xFF"

cipher = OpenSSL::Cipher::AES.new(128, :CBC)
cipher.encrypt
cipher.key = key

encrypted = cipher.update("Some message to encrypt. Write here your secrets") + cipher.final

puts encrypted.to_hex



decryptor = OpenSSL::Cipher::AES.new(128, :CBC)
decryptor.decrypt
decryptor.key = key

decrypted = decryptor.update(encrypted) + decryptor.final


puts decrypted