#include <stdio.h>

#define ROWS 3 // M
#define COLS 4 // N

void fmi(int m[][COLS], int rows, int cols, int *max_i, int *max_j)
{
  if (rows <= 0 || cols <= 0)
  {
    *max_i = -1;
    *max_j = -1;

    return;
  }

  int max_el = m[0][0];
  *max_i = 0;
  *max_j = 0;
  for (int i = 0; i < rows; i++)
  {
    for (int j = 0; j < cols; j++)
    {
      if (m[i][j] > max_el)
      {
        max_el = m[i][j];
        *max_i = i;
        *max_j = j;
      }
    }
  }
}

int main(void)
{
  int matrix[ROWS][COLS] = {
      {1, 2, 3, 4},
      {5, 12, 7, 8},
      {9, 10, 11, 6}};

  int i, j;
  fmi(matrix, ROWS, COLS, &i, &j);

  printf("%d %d\n", i, j);
  
  return 0;
}