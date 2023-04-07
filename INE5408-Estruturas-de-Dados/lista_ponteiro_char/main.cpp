//! Copyright [2020] Tális Breda


#ifndef STRUCTURES_STRING_LIST_H
#define STRUCTURES_STRING_LIST_H

#include <cstdint>
#include <stdexcept>  // C++ exceptions
#include <cstring>



namespace structures {


//! ...
template<typename T>
class ArrayList {
 public:
    //! ...
    ArrayList() {
        max_size_ = DEFAULT_MAX;
        contents = new T[max_size_];
        size_ = 0;
    }
    //! ...
    explicit ArrayList(std::size_t max_size) {
        max_size_ = max_size;
        contents = new T[max_size_];
        size_ = 0;
    }
    //! ...
    ~ArrayList() {
        delete [] contents;
    }

    //! ...
    void clear() {
        size_ = 0;
        delete [] contents;
        contents = new T[max_size_];
    }
    //! ...
    void push_back(const T& data) {
        if (size_ >= max_size_) {
            throw std::out_of_range("Tamanho máximo atingido");
        } else {
            size_++;
            contents[size_] = data;
        }
    }
    //! ...
    void push_front(const T& data) {
        if (size_ >= max_size_) {
            throw std::out_of_range("Tamanho máximo atingido");
        } else {
            contents = shift_to_left(contents);
            size_++;
            contents[0] = data;
        }
    }
    //! ...
    void insert(const T& data, std::size_t index) {
        if (size_ >= max_size_) {
            throw std::out_of_range("Tamanho máximo atingido");
        } else {
            for (int i = size_; i > index; i--) {
                contents[i] = contents[i-1];
            }
            size_++;
            contents[index] = data;
        }
    }
    //! ...
    void insert_sorted(const T& data);
    //! ...
    T pop(std::size_t index) {
        if (index >= size_) {
            throw std::out_of_range("Index is empty");
            return nullptr;
        } else {
            T output = contents[index];
            contents = shift_to_left_from_index(contents, index);
            return output;
        }
    }
    //! ...
    T pop_back() {
        if (size_ == 0) {
            throw std::out_of_range("Lista está vazia");
        } else {
            output = contents[size_];
            contents[size_] = nullptr;
            return output;
        }
    }
    //! ...
    T pop_front() {
        if (size_ == 0) {
            throw std::out_of_range("Lista está vazia");
        } else {
            T output = contents[0];
            contents = shift_to_left(contents);
            return output;
        }
    }
    //! ...
    void remove(const T& data) {
        if (size_ == 0) {
            throw std::out_of_range("Lista está vazia");
        } else {
            int index = -1;
            for (int i = 0; i < size_; size_++) {
                if (contents[i] == data) {
                    contents[i] = nullptr;
                    index = i;
                    break;
                }
            }
            if (index == -1) {
                throw std::out_of_range("Elemento não está na lista");
            } else {
                shift_to_left_from_index(contents, index);
            }
        }
    }
    //! ...
    bool full() const {
        return size_ == max_size_;
    }
    //! ...
    bool empty() const {
        return size_ == 0;
    }
    //! ...
    bool contains(const T& data) const {
        for (int i = 0; i < size_; i++) {
            if (contents[i] == data) {
                return true;
            }
        }
        return false;
    }
    //! ...
    std::size_t find(const T& data) const {
        for (int i = 0; i < size_; i++) {
            if (contents[i] == data) {
                return i;
            }
        }
    }
    //! ...
    std::size_t size() const {
        return size_;
    }
    //! ...
    std::size_t max_size() const {
        return max_size_;
    }
    //! ...
    T& at(std::size_t index) {
        if (index < size_) {
            return contents[index];
        } else {
            throw std::out_of_range("Índice não existe na lista");
        }
    }
    //! ...
    T& operator[](std::size_t index) {
        return contents[index];
    }
    // descricao do 'operator []' na FAQ da disciplina
    //! ...
    const T& at(std::size_t index) const {
        if (static_cast<int>(index) < size_) {
            return contents[index];
        } else {
            throw std::out_of_range("Índice não existe na lista");
        }
    }
    //! ...
    const T& operator[](std::size_t index) const {
        return contents[index];
    }

 private:
    T* contents;
    std::size_t size_;
    std::size_t max_size_;

    static const auto DEFAULT_MAX = 10u;

    T *shift_to_left(T contents[]) {
        for (int i = size_; i > 0; i--) {
            contents[i] = contents[i-1];
        }
        return contents;
    }

