import matplotlib.pyplot as plt
import os, sys

def main(argv):
    files , dirs = 0, 0
    path = argv[0]
    for _,dirnames, filenames in os.walk(path):
        files += len(filenames)
        dirs += len(dirnames)


    data = ['Files', 'Directories']
    nb = [files, dirs]
    plt.bar(data,nb)
    plt.show()

if __name__ == "__main__":
   main(sys.argv[1:])