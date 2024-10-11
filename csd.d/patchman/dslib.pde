class Snode<T> {
  volatile T d;
  volatile Snode<T> nxt;

  Snode(T _d) {
    d=_d;
    nxt=null;
  }

  String toString() {
    return d.toString();
  }
}

class Slist<T> {
  Snode<T> head, tail;
  int size, limit;

  void clr() {
    while (size>0) {
      dq();
    }
  }

  int size() {
    return size;
  }

  void setlimit(int lim) {
    limit=lim;
  }

  Slist(int lim) {
    head=tail=null;
    limit=lim;
    size=0;
  }

  void nq(T z) {
    Snode<T> tmp=new Snode<>(z);
    if (head==null) {
      head=tail=tmp;
    } else {
      tail.nxt=tmp;
      tail=tail.nxt;
    }
    size+=1;
    while (size>limit) {
      dq();
    }
  }

  T dq() {
    if (size>0) {
      Snode<T> old=head;
      head=head.nxt;
      T dat=old.d;
      old.nxt=null;
      old=null;
      size-=1;
      return dat;
    }
    return null;
  }

  void display() {
    for (Snode i=head; i!=null; i=i.nxt) {
      println(i);
    }
  }
}
