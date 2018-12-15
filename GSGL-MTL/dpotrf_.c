#include "mexrel.h"
#include "function.h"

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
	double *A, *A2;
	size_t n; 

	A = mxGetPr(prhs[0]); 

	n = mxGetN(prhs[0]);

	char UPLO = 'U';
	ptrdiff_t info = 0;

	plhs[0] = mxCreateDoubleMatrix(n, n, mxREAL);
	A2 = mxGetPr(plhs[0]);
	memcpy(A2, A, n*n*mxGetElementSize(prhs[0]));

	dpotrf_(&UPLO, &n, A2, &n, &info);
}
