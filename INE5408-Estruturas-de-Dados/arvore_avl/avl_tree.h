// Copyright 2023 Talis Breda
#include "array_list.h"


namespace structures {

template<typename TrieNode>
class AVLTree {
public:
    ~AVLTree() {
        root = nullptr;
        size_ = 0;
    }

    void insert(const TrieNode& data) {
        if (empty()) {
            root = new Node(data);
        } else {
            root->insert(data);
        }
        size_++;
    }

    void remove(const TrieNode& data) {
        if (empty()) {
            throw std::out_of_range("Árvore vazia");
        } else {
            root->remove(data);
            size_--;
        }
    }

    bool contains(const TrieNode& data) const {
        if (empty()) {
            throw std::out_of_range("Árvore vazia");
        } else {
            return root->contains(data);
        }
    }

    bool empty() const {
        return size_ == 0;
    }

    std::size_t size() const {
        return size_;
    }

    int height() const {
        return root->height();
    }

    ArrayList<TrieNode> pre_order() const {
        ArrayList<TrieNode> list = ArrayList<TrieNode>(size_);
        root->pre_order(list);
        return list;
    }

    ArrayList<TrieNode> in_order() const {
        ArrayList<TrieNode> list = ArrayList<TrieNode>(size_);
        root->in_order(list);
        return list;
    }

    ArrayList<TrieNode> post_order() const {
        ArrayList<TrieNode> list = ArrayList<TrieNode>(size_);
        root->post_order(list);
        return list;
    }

private:
    struct Node {
        explicit Node(const TrieNode& data) {
            this->data = data;
            this->height_ = -1;
            this->left = nullptr;
            this->right = nullptr;
        }

        TrieNode data;
        int height_;
        Node* left;
        Node* right;

        void insert(const TrieNode& data_) {
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
            this->checkHeightDiff(data_);
            this->updateHeight();
        }

        void final_insert(const TrieNode& data_) {
            Node* newNode = new Node(data_);
            if (data_ > this->data) {
                this->right = newNode;
            } else {
                this->left = newNode;
            }
        }

        void checkHeightDiff(const TrieNode& data) {
            int right_h = this->right != nullptr ? this->right->height() : 0;
            int left_h = this->left != nullptr ? this->left->height() : 0;
            int height_diff = abs(right_h - left_h);
            if (height_diff > 1) {
                this->rotate(data);
            }
        }

        void rotate(const TrieNode& data) {
            if (data > this->data) {
                if (data < this->right->data) {
                    this->doubleRight();
                } else {
                    this->simpleRight();
                }
            } else {
                if (data > this->left->data) {
                    this->doubleLeft();
                } else {
                    this->simpleLeft();
                }
            }
        }

        void remove(const TrieNode& data_) {
            bool rightNull = this->right == nullptr;
            bool leftNull = this->left == nullptr;

            if (!rightNull && data_ == this->right->data) {
                this->right->remove_right(data_, this);
            } else if (!leftNull && data_ == this->left->data) {
                this->left->remove_left(data_, this);
            } else if (!rightNull && data_ > this->data) {
                this->right->remove(data_);
            } else if (!leftNull && data_ < this->data) {
                this->left->remove(data_);
            }

            this->checkZigZag(data_);
            this->updateHeight();
        }

        void checkZigZag(const TrieNode& data) {
            int right_h = this->right != nullptr ? this->right->height() : -1;
            int left_h = this->left != nullptr ? this->left->height() : -1;
            int height_diff = abs(right_h - left_h);
            if (height_diff > 1) {
                if (right_h > left_h) {
                    if (this->right != nullptr && data > this->right->data) {
                        this->simpleRight();
                    } else {
                        this->doubleRight();
                    }
                } else {
                    if (this->left != nullptr && data < this->left->data) {
                        this->simpleLeft();
                    } else {
                        this->doubleLeft();
                    }
                }
            }
        }

        void remove_right(const TrieNode& data_, Node* pai) {
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

        void remove_left(const TrieNode& data_, Node* pai) {
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

        bool contains(const TrieNode& data_) const {
            if (data_ == this->data)  {
                return true;
            } else if (this->right != nullptr && data_ > this->data) {
                return this->right->contains(data_);
            } else if (this->left != nullptr && data_ < this->data) {
                return this->left->contains(data_);
            } else {
                return false;
            }
        }

        void updateHeight() {
            if (this->left == nullptr && this->right == nullptr) {
                this->height_ = -1;
            } else if (this->left == nullptr) {
                this->height_ = this->right->height()+1;
            } else if (this->right == nullptr) {
                this->height_ = this->left->height()+1;
            } else {
                this->height_ = std::max(
                    this->left->height(),
                    this->right->height())
                    +1;
            }
        }

        Node* simpleLeft() {
            Node* leftChild = this->left;
            TrieNode thisData = this->data;

            this->data = this->left->data;
            leftChild->data = thisData;

            this->left = leftChild->left;
            leftChild->left = leftChild->right;
            leftChild->right = this->right;
            this->right = leftChild;
            return this;
        }

        Node* simpleRight() {
            Node* rightChild = this->right;
            TrieNode thisData = this->data;

            this->data = this->right->data;
            rightChild->data = thisData;

            this->right = rightChild->right;
            rightChild->right = rightChild->left;
            rightChild->left = this->left;
            this->left = rightChild;
            return this;
        }

        Node* doubleLeft() {
            this->simpleLeft();
            return this;
        }

        Node* doubleRight() {
            this->simpleRight();
            return this;
        }

        void pre_order(ArrayList<TrieNode>& v) const {
            v.push_back(this->data);
            if (this->left != nullptr) {
                this->left->pre_order(v);
            }
            if (this->right != nullptr) {
                this->right->pre_order(v);
            }
        }

        void in_order(ArrayList<TrieNode>& v) const {
            if (this->left != nullptr) {
                this->left->in_order(v);
            }
            v.push_back(this->data);
            if (this->right != nullptr) {
                this->right->in_order(v);
            }
        }

        void post_order(ArrayList<TrieNode>& v) const {
            if (this->left != nullptr) {
                this->left->post_order(v);
            }
            if (this->right != nullptr) {
                this->right->post_order(v);
            }
            v.push_back(this->data);
        }

        int height() {
            return height_;
        }
    };

    Node* root;
    std::size_t size_;

    static Node* minimum(Node* sub) {
        while (sub->left != nullptr) {
            sub = sub->left;
        }
        return sub;
    }
};

}  // namespace structures

// -----

