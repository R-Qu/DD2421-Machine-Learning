#include "mex.h"

void oracle(double x[], double y[])
{
  if ((x[0] >=3) && ( x[0] <=7 ) && ( y[0] >=2) && (y[0]<=6))
    {
      printf("(%d,%d) is a positive example\n",(int) x[0], (int) y[0]);
      //return 1;
    }
  else
   {
      printf("(%d,%d) is a negative example\n",(int) x[0], (int) y[0]);
      //return 0;
    }
}

void mexFunction(
		 int nlhs, mxArray *plhs[],
		 int nrhs, const mxArray *prhs[])
{
  double *x, *y, *z;
  if (nrhs!=2)
    mexErrMsgTxt("two inputs required!");

  x = mxGetPr(prhs[0]);
  y = mxGetPr(prhs[1]);
  //z = mxGetPr(plhs[0]);

  oracle(x,y);
}
 
