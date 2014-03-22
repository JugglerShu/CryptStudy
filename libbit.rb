
# Helpers
class String
    # "616263".to_bin() -> "abc"
    def to_bin()
        return [self].pack('H*')
    end

    # "abc".to_hex() -> "616263"
    def to_hex
        ret = self.unpack('H*').join
    end

    def to_a
        return self.each_byte.to_a
    end

    def ^(obj)
        b1 = self.to_a
        b2 = obj.to_a
        min_size = [b1.length,b2.length].min
        b1 = b1[0..min_size-1]
        b2 = b2[0..min_size-1]
        return b1.zip(b2).map{|c1,c2| c1^c2}.pack('C*')
    end
    
    # "abc".xor("\x00\x00c") -> "ab\x00"
    def xor(obj)
        return self^obj
    end

    # "0001".xor_hex("1110") -> "1111"
    def xor_hex(obj)
        return (self.to_bin^(obj.to_bin)).to_hex()
    end

    # "A".to_binary() -> "010000001"
    # "AA".to_binary() -> "010000001010000001"
    def to_binary()
        return self.unpack('B*').join
    end
end

