from utils import *
import sys

# Получаем L массив ,состоящий из 'c' слов. с = b/u , где кол-во байт в слове вычисляется: u = w / 8 = 4 в случае w = 32.
def blockConverterIMPROVED(sentence: bytearray):
    encoded = []
    ll = len(sentence)
    encoded.append( int.from_bytes(sentence[:4], "big"))
    encoded.append(int.from_bytes(sentence[4:8], "big"))
    encoded.append(int.from_bytes(sentence[8:12], "big"))
    encoded.append(int.from_bytes(sentence[12:16], "big"))
    return encoded


def decrypt(esentence,s):
    encoded = blockConverterIMPROVED(esentence)
    A = encoded[0]
    B = encoded[1]
    C = encoded[2]
    D = encoded[3]
    r=12
    w=32
    modulo = 2**32
    lgw = 5
    C = (C - s[2*r+3])%modulo
    A = (A - s[2*r+2])%modulo
    for j in range(1,r+1):
        i = r+1-j
        (A, B, C, D) = (D, A, B, C)
        u_temp = (D*(2*D + 1))%modulo
        u = ROL(u_temp,lgw,32)
        t_temp = (B*(2*B + 1))%modulo 
        t = ROL(t_temp,lgw,32)
        tmod=t%32
        umod=u%32
        C = (ROR((C-s[2*i+1])%modulo,tmod,32)  ^u)  
        A = (ROR((A-s[2*i])%modulo,umod,32)   ^t) 
    D = (D - s[1])%modulo 
    B = (B - s[0])%modulo
    decodedByteText = []
    decodedByteText.append(A)
    decodedByteText.append(B)
    decodedByteText.append(C)
    decodedByteText.append(D)
    return decodedByteText


def decrypt_16bytes(sentence, s):
    decrypted = decrypt(sentence, s)
    tmp = bytearray()
    for i in range(len(decrypted)):
        b: bytes = decrypted[i].to_bytes(4, "big")
        c = bin(decrypted[i])
        a = len(b)
        for j in b:
            if j:
                tmp += j.to_bytes(1, "big")

    return tmp

def main():
    with open("key.txt") as f:
        key = f.read()
    if len(key) <16:
        key = key + " "*(16-len(key))
    key = key[:16]
    s = generateKeyForW32(key)
    with open("encrypted.txt","rb") as f:
        esentence = f.read()

    result = bytearray()

    while(len(esentence)):
        next_16bytes = esentence[:16]
        result += decrypt_16bytes(next_16bytes, s)
        esentence = esentence[16:]

    with open("decrypted.txt", "wb") as f:
        f.write(result)

if __name__ == "__main__":
    main()
