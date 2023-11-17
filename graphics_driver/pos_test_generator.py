import numpy as np

f = open("./v_pos.txt", "a")


for i in range(0, 480):
    for j in range(0, 640):
        f.write("\""+ "{0:b}".format(j).rjust(10, "0") + "\" after " + str(i * 25600 + j * 40) + " ns,\n")
