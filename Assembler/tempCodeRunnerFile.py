#for matrices and solving linear equations
import numpy as np

#future vector
F1 = np.array([1800, 900])
F2 = np.array([1100, 1500])

#b vector
B = np.array([1, 1])

#present
X = np.array([[200, 700],
              [300, 100]])


for i in range(3):
    #ne3awd bel B
    A = np.dot(np.linalg.inv(X * B.reshape(1, 2)), F1.reshape(2,1))
    B = np.dot(np.linalg.inv(X * A.reshape(2, 1)), F2.reshape(2,1))
    print (A)
    print (B)

print (A)
print (B)