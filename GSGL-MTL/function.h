#define FUNCTION_H

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>
#include <stddef.h>

#if (defined(_WIN32) || defined(_WIN64))
#define dgemm_ dgemm
#define dpotrf_ dpotrf
#define dpotrs_ dpotrs
#define dgemv_ dgemv
#endif

extern void dgemm_(char* tra, char* trb, size_t* m, size_t* n, size_t* k, double* alpha, double* a, size_t* lda,
		double* b, size_t* ldb, double* beta, double* c, size_t* ldc);

extern void dpotrf_(char* uplo, size_t* n, double* a, size_t* lda, ptrdiff_t* info);

extern void dpotrs_(char* uplo, size_t* n, size_t* nrhs, double* a, size_t* lda, double* b,
		size_t* ldb, ptrdiff_t* info);

extern void dgemv_(char* trans, size_t* m, size_t* n, double* alpha, double* a, size_t* lda,double* x,
		size_t* incx, double* beta, double* y, size_t* incy); 