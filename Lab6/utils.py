r = 12 # Кол-во раундов
w = 32 # Размер регистров в бит
P32 = 0xb7e15163 # <- Odd((e-2)*2**w), e = 2.71828 (экспонента)
Q32 = 0x9e3779b9 # <- Odd((f-1)*2**w) f = 1.61803 (золотое сечение)


# циклическое перемещение n байт числа x вправо
def ROR(x, n, bits = 32):
    mask = (2**n) - 1
    mask_bits = x & mask
    return (x >> n) | (mask_bits << (bits - n))

# циклическое перемещение n байт числа x влево
def ROL(x, n, bits = 32):
    return ROR(x, bits - n,bits)

def generateKeyForW32(inputKey):
    modulo = 2 ** 32
    b = len(inputKey)
    s = [0] * (2*r+4)
    s[0] = P32

    for i in range(1, 2*r+4):
        s[i] = s[i-1] + Q32 % modulo

    L = [ int(x, 2) for x in blockConverter(inputKey)]
    L.reverse()
    c = len(L)

    v = 3 * max(c, 2 * r + 4)
    A = B = i = j = 0

    for index in range(0, v):
        A = s[i] = ROL((s[i] + A + B) % modulo, 3)
        B = L[j] = ROL((L[j] + A + B) % modulo, (A + B) % 32, 32)
        i = (i + 1) % (2 * r + 4)
        j = (j + 1) % c
    return s




# Получаем L массив ,состоящий из 'c' слов. с = b/u , где кол-во байт в слове вычисляется: u = w / 8 = 4 в случае w = 32.
def blockConverter(sentence):
    encoded = []
    res = ""
    for i in range(0,len(sentence)):
        if i%4==0 and i!=0 :
            encoded.append(res)
            res = ""
        temp = bin(ord(sentence[i]))[2:]
        if len(temp) <8:
            temp = "0"*(8-len(temp)) + temp
        res = res + temp
    encoded.append(res)
    return encoded


#Из int представления в bite
def deBlocker(blocks):
    s = ""
    for ele in blocks:
        temp =bin(ele)[2:]
        if len(temp) <32:
            temp = "0"*(32-len(temp)) + temp
        for i in range(0,4):
            s=s+chr(int(temp[i*8:(i+1)*8],2))
    return s