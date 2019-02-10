package com.vaidhyamegha;

import java.util.Iterator;
import java.util.NoSuchElementException;

class Queue<T> implements Iterable<T> {
    private Node<T> first;  
    private Node<T> last;    

    private static class Node<Q> {
        private Q q;
        private Node<Q> next;
    }

    Queue() {
        first = null;
        last = null;
    }

    void enqueue(T t) {
        Node<T> oldLast = last;
        last = new Node<>();
        last.q = t;
        last.next = null;
        if (first == null) first = last;
        else oldLast.next = last;
    }

    public Iterator<T> iterator() {
        return new ListIterator<>(first);
    }

    private class ListIterator<R> implements Iterator<R> {
        private Node<R> current;

        public ListIterator(Node<R> first) { current = first; }

        public boolean hasNext() { return current != null; }

        public void remove() { throw new UnsupportedOperationException(); }

        public R next() {
            if (!hasNext()) throw new NoSuchElementException();
            R r = current.q;
            current = current.next;
            return r;
        }
    }

}
