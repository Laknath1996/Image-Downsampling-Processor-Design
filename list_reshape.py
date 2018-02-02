#Author : Ashwin de Silva
#Last Updated : 2018 Feb 1

#Function : Reads a text file and list all the hexa decimal values line by line.


f = open("output.txt","r")
A = f.read()
f.close()

M = [];
i = 0
while i < 80000 :
    M.append(A[i:i+2])
    i = i + 2

g = open("final_output.txt","w")
g.writelines("\n".join(M))
g.close()


