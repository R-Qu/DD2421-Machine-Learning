# Prune the buildtree for MONK
import monkdata as m
import dtree as d
import drawtree_qt5 as dt
import matplotlib.pyplot as plt
import random
fraction = 0.6
def partition(data, fraction):
    ldata = list(data)
    random.shuffle(ldata)
    breakPoint = int(len(ldata) * fraction)
    return ldata[:breakPoint], ldata[breakPoint:]
monk1train, monk1val = partition(m.monk3, fraction)
print d.buildTree(m.monk3, m.attributes)
def prunecont(tree, maxp):
    alt = d.allPruned(tree)
    prunecheck = range(len(alt))
    maxprune = 0
    indx = 999
    for x in range(len(alt)):
        prunecheck[x] = d.check(alt[x], monk1val)
        if prunecheck[x] >= maxprune:
            maxprune = prunecheck[x]
            indx = x+1
    if maxprune >= maxp:
        print maxprune
        plt.figure()
        plt.plot(range(1,len(alt)+1),prunecheck)
        plt.title('MONK-1')
        plt.xlabel('Pruning Alternatives')
        plt.ylabel('Pruning Accuracy')
        plt.show()
        return prunecont(alt[indx-1], maxprune)
    else:
        return tree
finaltree = prunecont(d.buildTree(monk1train, m.attributes), 0)
print finaltree
dt.drawTree(finaltree)
