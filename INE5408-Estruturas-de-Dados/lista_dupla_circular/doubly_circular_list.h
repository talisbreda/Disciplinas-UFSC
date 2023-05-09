namespace structures {

template<typename T>
class DoublyCircularList {
 public:
    DoublyCircularList() {
         head = nullptr;
         size_ = 0;
    }
    ~DoublyCircularList() {
         clear();
    }

    void clear() {
         while (!empty()) {
             pop_front();
         }
    }

    void push_back(const T& data) {
         if (empty()) {
             head = new Node(data);
             head->next(head);
             head->prev(head);
         } else {
             Node* novo = new Node(data, head->prev(), head);
             head->prev()->next(novo);
             head->prev(novo);
         }
         size_++;
    }  // insere no fim
    void push_front(const T& data) {
         if (empty()) {
             head = new Node(data);
             head->next(head);
             head->prev(head);
         } else {
             Node* novo = new Node(data, head->prev(), head);
             head->prev()->next(novo);
             head->prev(novo);
             head = novo;
         }
         size_++;
    }  // insere no início
    void insert(const T& data, std::size_t index) {
         if (index > size_) {
             throw std::out_of_range("Posição inválida");
         } else if (index == 0) {
             push_front(data);
         } else if (index == size_) {
             push_back(data);
         } else {
             Node* anterior = head;
             for (int i = 0; i < index - 1; i++) {
                 anterior = anterior->next();
             }
             Node* novo = new Node(data, anterior, anterior->next());
             anterior->next()->prev(novo);
             anterior->next(novo);
             size_++;
         }
    }  // insere na posição
    void insert_sorted(const T& data) {
         if (empty()) {
             push_front(data);
         } else {
             Node* atual = head;
             int index = 0;
             while (atual->data() < data && index < size_) {
                 atual = atual->next();
                 index++;
             }
             insert(data, index);
         }
    }  // insere em ordem

    T pop(std::size_t index) {
         if (empty()) {
             throw std::out_of_range("Lista vazia");
         } else if (index >= size_) {
             throw std::out_of_range("Posição inválida");
         } else if (index == 0) {
             return pop_front();
         } else if (index == size_ - 1) {
             return pop_back();
         } else {
             Node* anterior = head;
             for (int i = 0; i < index - 1; i++) {
                 anterior = anterior->next();
             }
             Node* saiu = anterior->next();
             T volta = saiu->data();
             anterior->next(saiu->next());
             saiu->next()->prev(anterior);
             size_--;
             delete saiu;
             return volta;
         }
    }  // retira da posição
    T pop_back() {
         if (empty()) {
             throw std::out_of_range("Lista vazia");
         } else if (size_ == 1) {
             T volta = head->data();
             delete head;
             head = nullptr;
             size_--;
             return volta;
         } else {
             Node* saiu = head->prev();
             T volta = saiu->data();
             head->prev(saiu->prev());
             saiu->prev()->next(head);
             size_--;
             delete saiu;
             return volta;
         }
    }  // retira do fim
    T pop_front() {
         if (empty()) {
             throw std::out_of_range("Lista vazia");
         } else if (size_ == 1) {
             T volta = head->data();
             delete head;
             head = nullptr;
             size_--;
             return volta;
         } else {
             Node* saiu = head;
             T volta = saiu->data();
             head->prev()->next(head->next());
             head->next()->prev(head->prev());
             head = head->next();
             size_--;
             delete saiu;
             return volta;
         }
    }  // retira do início
    void remove(const T& data) {
         if (empty()) {
             throw std::out_of_range("Lista vazia");
         } else if (head->data() == data) {
             pop_front();
         } else {
             Node* anterior = head;
             while (anterior->next()->data() != data && anterior->next() != head) {
                 anterior = anterior->next();
             }
             if (anterior->next() == head) {
                 throw std::out_of_range("Dado não encontrado");
             } else {
                 Node* saiu = anterior->next();
                 anterior->next(saiu->next());
                 saiu->next()->prev(anterior);
                 size_--;
                 delete saiu;
             }
         }
    }  // retira específico

    bool empty() const {
         return size_ == 0;
    }  // lista vazia
    bool contains(const T& data) const {
         if (empty()) {
             throw std::out_of_range("Lista vazia");
         } else {
             Node* atual = head;
             for (int i = 0; i < size_; i++) {
                 if (atual->data() == data) {
                     return true;
                 }
                 atual = atual->next();
             }
             return false;
         }
    }  // contém

    T& at(std::size_t index) {
         if (empty()) {
             throw std::out_of_range("Lista vazia");
         } else if (index >= size_) {
             throw std::out_of_range("Posição inválida");
         } else if (index == 0) {
             return head->data();
         } else {
             Node* atual = head;
             for (int i = 0; i < index; i++) {
                 atual = atual->next();
             }
             return atual->data();
         }
    }  // acesso a um elemento (checando limites)
    const T& at(std::size_t index) const {
         if (empty()) {
             throw std::out_of_range("Lista vazia");
         } else if (index >= size_) {
             throw std::out_of_range("Posição inválida");
         } else if (index == 0) {
             return head->data();
         } else {
             Node* atual = head;
             for (int i = 0; i < index; i++) {
                 atual = atual->next();
             }
             return atual->data();
         }
    }  // getter constante a um elemento

    std::size_t find(const T& data) const {
         if (empty()) {
             throw std::out_of_range("Lista vazia");
         } else {
             Node* atual = head;
             for (int i = 0; i < size_; i++) {
                 if (atual->data() == data) {
                     return i;
                 }
                 atual = atual->next();
             }
             return size_;
         }
    }  // posição de um dado
    std::size_t size() const {
         return size_;
    }  // tamanho

 private:
    class Node {
     public:
        explicit Node(const T& data):
            data_{data}
        {}
        Node(const T& data, Node* next):
            data_{data},
            next_{next}
        {}
        Node(const T& data, Node* prev, Node* next):
            data_{data},
            prev_{prev},
            next_{next}
        {}

        T& data() {
            return data_;
        }
        const T& data() const {
            return data_;
        }

        Node* prev() {
            return prev_;
        }
        const Node* prev() const {
            return prev_;
        }

        void prev(Node* node) {
            prev_ = node;
        }

        Node* next() {
            return next_;
        }
        const Node* next() const {
            return next_;
        }

        void next(Node* node) {
            next_ = node;
        }

     private:
        T data_;
        Node* prev_;
        Node* next_;
    };

    Node* head;
    std::size_t size_;
};

}