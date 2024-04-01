#include <stdlib.h>
#include <stdio.h>
#include <vector>
#include <algorithm>

using namespace std;

int main(int argc, char const *argv[])
{
    int caso = 1;
    while (true) {
        int n, m;
        scanf("%d %d", &n, &m);

        if (n == 0 and m == 0) break;

        vector<int> nums = vector<int>();

        for (int i = 0; i < n; i++) {
            int a;
            scanf("%d", &a);
            nums.push_back(a);
        }

        sort(nums.begin(), nums.end());

        printf("CASE# %d:\n", caso);
        for (int i = 0; i < m; i++) {
            bool found = false;
            int a;
            scanf("%d", &a);
            int size = nums.size();
            int pos = size / 2;
            int stop = 0;
            int ajuste = size / 4;
            while (stop < 3) {
                if (nums[pos] == a) {
                    while (pos > 0 && nums[pos-1] == a) {
                        pos--;
                    }
                    printf("%d found at %d\n", a, pos+1);
                    found = true;
                    break;
                } else if (nums[pos] < a) {
                    pos = pos + ajuste;
                    if (pos >= nums.size()) pos = nums.size() -1;
                } else {
                    pos = pos - ajuste;
                    if (pos < 0) pos = 0;
                }

                if (ajuste == 1) stop++;

                ajuste = ajuste % 2 == 0 ? ajuste / 2 : ajuste / 2 + 1;
            }
            if (!found) printf("%d not found\n", a);
        }
        caso++;
    }
    return 0;
}
