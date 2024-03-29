//! Copyright 2023 Tális Breda
#define STRUCTURES_LINKED_LIST_H

#include <stdint.h>
#include <stdexcept>

namespace structures {
//! ...
template<typename T>
class LinkedList {
 public:
    //! ...
    LinkedList() {
        clear();
    }  // construtor padrão
    //! ...
    ~LinkedList() {
        clear();
    }  // destrutor
    //! ...
    void clear() {
        head = nullptr;
        size_ = 0;
    }  // limpar lista
    //! ...
    void push_back(const T& data) {
        if (empty()) {
            head = new Node(data);
        } else {
            Node* aux = end();
            aux->next(new Node(data));
        }
        size_++;
    }  // inserir no fim
    //! ...
    void push_front(const T& data) {
        if (empty()) {
            head = new Node(data);
        } else {
            Node* aux = new Node(data, head);
            head = aux;
        }
        size_++;
    }  // inserir no início
    //! ...
    void insert(const T& data, std::size_t index) {
        if (index > size()) {
            throw std::out_of_range("Posição inválida");
        } else {
            Node* anterior = travelTo(index-1);
            Node* aux = anterior->next();
            Node* novo = new Node(data, aux);
            anterior->next(novo);
        }
        size_++;
    }  // inserir na posição
    //! ...
    // [3, 5, 7, 9, 11]
    // node(12, nullptr)
    // node(11, 12)
    void insert_sorted(const T& data) {
        if (empty()) {
            head = new Node(data);
        } else {
            Node* atual = head;
            Node* anterior = nullptr;
            for (auto i = 0u; i <= size(); i++) {
                if (atual == nullptr || atual->data() > data) {
                    Node* novo = new Node(data, atual);
                    if (anterior == nullptr) {
                        head = novo;
                    } else {
                        anterior->next(novo);
                    }
                    break;
                }
                anterior = atual;
                atual = atual->next();
            }
        }
        size_++;
    }
  // inserir em ordem
    //! ...
    T& at(std::size_t index) {
        if (empty() || index >= size()) {
            throw std::out_of_range("Posição inválida");
        } else {
            Node* aux = travelTo(index);
            return aux->data();
        }
    }  // acessar um elemento na posição index
    //! ...
    T pop(std::size_t index) {
        if (empty() || index >= size()) {
            throw std::out_of_range("Posição inválida");
        } else {
            Node* anterior = travelTo(index-1);
            Node* aux = anterior->next();
            Node* next = aux->next();
            anterior->next(next);
            size_--;
            return aux->data();
        }
    }  // retirar da posição
    //! ...
    T pop_back() {
        if (empty()) {
            throw std::out_of_range("Lista vazia");
        } else if (size() == 1) {
            Node* tail = end();
            T data = tail->data();
            head = tail = nullptr;
            size_ = 0;
            return data;
        } else {
            Node* anterior = travelTo(size()-2);
            Node* tail = end();
            anterior->next(nullptr);
            size_--;
            return tail->data();
        }
    }  // retirar do fim
    //! ...
    T pop_front() {
        if (empty()) {
            throw std::out_of_range("Lista vazia");
        } else {
            Node* aux = head;
            head = head->next();
            size_--;
            return aux->data();
        }
    }  // retirar do início
    //! ...
    void remove(const int& data) {
        if (empty()) {
            throw std::out_of_range("Lista vazia");
        } else if (head->data() == data) {
            head = head->next();
        } else {
            Node* anterior = head;
            Node* aux = head->next();
            for (auto i = 0u; i < size(); i++) {
                if (aux->data() == data) {
                    Node* next = aux->next();
                    anterior->next(next);
                    break;
                }
                anterior = aux;
                aux = aux->next();
            }
            size_--;
        }
    }  // remover específico
    //! ...
    bool empty() const {
        return size() == 0;
    }  // lista vazia
    //! ...
    bool contains(const T& data) const {
        Node* aux = head;
        for (auto i = 0u; i < size(); i++) {
            if (aux->data() == data) {
                return true;
            }
            aux = aux->next();
        }
        return false;
    }  // contém
    //! ...
    std::size_t find(const T& data) const {
        Node* aux = head;
        for (auto i = 0u; i < size(); i++) {
            if (aux->data() == data) {
                return i;
            }
            aux = aux->next();
        }
        return size();
    }  // posição do dado
    //! ...
    std::size_t size() const {
        return size_;
    }  // tamanho da lista

 private:
    class Node {  // Elemento
     public:
        explicit Node(const T& data):
            data_{data}
        {}

        Node(const T& data, Node* next):
            data_{data},
            next_{next}
        {}

        T& data() {  // getter: dado
            return data_;
        }

        const T& data() const {  // getter const: dado
            return data_;
        }

        Node* next() {  // getter: próximo
            return next_;
        }

        const Node* next() const {  // getter const: próximo
            return next_;
        }

        void next(Node* node) {  // setter: próximo
            next_ = node;
        }

     private:
        T data_;
        Node* next_{nullptr};
    };

    Node* end() {  // último nodo da lista
        auto it = head;
        for (auto i = 1u; i < size(); ++i) {
            it = it->next();
        }
        return it;
    }

    Node* travelTo(std::size_t index) {
        Node* aux = head;
        for (auto i = 0u; i < index; i++) {
            aux = aux->next();
        }
        return aux;
    }

    Node* head{nullptr};
    std::size_t size_{0u};
};


}  // namespace structures
