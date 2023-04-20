//! Copyright 2023 Tális Breda
#ifndef STRUCTURES_LINKED_LIST_H
#define STRUCTURES_LINKED_LIST_H

#include <cstdint>


namespace structures {
//! ...
template<typename T>
class LinkedList {
 public:
    //! ...
    LinkedList() {
        head = nullptr;
        size_ = 0;
    }  // construtor padrão
    //! ...
    ~LinkedList() {
        clear();
    }  // destrutor
    //! ...
    void clear() {
    } // limpar lista
    //! ...
    void push_back(const T& data) {
        if (empty()) {
            head = new Node(data);
        } else {
            Node* aux = travelTo(size());
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
        if (size() <= index) {
            throw std::out_of_range("Posição inválida");
        } else {
            Node* aux = travelTo(index);
            Node* novo = new Node(data, aux->next());
            aux->next(novo);
        }
        size_++
    }  // inserir na posição
    //! ...
    void insert_sorted(const T& data) {
        if (empty()) {
            head = new Node(data);
        } else {
            Node* aux = head;
            Node* anterior = head;
            for (int i = 0; i < size(); i++) {
                if (aux->data() > data) {
                    Node* novo = new Node(data, aux);
                    anterior->next(novo);
                    aux = novo;
                    break;
                }
                anterior = aux;
                aux = aux->next();
            }
        }
        size_++;
    }  // inserir em ordem
    //! ...
    T& at(std::size_t index) {
        if (empty() || index >= size()) {
            throw std::out_of_range("Posição inválida");
        } else {
            Node* aux = travelTo(index);
            return aux;
        }
    }  // acessar um elemento na posição index
    //! ...
    T pop(std::size_t index) {
        if (empty() || index >= size()) {
            throw std::out_of_range("Posição inválida");
        } else {
            Node* anterior = travelTo(index-1);
            Node* aux = anterior->next()
            Node* next = aux->next();
            anterior->next(next)
            size_--;
            return aux;
        }
    }  // retirar da posição
    //! ...
    T pop_back() {
        if (empty()) {
            throw std::out_of_range("Lista vazia");
        } else {
            Node* anterior = travelTo(size()-1);
            aux = anterior->next();
            anterior->next(nullptr);
            size_--;
            return aux;
        }
    }  // retirar do fim
    //! ...
    T pop_front() {
        
    }  // retirar do início
    //! ...
    void remove(const T& data);  // remover específico
    //! ...
    bool empty() const;  // lista vazia
    //! ...
    bool contains(const T& data) const;  // contém
    //! ...
    std::size_t find(const T& data) const;  // posição do dado
    //! ...
    std::size_t size() const;  // tamanho da lista

    Node* travelTo(int index) {
        Node* aux = head;
        for (int i = 0; i < index; i++) {

            aux = aux->next
        }
        return aux;
    }

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

    Node* head{nullptr};
    std::size_t size_{0u};
};

}  // namespace structures

#endif
