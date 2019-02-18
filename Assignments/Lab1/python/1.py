import monkdata as m
import dtree as d 
import drawtree_qt5 as dt

t=d.buildTree(m.monk1, m.attributes)
print(d.check(t, m.monk1test))
