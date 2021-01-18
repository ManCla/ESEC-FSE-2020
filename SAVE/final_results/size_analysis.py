import os
import fnmatch
import csv
import numpy as np

for path,dirs,files in os.walk('.'):                         #iterate ovedr directories
    if (path=="./greedy"):
        for f in fnmatch.filter(files,'*.csv'):              #iterate over csv files
            fullname = os.path.relpath(os.path.join(path,f))
            pixels = fullname.split('_')[3].split('.')[0]
            print("-- " + pixels + " --")
            doc = open(fullname, newline='\n')
            ssim = []
            size = []
            for row in csv.reader(doc, delimiter=','):       #iterate over lines of file
                ssim.append(float(row[4]))
                size.append(float(row[5]))
            print("Worst   case SSIM=%f" % max(ssim))
            print("Average case SSIM=%f" % np.mean(ssim))
            print("Worst   case size=%d" % max(size))
            print("Average case size=%d" % np.mean(size))
            doc.close()
            

