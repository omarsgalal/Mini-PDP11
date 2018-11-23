#for matrices and solving linear equations
import numpy as np

n = 5

#future vector
F1 = np.array([1800, 900, 200])
F2 = np.array([1100, 1500, 300])

#b vector
B = np.array([1, 1, 1])

#present
X = np.array([[200, 700, 200],
              [300, 100, 300],
              [300, 100, 300]])


for i in range(3):
    #ne3awd bel B
    A = np.dot(np.linalg.inv(X * B.reshape(1, n)), F1.reshape(n,1))
    B = np.dot(np.linalg.inv(X * A.reshape(n, 1)), F2.reshape(n,1))
    print (A)
    print (B)


print (A)
print (B)