require 'lbbit.rb'


# MAIN

ct_bin = ct.map{|ct| ct.to_bin }

# Get each chipertext length
ct_bin.each_with_index{|text,idx|
    puts "ct_bin[#{idx}].length = #{text.length}"
}


## As I decoded ciphertexts add extra characters to letters
numbers = ('0'..'9').to_a
alpha = ('a'..'z').to_a + ('A'..'Z').to_a
mark = [' ', ',', '.'] #, '!', '?', ';', ':', '(', ')', '+', '-']
letters = alpha + mark # + numbers


# THIS SECTION IS WRITTEN BY MANUALLY AS I FIND KEYS WITH THE FOLLOWING CODE
# If the value in the fixed_key is 'nil' the folloing code tries to presume the key
# at the index so that all the decoded characters at the index appear in letters
# This is the key extracted from the following code
=begin
fixed_key = [102,  57, 110, 137, 201, 219, 216, 204, 152, 116, #0
               53,  42, 205,  99, 149,  16,  46, 175, 206, 120, #10
              170, 127, 237,  40, 160, 127, 107, 201, 141,  41, #20
              197,  11, 105, 176,  51, 154,  25, 248, 170,  64, #30
               26, 156, 109, 112, 143, 128, 192, 102, 199,  99, #40
              254, 240,  18,  49,  72, 205, 216, 232,   2, 208, #50
               91, 169, 135, 119,  51,  93, 174, 252, 236, 213, #60
              156,  67,  58, 107,  38, 139,  96, 191,  78, 240, #70
               60, 154,  97,  16, 152, 187,  62, 154,  49,  97, #80
              ]
=end

# First start from any key is unknown
fixed_key = [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, #0
              nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, #10
              nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, #20
              nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, #30
              nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, #40
              nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, #50
              nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, #60
              nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, #70
              nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, #80
              ]

#Since the target text length is 83 presuming first 90 characters of key is enough
MAX_INDEX = fixed_key.length-1


# 45 combinations of cihpertexts
idxs = (0..9).to_a
comb = idxs.combination(2)

presumed_keys = [] # This holds key candidate for each index. This is array of array

0.upto(MAX_INDEX){|idx|
    next if fixed_key[idx] != nil # skip already fixed index

    # Now presume key[idx]

    key_candidates= []
    comb.each{|a,b|
        # Find all possible pair and key candidates
        keys = []

        #puts "Key candidates for CT#{a} and CT#{b} at index:#{idx}"

        letters.each{|m|
            chr1 = ct_bin[a][idx]
            chr2 = ct_bin[b][idx]
            # Assume that decrypted chr1 is character m
            key = chr1.ord ^ m.ord  # Assumed key
            # If the assumed key generates valid letter for chr2
            # the key is good candidate for this idx
            if letters.include?((chr2.ord ^ key).chr)
                #    puts "#{(chr1.ord^key).chr}^#{(chr2.ord^key).chr} = #{"%08b"%(chr1.ord^chr2.ord)}   (Key:#{"%02X"%key})"
                keys.push(key)
            end
        }

        # keys have all the good key candidate at the idx
        key_candidates.push(keys.dup)
    }

    # key_candidates have the array of key candidates for each pair
    # Take intercect to obtain a key suitable for all the pairs
    intercects = key_candidates[0]
    key_candidates.each{|k|
        intercects = intercects & k
    }
    print "Key candidtes at index #{idx} = "
    puts intercects.join(',')
    presumed_keys[idx] = intercects.dup
}

puts "#### Print all the possible characters ####"

# Now we have key candidates for any index
# So print out possible letters for each index for all the decoded ciphertext
ct_bin.each_with_index{|ct,no|
    puts "Presumed text for CT[#{no}]"
    0.upto(MAX_INDEX){|idx|
       print "%02d:" % idx
       if fixed_key[idx] != nil
           # This idx is already fixed. Do not print the candidates
           print (ct[idx].ord ^ fixed_key[idx]).chr
       else 
           # Print the candidate at this idx.
           presumed_keys[idx].each{|key|
               print (ct[idx].ord ^ key).chr
               print " "
           }
           print "    #{ct[idx].ord}^" + "(" + presumed_keys[idx].join(',') + ")"
       end

       print "\n"
    }
    puts
}

### Now the code above print out all the candidate letters for each index for all the cipertexts
### Pick up suitable letter by gussing English words and write fixed key value into fixed_key manually
### And repeat the presumption

puts

#decrypt the target with the key when fixed_key is completely fixed
if fixed_key.include?(nil) != true
    puts "#### DECRYPTED TARGET TEXT ####"
    decrypted = (target.to_bin^fixed_key.pack('C*'))
    puts decrypted
end
