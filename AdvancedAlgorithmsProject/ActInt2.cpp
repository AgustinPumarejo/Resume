/*
Actividad Integradora 2
Agustín Pumarejo Ontañón A01028997
Adriana Abella Kuri A01329591
Fecha de creación: 17-Nov-2021
*/

#include <iostream>
#include <vector>
#include <fstream>
#include <unordered_map>
#include <unordered_set>
#include <map>
#include <algorithm>
#include <math.h>

using namespace std;

class Nodo {
    public:
        int id;
        unordered_map<int, int> flujoMax;
        unordered_map<int, int> residuo;
        unordered_map<int, int> aristas;

        Nodo() {}
        Nodo(int _id){
            id = _id;
            flujoMax = {};
        }
};

class Grafo {
    public:
        unordered_map<int, Nodo*> nodos;
        vector<vector<int>> adyacencia;
        vector<vector<int>> siguiente;
        map<int, vector<vector<int>>> aristas;
        int n;

        Grafo() {
            nodos = {};
            adyacencia = {};
            siguiente = {};

            ifstream input;
            input.open("input.txt");
            string linea = "";
            getline(input, linea);
            n = stoi(linea);
            getline(input, linea);

            for (int i = 0; i < n; i++) {
                adyacencia.push_back({});
                siguiente.push_back({});
                if (nodos.find(i) != nodos.end()) {
                    nodos[i]->flujoMax.clear();
                }
                else {
                    Nodo *nodo = new Nodo(i);
                    nodos[i] = nodo;
                }   
                for (int j = 0; j < n - 1; j++) {
                    getline(input, linea, ' ');
                    adyacencia[i].push_back(stoi(linea));
                    siguiente[i].push_back(-1);
                    aristas[stoi(linea)].push_back({i, j, stoi(linea)});
                }
                getline(input, linea);
                adyacencia[i].push_back(stoi(linea));
                siguiente[i].push_back(-1);
                siguiente[i][i] = i;
                aristas[stoi(linea)].push_back({i, n-1, stoi(linea)});
            }

            for (int i = 0; i < n; i++) {
                for (int j = 0; j < n; j++) {
                    if (adyacencia[i][j] != 0) {
                        siguiente[i][j] = j;
                    }
                }
            }

            // Llenar listas de flujoMax en cada nodo
            getline(input, linea);
            for (int i = 0; i < n; i++) {
                for (int j = 0; j < n - 1; j++) {
                    getline(input, linea, ' ');
                    if (linea != "0") {
                        nodos[i]->flujoMax[j] = stoi(linea);
                    }
                }
                getline(input, linea);
                if (linea != "0") {
                    nodos[i]->flujoMax[n-1] = stoi(linea);
                }
            }
        }

        vector<int> DFS(int origen, int destino) {
            vector<int> camino = {origen};
            unordered_set<int> visitados;
            visitados.insert(origen);
            return DFSaux(camino, visitados, destino);
        }

        vector<int> DFSaux(vector<int> camino, unordered_set<int> & visitados, int & destino) {
            int ultimoNodo = camino[camino.size()-1];
            if (ultimoNodo == destino) {
                return camino;
            }
            vector<int> caminoTemp = camino;
            vector<int> dfs = {};
            for (auto i : nodos[ultimoNodo]->flujoMax) {
                caminoTemp = camino;
                if (visitados.find(i.first) == visitados.end()) {
                    caminoTemp.push_back(i.first);
                    visitados.insert(i.first);
                    dfs = DFSaux(caminoTemp, visitados, destino);
                    if (!dfs.empty()) {
                        return dfs;
                    }
                }
            }
            return {};
        }
};

void imprimirMatriz(vector<vector<int>> m) {
    for (int i = 0; i < m.size(); i++) {
        for (int j = 0; j < m[i].size(); j++) {
            cout << m[i][j] << " ";
        }
        cout << endl;
    }
    return;
}

void imprimirPares(vector<pair<int, int>> v) {
    for (int i = 0; i < v.size(); i++) {
        cout << "(" << v[i].first << ", " << v[i].second << ")" << endl;
    }
    return;
}

void imprimirRuta(vector<pair<int, int>> v) {
    for (int i = 0; i < v.size(); i++) {
        cout <<  v[i].first << " " << v[i].second << endl;
    }
    return;
}

