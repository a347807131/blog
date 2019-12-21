---
title: HashSet&HashMap解读
date: 2018-05-05 11:56:22
tags: 源码解读
categories: 源码解读系列 
---

## 简介

> 之所以将这两个类放一起讲，是因为两者之间存在不可忽视的依赖关系，二者的低层实现也非常的相似。我之前通过HashSet这个类名判断该集合本质是数组实现，通过源码才发现设计者有他自己的考虑。
<!--more-->

### HashSet
> HashSet实现了Set接口,它不允许集合中有重复的值，当我们提到HashSet时，第一件事情就是在将对象存储在HashSet之前，要先确保对象重写equals()和hashCode()方法，这样才能比较对象的值是否相等，以确保set中没有储存相等的对象。如果我们没有重写这两个方法，将会使用这个方法的默认实现。

![uml](https://raw.githubusercontent.com/a347807131/ms/master/collection/HashSet.png)

### HashMap
> HashMap实现了Map接口，Map接口对键值对进行映射。Map中不允许重复的键。Map接口有两个基本的实现，HashMap和TreeMap。TreeMap保存了对象的排列次序，而HashMap则不能。HashMap允许键和值为null。HashMap是非synchronized的，但collection框架提供方法能保证HashMap synchronized，这样多个线程同时访问HashMap时，能保证只有一个线程更改Map。

![uml](https://raw.githubusercontent.com/a347807131/ms/master/collection/HashMap.png)

---

## 异同

- HashMap实现了Map接口，HashSet实现了Set接口。
- HashMap储存键值对，HashSet仅仅存储对象（且无重复对象）。
- 使用put()方法将元素放入map中，使用add()方法将元素放入set中。
- HashMap中使用键对象来计算hashcode值，HashSet使用成员对象来计算hashcode值，对于两个对象来说hashcode可能相同，所以equals()方法用来判断对象的相等性，如果两个对象不同的话，那么返回false。
- HashMap比较快，因为是使用唯一的键来获取对象。

### 构造方法

```java
public HashSet() {
    map = new HashMap<>();
}

public HashMap() {
    this.loadFactor = DEFAULT_LOAD_FACTOR; // all other fields defaulted
}
```
> 可以看出HashSet本质上是一个hashMap,其底层几乎所有方法都是间接或直接使用map的实现。

### 集合元素
```java
//Set
public boolean add(E e) {
    return map.put(e, PRESENT)==null;
}
//Map
public V put(K key, V value) {
    return putVal(hash(key), key, value, false, true);
}
```
> 从源码可以看出HashSet添加元素的操作为以该元素为键值，以一个static object为值向map中元素。
  所以本质上HashSet的元素本质上是(value,object)的map实现，由也由HashMap保证了元素的唯一性与无序性。

```java
//keys为一个Set集合
transient Set<K>        keySet;
public Set<K> keySet() {
    Set<K> ks = keySet;
    if (ks == null) {
        ks = new KeySet();
        keySet = ks;
    }
    return ks;
}

final class KeySet extends AbstractSet<K> {
    public final int size()                 { return size; }
    public final void clear()               { HashMap.this.clear(); }
    public final Iterator<K> iterator()     { return new KeyIterator(); }
    public final boolean contains(Object o) { return containsKey(o); }
    public final boolean remove(Object key) {
        return removeNode(hash(key), key, null, false, true) != null;
    }
    public final Spliterator<K> spliterator() {
        return new KeySpliterator<>(HashMap.this, 0, -1, 0, 0);
    }
    /lambda表达式
    public final void forEach(Consumer<? super K> action) {
        Node<K,V>[] tab;
        if (action == null)
            throw new NullPointerException();
        if (size > 0 && (tab = table) != null) {
            int mc = modCount;
            for (Node<K,V> e : tab) {
                for (; e != null; e = e.next)
                    action.accept(e.key);
            }
            if (modCount != mc)
                throw new ConcurrentModificationException();
        }
    }
}
//values为一个集合
transient Collection<V> values;
public Collection<V> values() {
    Collection<V> vs = values;
    if (vs == null) {
        vs = new Values();
        values = vs;
    }
    return vs;
}

final class Values extends AbstractCollection<V> {
    public final int size()                 { return size; }
    public final void clear()               { HashMap.this.clear(); }
    public final Iterator<V> iterator()     { return new ValueIterator(); }
    public final boolean contains(Object o) { return containsValue(o); }
    public final Spliterator<V> spliterator() {
        return new ValueSpliterator<>(HashMap.this, 0, -1, 0, 0);
    }
    public final void forEach(Consumer<? super V> action) {
        Node<K,V>[] tab;
        if (action == null)
            throw new NullPointerException();
        if (size > 0 && (tab = table) != null) {
            int mc = modCount;
            for (Node<K,V> e : tab) {
                for (; e != null; e = e.next)
                    action.accept(e.value);
            }
            if (modCount != mc)
                throw new ConcurrentModificationException();
        }
    }
}
```
> 从HashMap的源码上可以看出，map底层本质就是两个集合，通过映射关系以确定键值关系，
  其中key为set集合，以实现map元素的无序性。
  
问题：如何保证键值之间的映射关系？
答：Node<K,V>,map维护着Node<K,V>[]，而Node<K,V>则维护着K,V的关系。
```java
static class Node<K,V> implements Map.Entry<K,V> {
    final int hash;
    final K key;
    V value;
    Node<K,V> next;

    Node(int hash, K key, V value, Node<K,V> next) {
        this.hash = hash;
        this.key = key;
        this.value = value;
        this.next = next;
    }

    public final K getKey()        { return key; }
    public final V getValue()      { return value; }
    public final String toString() { return key + "=" + value; }

    public final int hashCode() {
        return Objects.hashCode(key) ^ Objects.hashCode(value);
    }


    public final V setValue(V newValue) {
        V oldValue = value;
        value = newValue;
        return oldValue;
    }

    public final boolean equals(Object o) {
        if (o == this)
            return true;
        if (o instanceof Map.Entry) {
            Map.Entry<?,?> e = (Map.Entry<?,?>)o;
            if (Objects.equals(key, e.getKey()) &&
                Objects.equals(value, e.getValue()))
                return true;
        }
        return false;
    }
}
```