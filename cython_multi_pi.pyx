from libc.math cimport sqrt
from cython.parallel cimport prange
cimport openmp

def main( long long nmax, int threads ):

    cdef:

        double pibyfour = 0.0
        double dx = 1.0 / nmax
        long long i
        double initial, final, run_time
        double idx, pi

    initial = openmp.omp_get_wtime()

    for i in prange(nmax, nogil=True, num_threads=threads):
        idx = i*dx
        pibyfour += sqrt(1-idx*idx)
    final = openmp.omp_get_wtime()

    run_time = (final - initial)

    pi = 4.0 * pibyfour * dx
    return pi, run_time