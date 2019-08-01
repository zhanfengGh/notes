## Overview {#header}
Nearly all Markdown applications support the basic syntax outlined in John Gruber’s original design document. There are minor variations and discrepancies between Markdown processors — those are noted inline wherever possible.

<!-- 
    这里是注释。
 -->

## Headings
使用#来创建标题
1. # Header 1
1. ## Header 2
1. ### Header 3
1. #### Header 4

## 粗体 or 斜体
- *斜体*
- **粗体**

## 有序列表和无序列表
有序列表使用数字加上点创建，无序列表使用-创建.

- 无序列表
    - 子列表
    - 子列表
- 无序列表
    1. 有序列表
        1. 有序子列表
        1. 有序子列表
    1. 有序列表
- 无序列表

- This is the first list item.
- Here's the second list item.

    > I need to add another paragraph below the second list item.

* And here's the third list item.


## 块引用（Blockquotes）
块引用使用>创建
> 这里是块信息。

> 这里是一个很***长长*长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长**的块信息。

> 这里是一个块信息，会和下面的的块信息合并。
> 
>> 这里是另一个块信息
>
>>> 第三层嵌套
> 
>> just for test
>
> just for test.

## 代码块
代码块使用`Object o = new Object();`创建，多行使用```创建。
```java
class HelloWorld {
    public static void main(String...  args) {
        String s = "Hello World";
        System.out.println(s);
    }
}
```
## 链接 {#links}
- ### 外连接
<https://daringfireball.net/projects/markdown/syntax>
[Daring Fireball](https://daringfireball.net/projects/markdown/syntax)
[Daring FireBall][daring-fireball]
- ### 文档内连接
    - [链接](#links)
    - [UP](#header)


## 图片
![just for test](https://markdown.tw/images/208x128.png)








## 引用区
保存本文中用到的引用。

[daring-fireball]: https://daringfireball.net/projects/markdown/syntax "Daring Fireball title"