vector<pair<int, int>> rutaMinima(Grafo &g, int origen, int destino) {

    for (int k = 0; k < g.n; k++) {
        for (int i = 0; i < g.n; i++) {
            for (int j = 0; j < g.n; j++) {
                if (g.adyacencia[i][j] > (g.adyacencia[i][k] + g.adyacencia[k][j])) {
                    g.adyacencia[i][j] = g.adyacencia[i][k] + g.adyacencia[k][j];
                    g.siguiente[i][j] = g.siguiente[i][k];
                }
            }
        }
    }

    int actual = origen;
    int siguiente = g.siguiente[actual][destino];
    vector<pair<int, int>> camino;
    while(actual != destino) {
        camino.push_back(make_pair(actual, siguiente));
        actual = siguiente;
        siguiente = g.siguiente[actual][destino];
    }
    return camino;
}

void augment(Grafo &g, vector<int> camino) {
    int cb = g.nodos[camino[0]]->flujoMax[camino[1]];
    for (int i = 0; i < camino.size()-1; i++) {
        if (g.nodos[camino[i]]->flujoMax[camino[i+1]] < cb) {
            cb = g.nodos[camino[i]]->flujoMax[camino[i+1]];
        }
    }
    for (int i = 0; i < camino.size()-1; i++) {
        g.nodos[camino[i]]->flujoMax[camino[i+1]] -= cb;
        if (g.nodos[camino[i]]->flujoMax[camino[i+1]] == 0) {
            g.nodos[camino[i]]->flujoMax.erase(camino[i+1]);
        }
    }
    for (int i = camino.size()-1; i > 0; i--) {
        if (g.nodos[camino[i]]->residuo.find(camino[i-1]) != g.nodos[camino[i]]->residuo.end()) {
            g.nodos[camino[i]]->residuo[camino[i-1]] += cb;
        }
        else {
            g.nodos[camino[i]]->residuo[camino[i-1]] = cb;
        }
    }
    return;
}

int fordFulkerson(Grafo g, int origenFlujo, int destinoFlujo) {
    vector<int> camino = {};
    while(true) {
        camino = g.DFS(origenFlujo, destinoFlujo);
        if(camino.empty()) {
            int flujoMaximo = 0;
            for(auto residuo : g.nodos[destinoFlujo]->residuo) {
                flujoMaximo += residuo.second;
            }
            cout << flujoMaximo << endl;
            return flujoMaximo;
        }
        augment(g, camino);
    }
    return -1;
}

// Función para encontrar el árbol de expansión mínimo de un grafo
// Recibe la referencia del grafo
// Regresa un vector con las aristas del árbol ordenados de menor a mayor peso, con nodo de origen y nodo de destino
vector<pair<int, int>> kruskals(Grafo * g) {
    vector<pair<int, int>> res;
    map<int, vector<vector<int>>> aristas = g->aristas;
    unordered_map<int, vector<int>> islasNodos;
    unordered_map<int, int> nodosIslas;
    int numIslas = 0;
    for (auto i : g->nodos) {
        islasNodos[numIslas] = {i.first};
        nodosIslas[i.first] = numIslas;
        numIslas++;
    }
    int origen = -1;
    int destino = -1;
    int peso = -1;
    int islaAnterior = -1;
    for (auto i : aristas) {
        for (auto a : i.second) {
            origen = a[0];
            destino = a[1];
            if (nodosIslas[origen] != nodosIslas[destino]) {
                islaAnterior = nodosIslas[destino];
                for (auto j : islasNodos[nodosIslas[destino]]) {
                    islasNodos[nodosIslas[origen]].push_back(j);
                    nodosIslas[j] = nodosIslas[origen];
                }
                islasNodos.erase(islaAnterior);
                res.push_back(make_pair(origen, destino));
            }
        }
    }
    return res;
}

int binarySearchX(vector<pair<int, int>> &lista, int num) {
    int inicio = 0;
    int fin = lista.size() - 1;
    if (num < lista[inicio].first || num > lista[fin].first) {
        return inicio;
    }
    while (inicio < fin) {
        int medio = (inicio + fin) / 2;
        if (num < lista[medio].first) {
            fin = medio - 1;
        }
        else if (num > lista[medio].first) {
            inicio = medio + 1;
        }
        else {
            return medio;
        }
    }
    return fin;
}

