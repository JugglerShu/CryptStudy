#!/usr/bin/ruby

require './libbit.rb'

packet = [ "My name is Shuichiro Suzuki.",
           "My hobby is juggling and golf.",
           "I have been working as an engineer for 10 years.",
           "We are working on studying cryptography.",
           "AES and DES are block ciphers.",
           "Public key encryption can be accomplished by RSA.",
           "One time pad cannot be used twice.",
           "This shows how to decrypt one time pad."
         ];


def CreateKey(length)
    srand(1000)
    key=""
    1.upto(length).each{|n|
       key+= rand(256).chr
    }
    return key
end

puts CreateKey(10).to_hex
