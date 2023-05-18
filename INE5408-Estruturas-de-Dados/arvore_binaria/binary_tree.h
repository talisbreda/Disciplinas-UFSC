#include "array_list.h"

namespace structures {

template<typename T>
class BinaryTree {
public:
    ~BinaryTree() {
        root = nullptr;
        size_ = 0;
    }

    void insert(const T& data) {
        if (!root) {
            root = new Node(data);
        } else {
            root->insert(data);
        }
    }

    void remove(const T& data);

    bool contains(const T& data) const;

    bool empty() const;

    std::size_t size() const;

    ArrayList<T> pre_order() const;

    ArrayList<T> in_order() const;

    ArrayList<T> post_order() const;

private:
    struct Node {
        Node(const T& data):
            data{data}
        {}

        T data;
        Node* left;
        Node* right;

        void insert(const T& data_) {
            if (data_ > data) {
                if (!right) {
                    right = new Node(data);
                } else {
                    right->insert(data);
                }
            } else {
                if (!left) {
                    left = new Node(data);
                } else {
                    left->insert(data);
                }
            }
        }

        bool remove(const T& data_);

        bool contains(const T& data_) const;

        void pre_order(ArrayList<T>& v) const;

        void in_order(ArrayList<T>& v) const;

        void post_order(ArrayList<T>& v) const;
    };

    Node* travel(T& data) {

    }

    Node* root;
    std::size_t size_;
};

}