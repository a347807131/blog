---
title: 源码解读——Exception&RuntimeException
tags: `源码解读`
---

## 简介
本次解读`Exception`与`RunTimeException`的源码，以及在流程控制中的使用细节。

### 类图
- `Exception`——受检查异常
![Exception](https://raw.githubusercontent.com/a347807131/blog/master/ms/uml/Exception.png)
- `RunTimeException`——不受检查异常
![Exception](https://raw.githubusercontent.com/a347807131/blog/master/ms/uml/RunTimeException.png)


### 方法
```java
public class Exception extends Throwable {

    static final long serialVersionUID = -3387516993124229948L;

    public Exception() {
        super();
    }

    public Exception(String message) {
        super(message);
    }

    public Exception(String message, Throwable cause) {
        super(message, cause);
    }

    public Exception(Throwable cause) {
        super(cause);
    }

    protected Exception(String message, Throwable cause,
                        boolean enableSuppression,
                        boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
```
解读：其实就是Threable的实现，一个字符都没有变化。