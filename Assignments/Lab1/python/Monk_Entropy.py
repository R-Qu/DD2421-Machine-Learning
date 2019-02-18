# Compute the entropy of monk datasets.
import monkdata as m
import dtree as d
monk1 = d.entropy(m.monk1)
print "MONK-1 entropy:", monk1
monk2 = d.entropy(m.monk2)
print "MONK-2 entropy:", monk2
monk3 = d.entropy(m.monk3)
print "MONK-3 entropy:", monk3