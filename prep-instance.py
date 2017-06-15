
import sys, geninstance, genpcat

maxpc = geninstance.geninstance(sys.argv[1], int(sys.argv[2]) if len(sys.argv) > 2 and sys.argv[2] != '' else 0)
genpcat.genpcat(32, maxpc)