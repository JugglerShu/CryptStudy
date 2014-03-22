
class MyRandom
    @seed 
    @prev

    CONSTANT_A = 11035155245
    CONSTANT_B = 12345

    def initialize(seed)
        @seed =seed
        @prev =seed
    end

    def random
        @prev = (CONSTANT_A * @prev + CONSTANT_B) % (2**32)
        return @prev
    end
end


if __FILE__ == $0 
    rand = MyRandom.new(Time.now().to_i)
    1.upto(10){
        puts rand.random
    }
end