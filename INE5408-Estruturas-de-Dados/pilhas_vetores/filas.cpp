// Copyright [2018] <COLOQUE SEU NOME AQUI...>
#ifndef STRUCTURES_ARRAY_QUEUE_H
#define STRUCTURES_ARRAY_QUEUE_H

#include <cstdint>  // std::size_t
#include <stdexcept>  // C++ Exceptions

namespace structures {

template<typename T>
//! classe ArrayQueue
class ArrayQueue {
 public:
    //! construtor padrao
    ArrayQueue() {
        contents = new T[DEFAULT_SIZE];
        max_size_ = DEFAULT_SIZE;
        size_ = 0;
        begin_ = 0;
        end_ = -1;
    }
    //! construtor com parametro
    explicit ArrayQueue(std::size_t max) {
        contents = new T[max];
        max_size_ = max;
        size_ = 0;
        begin_ = 0;
        end_ = -1;
    }

    //! destrutor padrao
    ~ArrayQueue() {
        delete [] contents;
    }

    //! metodo enfileirar
    void enqueue(const T& data) {
        if (full()) {
            throw std::out_of_range("Fila cheia");
        } else {
            end_ = (end_+1) % (max_size_);
            contents[end_] = data;
            size_++;
        }
    }

    //! metodo desenfileirar
    T dequeue() {
        if (empty()) {
            throw std::out_of_range("Fila vazia");
        }
            T aux = contents[begin_];
            begin_ = (begin_+1) % (max_size_);
            size_--;
            return aux;
    }
    //! metodo retorna o ultimo
    T& back() {
        if (empty()) {
            throw std::out_of_range("Lista vazia");
        }
        return contents[end_];
    }
    //! metodo limpa a fila
    void clear() {
        size_ = 0;
        begin_ = 0;
        end_ = -1;
    }
    //! metodo retorna tamanho atual
    std::size_t size() {
        return size_;
    }
    //! metodo retorna tamanho maximo
    std::size_t max_size() {
        return max_size_;
    }
    //! metodo verifica se vazio
    bool empty() {
        return size_ == 0;
    }
    //! metodo verifica se esta cheio
    bool full() {
        return size_ == max_size_;
    }

 private:
    T* contents;
    std::size_t size_;
    std::size_t max_size_;
    int begin_;  // indice do inicio (para fila circular)
    int end_;  // indice do fim (para fila circular)
    static const auto DEFAULT_SIZE = 10u;
};

}  // namespace structures

#endif
