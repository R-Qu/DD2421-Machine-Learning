# Compute the information gain of each attributes of monk datasets.
import monkdata as m
import dtree as d
monk = [m.monk1, m.monk2, m.monk3]
tmp = range(6)
for x in monk:
    IG = 0
    indx = 0
    if x == m.monk1:
        print "MONK-1"
    elif x == m.monk2:
        print "MONK-2"
    else:
        print "MONK-3"
    for y in range(6):
        tmp[y] =d.averageGain(x, m.attributes[y])
        print "Information Gain A{:d}:".format(y+1), tmp[y]
        if IG < tmp[y]:
            IG = tmp[y]
            indx = y
    print "Max Information Gain is for A{:d}:".format(indx+1), IG
