#include <vector>
#include <utility>
#include <tuple>
#define INF 999999999
#define NULL 0

using namespace std;

class Grafo {
public:
    vector<int> vertices;
    vector<tuple<int, int, int>> adj;
    int size;
};

// O(n*m)
// n -> numero de vertices
// m -> numero de arestas
tuple<bool, vector<int>, vector<int>> bellman_ford(Grafo g, int s) {
    std::vector<int> d;
    std::vector<int> a;
    for (int i = 0; i < g.size; i++) {
        d.push_back(INF);
        a.push_back(-1);
    }
    d[s] = 0;
    for (int i = 0; i < g.size - 1; i++) {
        for (tuple<int, int, int> aresta : g.adj) {
            if (d[get<1>(aresta)] > d[get<0>(aresta)] + d[get<2>(aresta)]) {
                d[get<1>(aresta)] = d[get<0>(aresta)] + d[get<2>(aresta)];
                a[get<1>(aresta)] = get<0>(aresta);
            }
        }
    }

    for (tuple<int, int, int> aresta : g.adj) {
        if (d[get<1>(aresta)] > d[get<0>(aresta)] + d[get<2>(aresta)]) {
            return tuple<bool, vector<int>, vector<int>>(false, NULL, NULL);
        }
    }
    return tuple<bool, vector<int>, vector<int>>(true, d, a);
}

int main(int argc, char const *argv[])
{
    /* code */
    return 0;
}
