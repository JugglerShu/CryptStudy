
class RSA
    @p
    @q

    @e
    @d
    # p,qは素数をセット
    # http://www.usamimi.info/~geko/arch_acade/elf009_prime/list100.html
    def initialize(p,q)

    end

    def phi
        return (@p-1)*(@q-1)
    end

    def encrypt(n)
        # gcdメソッドを用いてnがinvertableか確認
        
        # 適当なeを選んで、dを計算

        # nを暗号化
    end

    def decrypt(n)
        # dを用いて複合

    end
end