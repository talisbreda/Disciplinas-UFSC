#include "array_list.h"

namespace structures {

template<typename T>
class BinaryTree {
public:
    ~BinaryTree() {
        size_ = 0;
        root = nullptr;
    }

    void insert(const T& data) {
        if (empty()) {
            root = new Node(data);
        } else {
            root->insert(data);
        }
        size++;
    }

    void remove(const T& data) {
        if (empty()) {
            throw std::out_of_range("Árvore vazia")
        } else {
            root->remove(data);
            size--;
        }
    }

    bool contains(const T& data) const;

    bool empty() const {
        return size_ == 0;
    }

    std::size_t size() const {
        return size;
    }

    ArrayList<T> pre_order() const;

    ArrayList<T> in_order() const;

    ArrayList<T> post_order() const;

private:
    struct Node {
        explicit Node(const T& data):
            this->data{data},
            left{nullptr},
            right{nullptr}
        {}

        T data;
        Node* left;
        Node* right;

        void insert(const T& data_) {
            if (data_ > this->data) {
                if (this->right == nullptr) {
                    this->final_insert(data_);
                } else {
                    this->right->insert(data_);
                }
            } else {
                if (this->left == nullptr) {
                    this->final_insert(data_);
                } else {
                    this->left->insert(data_);
                }
            }
        }

        void final_insert(const T& data_) {
            Node* newNode = new Node(data_);
            if (data_ > this->data) {
                this->right = newNode;
            } else {
                this->left = newNode;
            }
        }

        bool remove(const T& data_) {
            if (data_ == this->right->data) {
                this->right->remove_right(data, this);
            } else if (data_ == this->left->data) {
                this->left->remove_left(data, this);
            } else if (data_ > this->data) {
                this->right->remove(data_);
            } else if (data_ < this->data) {
                this->left->remove(data_);
            } else if (data_ == this->data) {
                if (this->left == nullptr && this->right == nullptr) {
                    delete this;
                } else {
                    remove_2_3();
                }
            }
        }

        void remove_right(const T& data_, Node* pai) {
            if (this->left == nullptr && this->right == nullptr) {
                remove_case_1_right(pai);
            } else {
                if (this->left != nullptr && this->right != nullptr) {
                    remove_case_3();
                } else {
                    remove_case_2_right(pai);
                }
            }
        }

        void remove_left(const T& data_, Node* pai) {
            if (this->left == nullptr && this->right == nullptr) {
                remove_case_1_left(pai);
            } else {
                if (this->left != nullptr && this->right != nullptr) {
                    remove_case_3();
                } else {
                    remove_case_2_left(pai);
                }
            }
        }

        void remove_case_1_left(Node* pai) {
            pai->left = nullptr;
            delete this;
        }

        void remove_case_1_right(Node* pai) {
            pai->right = nullptr;
            delete this;
        }

        void remove_case_2_right(Node* pai) {
            if (this->left != nullptr) {
                pai->right = this->left;
            } else {
                pai->right = this->right;
            }
        }

        void remove_case_2_left(Node* pai) {
            if (this->left != nullptr) {
                pai->left = this->left;
            } else {
                pai->left = this->right;
            }
        }

        void remove_case_3() {
            Node* min = minimum(this->right);
            this->data = min->data;
            min->remove(this->data);
        }

        bool contains(const T& data_) const;

        void pre_order(ArrayList<T>& v) const;

        void in_order(ArrayList<T>& v) const;

        void post_order(ArrayList<T>& v) const;
    };

    Node* root;
    std::size_t size_;

    Node* find(const T& data) {
        Node* aux = root;
        while (aux->data != data || aux != nullptr) {
            if (data > aux->data) {
                aux = aux->right;
            } else {
                aux = aux->left;
            }
        }
        return aux;
    }

    Node* minimum(Node* sub) {
        while (sub->left != nullptr) {
            sub = sub->left;
        }
        return sub;
    }
};

}