class parPuntos {
    public:
    pair<int, int> p1 = {};
    pair<int, int> p2 = {};
    int distancia = -1;

    parPuntos(pair<int, int> _p1, pair<int, int> _p2) {
        p1 = _p2 > _p1 ? _p2 : _p1;
        p2 = _p2 > _p1 ? _p1 : _p2;
        int x = abs(_p1.first - _p2.first);
        int y = abs(_p1.second - _p2.second);
        distancia = sqrt(pow((x), 2) + pow(y, 2));
    }

    void calcDist() {
        int x = abs(p1.first - p2.first);
        int y = abs(p1.second - p2.second);
        distancia = sqrt(pow((x), 2) + pow(y, 2));
        return;
    }
};

parPuntos cercanosAux(vector<pair<int, int>> &puntos, int a, int b) {

    if (a + 2 == b) {
        parPuntos pp1(puntos[a], puntos[a + 1]);
        parPuntos pp2(puntos[a], puntos[a + 2]);
        parPuntos pp3(puntos[a + 1], puntos[a + 2]);
        parPuntos minimo = pp1.distancia < pp2.distancia ? pp1 : pp2;
        minimo = minimo.distancia <= pp3.distancia ? minimo : pp3;
        return minimo;
    }
    else if (a + 1 == b) {
        return parPuntos(puntos[a], puntos[a + 1]);
    }
    else {
        int div = (a + b)/2;
        parPuntos pp1 = cercanosAux(puntos, a, div);
        parPuntos pp2 = cercanosAux(puntos, div + 1, b);

        parPuntos minimo = pp1.distancia < pp2.distancia ? pp1 : pp2;
        int bajo = puntos[div].first - minimo.distancia;
        int alto = puntos[div].first + minimo.distancia;
        int primero = binarySearchX(puntos, bajo);
        vector<pair<int, int>> franja;
        while (puntos[primero].first <= alto && primero < puntos.size()) {
            franja.push_back(puntos[primero]);
            primero++;
        }
        sort(franja.begin(), franja.end(), [](pair<int, int> p1, pair<int, int> p2){return p1.second < p2.second;});
        parPuntos par(make_pair(-1, -1), make_pair(-1, -1));

        for (int i = 0; i < franja.size() - 1; i++) {
            for (int j = i + 1; j < i + 7 && j < franja.size(); j++) {
                if (franja[i] > franja[j]) {
                    par.p1 = franja[i];
                    par.p2 = franja[j];
                }
                else {
                    par.p1 = franja[j];
                    par.p2 = franja[i];
                }
                par.calcDist();
                minimo = par.distancia < minimo.distancia ? par : minimo;
            }
        }
        return minimo;
    }
}

parPuntos puntosCercanos(vector<pair<int, int>> puntos) {
    sort(puntos.begin(), puntos.end());
    return cercanosAux(puntos, 0, puntos.size()-1);
}

int main() {

    Grafo g = Grafo();

    // 1
    vector<pair<int, int>> spanning = kruskals(&g);
    sort(spanning.begin(), spanning.end(), [](pair<int, int> p1, pair<int, int> p2){return p1.second < p2.second;});

    ifstream input;
    input.open("input.txt");
    string linea = "";
    getline(input, linea);
    int n = stoi(linea);
    
    imprimirPares(spanning);
    cout << endl;

    // 2
    imprimirRuta(rutaMinima(g, 0, n-1));
    cout << endl;

    // 3
    fordFulkerson(g, 0, n-1);
    vector<pair<int, int>> coordenadas;
    int x;
    int y;
    for (int i = 0; i < n; i++) {
        getline(input, linea, '(');
        getline(input, linea, ',');
        x = stoi(linea);
        getline(input, linea, ')');
        y = stoi(linea);
        coordenadas.push_back(make_pair(x, y));
    }
    parPuntos res = puntosCercanos(coordenadas);

    cout << endl;

    cout << "(" << res.p1.first << ", " << res.p1.second << ")" << endl << "(" << res.p2.first << ", " << res.p2.second << ")" << endl;

    return 0;
}
