import sys
from numba import jit,prange, set_num_threads
import time
from math import sqrt
import matplotlib.pyplot as plt

@jit(nopython=True,parallel=True)
def main( nmax ):
    pibyfour = 0.0
    dx = 1.0 / nmax
    
    for i in prange(nmax):
        idx = i*dx
        pibyfour += sqrt(1-idx*idx)

    pi = 4.0 * pibyfour * dx
    return pi

thread_number = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]

nmax = 1000000000

set_num_threads(1)

main(1000)

pi_time = []

for threads in thread_number:
    set_num_threads(threads)
    initial = time.time()
    pi = main(nmax)
    final = time.time()
    time_length = final - initial
    pi_time.append(time_length)
    print("threads: ", threads, "pi ", pi, "time: ", time_length)


plt.plot(thread_number, pi_time, marker="o")
plt.xlabel("Number of threads")
plt.ylabel("Time (s)")
plt.title("Pi calculation time vs number of threads")
plt.savefig("pi_time.png", dpi=300, bbox_inches="tight")