    T *shift_to_left_from_index(T contents[], int index) {
        for (int i = index; i < size_; i++) {
            contents[i] = contents[i+1];
        }
        return contents;
    }
};



//-------------------------------------



//! ...
//! ArrayListString e' uma especializacao da classe ArrayList
class ArrayListString : public ArrayList<char *> {
 public:
    //! ...
    ArrayListString() {
        max_size_ = DEFAULT_MAX;
        contents = new char[max_size_];
        size_ = 0;
    }
    //! ...
    explicit ArrayListString(std::size_t max_size) {
        max_size_ = max_size;
        contents = new char[max_size_];
        size_ = 0;
    }
    //! ...
    ~ArrayListString() {
        delete [] contents;
    }

    //! ...
    void clear() {
        size_ = 0;
        delete [] contents;
        contents = new char[max_size_];
    }
    //! ...
    void push_back(const char& data) {
        if (size_ >= max_size_) {
            throw std::out_of_range("Tamanho máximo atingido");
        } else {
            size_++;
            contents[size_] = data;
        }
    }
    //! ...
    void push_front(const char& data) {
        if (size_ >= max_size_) {
            throw std::out_of_range("Tamanho máximo atingido");
        } else {
            contents = shift_to_left(contents);
            size_++;
            contents[0] = data;
        }
    }
    //! ...
    void insert(const char& data, std::size_t index) {
        if (size_ >= max_size_) {
            throw std::out_of_range("Tamanho máximo atingido");
        } else {
            for (int i = size_; i > index; i--) {
                contents[i] = contents[i-1];
            }
            size_++;
            contents[index] = data;
        }
    }
    //! ...
    void insert_sorted(const char& data);
    //! ...
    char pop(std::size_t index) {
        if (index >= size_) {
            throw std::out_of_range("Index is empty");
            return NULL;
        } else {
            char output = contents[index];
            contents = shift_to_left_from_index(contents, index);
            return output;
        }
    }
    //! ...
    char pop_back() {
        if (size_ == 0) {
            throw std::out_of_range("Lista está vazia");
        } else {
            char output = contents[size_];
            contents[size_] = NULL;
            return output;
        }
    }
    //! ...
    char pop_front() {
        if (size_ == 0) {
            throw std::out_of_range("Lista está vazia");
        } else {
            char output = contents[0];
            contents = shift_to_left(contents);
            return output;
        }
    }
    //! ...
    void remove(const char& data) {
        if (size_ == 0) {
            throw std::out_of_range("Lista está vazia");
        } else {
            int index = -1;
            for (int i = 0; i < size_; size_++) {
                if (contents[i] == data) {
                    contents[i] = NULL;
                    index = i;
                    break;
                }
            }
            if (index == -1) {
                throw std::out_of_range("Elemento não está na lista");
            } else {
                shift_to_left_from_index(contents, index);
            }
        }
    }
    //! ...
    bool full() const {
        return size_ == max_size_;
    }
    //! ...
    bool empty() const {
        return size_ == 0;
    }
    //! ...
    bool contains(const char& data) const {
        for (int i = 0; i < size_; i++) {
            if (contents[i] == data) {
                return true;
            }
        }
        return false;
    }
    //! ...
    std::size_t find(const char& data) const {
        for (int i = 0; i < size_; i++) {
            if (contents[i] == data) {
                return i;
            }
        }
    }
    //! ...
    std::size_t size() const {
        return size_;
    }
    //! ...
    std::size_t max_size() const {
        return max_size_;
    }
    //! ...
    char& at(std::size_t index) {
        if (index < size_) {
            return contents[index];
        } else {
            throw std::out_of_range("Índice não existe na lista");
        }
    }
    //! ...
    char& operator[](std::size_t index) {
        return contents[index];
    }
    // descricao do 'operator []' na FAQ da disciplina
    //! ...
    const char& at(std::size_t index) const {
        if (static_cast<int>(index) < size_) {
            return contents[index];
        } else {
            throw std::out_of_range("Índice não existe na lista");
        }
    }
    //! ...
    const char& operator[](std::size_t index) const {
        return contents[index];
    }

 private:
    char* contents;
    std::size_t size_;
    std::size_t max_size_;

    static const auto DEFAULT_MAX = 10u;

    char *shift_to_left(char contents[]) {
        for (int i = size_; i > 0; i--) {
            contents[i] = contents[i-1];
        }
        return contents;
    }

    char *shift_to_left_from_index(char contents[], int index) {
        for (int i = index; i < size_; i++) {
            contents[i] = contents[i+1];
        }
        return contents;
    }
};

}  // namespace structures

#endif
