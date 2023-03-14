def reverseBits(n):
     a= '{0:032b}'.format(n)
     reverse =  a[::-1]
     return int(reverse,2)