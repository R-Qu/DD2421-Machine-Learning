#!/usr/bin/env python
import numpy as np
from scipy.optimize  import minimize
import random, math
import matplotlib.pyplot as plt
import matplotlib.patches as mpatches

def kernel(x1,x2,type='RBF'):
    if type == 'linear':
        x1t = np.transpose(x1)
        return np.dot(x1t,x2)
    elif type == 'polynomial2':
        x1t = np.transpose(x1)
        return math.pow(np.dot(x1t,x2)+1,2)
    elif type == 'polynomial3':
        x1t = np.transpose(x1)
        return math.pow(np.dot(x1t,x2)+1,3)
    elif type == 'RBF':
        sigma=0.3
        return math.exp(-np.linalg.norm(x1-x2, 2)**2/(2*sigma**2))

def objective(alpha_):
    alpha_product = -sum(alpha_)
    for i in range(N):
        for j in range(N):
            procedure = 0.5 * alpha_[i] * alpha_[j] * p_matrix[i][j]
            alpha_product += procedure

    return alpha_product

def zerofun(alpha_):
    return np.dot(alpha_, inputs)

def p_matrix(inputs, targets, N):
    P = []
    for i in range(N):
        A = []
        for j in range(N):
            k = kernel(inputs[i], inputs[j])
            A.append(targets[i]*targets[j]*k)
        P.append(np.array(A))

    return np.array(P)

#Extract the non-zero alpha values
def separate_alpha(alpha, inputs, targets, threshold):
    zeroPoints = []
    zeroTargets = []
    zeroAlpha = []
    svPoints = []
    svTargets = []
    svAlpha = []
    for i in range(len(alpha)):
        if alpha[i]<threshold:
            zeroAlpha.append(alpha[i])
            zeroPoints.append(inputs[i])
            zeroTargets.append(targets[i])
        else:
            svAlpha.append(alpha[i])
            svPoints.append(inputs[i])
            svTargets.append(targets[i])

    return svAlpha, svPoints, svTargets, zeroAlpha, zeroPoints, zeroTargets

def calculate_b(alphas, inputs, targets, C):
    si = 0
    for i in range(len(alphas)):
        if alphas[i] < C:
            si = i
            break
    ans = 0
    for i in range(len(inputs)):
        ans += alphas[i]*targets[i]*kernel(inputs[si], inputs[i])
    return ans - targets[si]

def indicator(sv, alphas, inputs, targets, b):
    sm = 0
    for i in range(len(alphas)):
        sm += alphas[i]*targets[i]*kernel(sv,inputs[i])
    sm -= b
    return sm

if __name__ == "__main__":
    #bestC, bestCF1, bestRes = None, None, None
    np.random.seed(100)
    classA = np.concatenate(
        (np.random.randn ( 10 , 2) *0.2+ [ 1.5, 0.5 ] ,
        np.random.randn ( 10 , 2)*0.2 + [ -1.5 ,0.5 ] ) )
    classB = np.random.randn(20,2) *0.2+[0.0,-0.5]

    inputs=np.concatenate((classA,classB))
    targets=np.concatenate(
        (np.ones(classA.shape[0]),
        -np.ones(classB.shape[0])))

    N=inputs.shape[0]

    permute = list(range(N))
    random.shuffle(permute)
    inputs = inputs[permute,:]
    targets = targets[permute]

    p_matrix = p_matrix(inputs, targets, N)
    threshold = math.pow(10, -5)
    C = 10

    #minimize:
    B=[(0, C) for b in range(N)]
    start=np.zeros(N)
    XC = {'type':'eq', 'fun':zerofun}
    alpha = minimize(objective, start, bounds=B,
    constraints=XC).x
    
    svAlpha, svPoints, svTargets, zeroAlpha, zeroPoints, zeroTargets=\
    separate_alpha(alpha, inputs, targets, threshold)
    b = calculate_b(svAlpha, svPoints, svTargets, C)
    print ("SVM with C={}, alpha={}".format(C, svAlpha))

    #Plotting
    plt.plot([p[0] for p in classA], [p[1] for p in classA],'b+')
    plt.plot([p[0] for p in classB], [p[1] for p in classB],'r.')
    plt.axis('equal')
    plt.savefig('svmplot.pdf')

    xgrid = np.linspace(-5,5)
    ygrid = np.linspace(-4,4)
    grid = np.array([[indicator(np.array([x,y]),
    svAlpha, svPoints, svTargets, b)
    for x in xgrid]
    for y in ygrid])

    plt.contour(xgrid, ygrid, grid, (-1.0, 0.0, 1.0),
    colors=('red', 'black', 'blue'),
    linewidths=(1,3,1))

    blue_patch = mpatches.Patch(color='blue', label='ClassA')
    red_patch = mpatches.Patch(color='red', label='ClassB')
    black_patch = mpatches.Patch(color='black', label='Decision Boundry')
    plt.legend(handles=[blue_patch, red_patch, black_patch])

    plt.xlabel('X')
    plt.ylabel('Y')
    plt.savefig('svmplt.pdf')
    plt.show()
