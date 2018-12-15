#include "mexrel.h"
#include "function.h"

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
	double *A, *B, *B2;
	size_t n; 

	A = mxGetPr(prhs[0]); 
	B = mxGetPr(prhs[1]);

	n = mxGetN(prhs[0]);

	ptrdiff_t info = 0;
	char UPLO = 'U';
	size_t nrhs2 = 1;

	plhs[0] = mxCreateDoubleMatrix(n, 1, mxREAL);
	B2 = mxGetPr(plhs[0]);
	memcpy(B2, B, n*mxGetElementSize(prhs[1]));

	dpotrs_(&UPLO, &n, &nrhs2, A, &n, B2, &n, &info);
}
