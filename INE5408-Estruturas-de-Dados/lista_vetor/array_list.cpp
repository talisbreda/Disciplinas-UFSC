#ifndef STRUCTURES_ARRAY_LIST_H
#define STRUCTURES_ARRAY_LIST_H

#include <cstdint>


namespace structures {

template<typename T>
class ArrayList {
 public:
        ArrayList() {
            contents = new T[DEFAULT_MAX];
            size_ = 0;
            max_size_ = DEFAULT_MAX;
        }
        explicit ArrayList(std::size_t max_size) {
            contents = new T[max_size];
            size_ = 0;
            max_size_ = max_size;
        }
        ~ArrayList() {
            delete[] contents;
        }

        void clear() {
            size_ = 0;
        }
        void push_back(const T& data) {
            insert(data, size_);
        }
        void push_front(const T& data) {
            insert(data, 0);
        }
        void insert(const T& data, std::size_t index) {
            if (index >= max_size_) {
                throw std::out_of_range("Índice maior que a lista");
            } else if (size_ == max_size_) {
                throw std::out_of_range("Lista cheia");
            } else {
                shift_to_right(index);
                contents[index] = data;
                size_++;
            }
        }
        void insert_sorted(const T& data) {
            if (size_ == max_size_) {
                throw std::out_of_range("Lista cheia");
            }
            for (int i = 0; i < static_cast<int>(size_)-1; i++) {
                if (contents[i] > data && contents[i+1] < data) {
                    shift_to_right(i+1);
                    contents[i+1] = data;
                    size_++;
                    break;
                }
            }
        }
        T pop(std::size_t index) {
            if (size_ > index) {
                T aux = contents[index];
                shift_to_left(index);
                size_--;
                return aux;
            } else {
                throw std::out_of_range("Lista menor que o índice");
            }
        }
        T pop_back() {
            if (static_cast<int>(size_) > 0) {
                size_--;
                return contents[size_-1];
            } else {
                throw std::out_of_range("Lista vazia");
            }
        }
        T pop_front() {
            if (static_cast<int>(size_) > 0) {
                T aux = contents[0];
                shift_to_left(0);
                size_--;
                return aux;
            } else {
                throw std::out_of_range("Lista vazia");
            }
        }
        void remove(const T& data) {
            for (int i = 0; i < static_cast<int>(size_); i++) {
                if (contents[i] == data) {
                    shift_to_left(i);
                    size_--;
                }
            }
        }
        bool full() const {
            return size_ == max_size_;
        }
        bool empty() const {
            return size_ == 0;
        }
        bool contains(const T& data) const {
            for (int i = 0; i < static_cast<int>(size_); i++) {
                if (contents[i] == data) {
                    return true;
                }
            }
            return false;
        }
        std::size_t find(const T& data) const {
            for (int i = 0; i < static_cast<int>(size_); i++) {
                if (contents[i] == data) {
                    return static_cast<std::size_t>(i);
                }
            }
            return static_cast<int>(-1);
        }
        std::size_t size() const {
            return size_;
        }
        std::size_t max_size() const {
            return max_size_;
        }
        T& at(std::size_t index) {
            if (size() > index) {
                return contents[index];
            }
            throw std::out_of_range("Índice não existe na lista");
        }
        T& operator[](std::size_t index) {
            return contents[index];
        }
        const T& at(std::size_t index) const {
            if (size() > index) {
                return contents[index];
            }
            throw std::out_of_range("Índice não existe na lista");
        }
        const T& operator[](std::size_t index) const {
            return contents[index];
        }

        void shift_to_right(std::size_t index) {
            for (int i = size_; i > static_cast<int>(index); i--) {
                contents[i] = contents[i-1];
            }
        }

        void shift_to_left(std::size_t index) {
            for (int i = index; i < static_cast<int>(size_)-2; i++) {
                contents[i] = contents[i+1];
            }
        }

 private:
        T* contents;
        std::size_t size_;
        std::size_t max_size_;

        static const auto DEFAULT_MAX = 10u;
};


} // namespace structures

#endif
