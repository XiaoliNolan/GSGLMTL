#ifndef MEXREL_H
#define MEXREL_H

#include "mex.h"

double getScalarStruct(const mxArray* pr_struct, const char* name, const double defv);
double* getPointerStruct(const mxArray* pr_struct, const char* name);

double getScalarStruct(const mxArray* pr_struct, const char* name, const double defv)
{
	mxArray *pr_field = mxGetField(pr_struct,0,name);
	if (!pr_field)
		return defv;
	return (mxGetScalar(pr_field));
}

double* getPointerStruct(const mxArray* pr_struct, const char* name)
{
	const mxArray *pr_field = mxGetField(pr_struct,0,name);
	if (!pr_field)
		return NULL;
	return (mxGetPr(pr_field));
}

#endif
