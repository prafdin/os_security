from utils import *

def blockConverterIMPROVED(sentence: bytearray):
    encoded = []
    ll = len(sentence)
    encoded.append( int.from_bytes(sentence[:4], "big"))
    encoded.append(int.from_bytes(sentence[4:8], "big"))
    encoded.append(int.from_bytes(sentence[8:12], "big"))
    encoded.append(int.from_bytes(sentence[12:16], "big"))
    return encoded

def encrypt(sentence, s):
    encoded = blockConverterIMPROVED(sentence)
    A = encoded[0]
    B = encoded[1]
    C = encoded[2]
    D = encoded[3]
    r=12
    w=32
    modulo = 2**32
    lgw = 5
    B = (B + s[0])%modulo
    D = (D + s[1])%modulo 
    for i in range(1,r+1):
        t_temp = (B*(2*B + 1))%modulo 
        t = ROL(t_temp,lgw,32)
        u_temp = (D*(2*D + 1))%modulo
        u = ROL(u_temp,lgw,32)
        tmod=t%32
        umod=u%32
        A = (ROL(A^t,umod,32) + s[2*i])%modulo 
        C = (ROL(C^u,tmod,32) + s[2*i+ 1])%modulo
        (A, B, C, D)  =  (B, C, D, A)
    A = (A + s[2*r + 2])%modulo 
    C = (C + s[2*r + 3])%modulo
    cipher = []
    cipher.append(A)
    cipher.append(B)
    cipher.append(C)
    cipher.append(D)
    return cipher



def encrypt_16bytes(sentence, s):
    cipher = encrypt(sentence,s)
    tmp = bytearray(0)
    for i in range(len(cipher)):
        b = cipher[i].to_bytes(4,"big")
        tmp += b
    return tmp


def main():
    with open("key.txt") as f:
        key = f.read()

    if len(key) <16:
        key = key + " "*(16-len(key))
    key = key[:16]


    print("Key: " + key)
    s = generateKeyForW32(key)
    with open("message.txt", "rb") as f:
        sentence = f.read()

    result  = bytearray()
    while (len(sentence)):
       next_16bytes = sentence[:16]
       result += encrypt_16bytes(next_16bytes, s)
       sentence = sentence[16:]

    with open("encrypted.txt","wb") as f:
        f.write(result);


if __name__ == "__main__":
    main()
