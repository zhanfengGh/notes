## 笔记的记录

1. 笔记很重要
1. 每天记笔记
1. 晚上下班前总结笔记
1. 第二天上班前复习笔记
1. 每周最后一天总结当周笔记
1. 把每周的笔记分类归档

## 个人特点

1. 创造性资深研发；有实力，肯钻研；有激情，肯实干；
2. 知其然并知其所以然
3. **最**求工作效率
4. 追求极致（架构无小事）
5. UML 类图/活动图/状态图/架构图
6. 熟练git /awk语言 生成sql语句（快）
7. linux 理论知识/常用命令/网络/虚拟化/IO调优等

## TODO

1. 源码阅读
   1. ThreadLocal
   1. ThreadPoolExecutor
   1. ConcurrentHashMap
   1. HashMap (树) 不需要细节
1. 学习spring security时梳理http的安全认证
1. spring cache redis 实现
1. spring mvc mock
1. 会员idhbase分区设计
1. 打印二叉树算法
1. 日志框架梳理，如何实时更新日志级别 目标快速使用
1. 单元测试覆盖开发配置
1. mybatis 源码解读
1. spring-mybatis/spring-redis
1. spring事务
1. ~~ssh 隧道代理~~
1. ~~java 日期操作~~ java8 
1. ssh 免密登陆原理
1. ssh-add/ssh-agent
1. ~~vi 复制/粘贴~~
1. Linux commands curl 细节填充
1. ~~ThreadLocal~~
1. Lock
1. ~~cas/volatile（long/double）~~
1. r/w Lock
1. ~~ThreadPool 细节，站在巨人的肩膀上（参考别人的资料）~~
1. ~~ScheduledThreadPool~~
1. 网络/netty 线程模型
1. JVM 调优常用工具 jps/jinfo/jstat/jmap/stack
1. ~~制作知识梳理图~~
1. shadowsockets 高级用法
1. http 认证
1. markdown 文档编写逐步转移到nvim中（全部放弃鼠标）
1. ~~fzf 用法学习，提高效率~~
1. VM install nvim and config
1. Elasticsearch Cluster in Docker
1. Logstash 多pipeline
1. Elasticsearch monitor/Kibana monitor/Logstash monitor
1. gitlab -> jiro -> fisheye -jira
1. 数据库事务/Spring的事务
1. gradle 快速入门
1. rxjava
1. lambda 类/实例方法
1. 日志动态开关
1. spring config
1. ftp/smb 服务器
1. vpn服务器
1. 汉语舌前舌后音如何区分
1. JDK ConcurrentMap-based Cache 实现
1. spring cache redis 实现
1. ~~Queue FIFO实现：链表/循环数组~~
1. ~~Queue 优先队列实现~~
1. ~~Queue 类图梳理~~
1. SynchronousQueue
1. ~~循环分页~~
1. ~~Idea 如何跳转到单元测试~~
1. 封装自己的常用类
1. 2019-07-22 Java 堆实现中的范型实现 Comparable/Comparator
1. kafka
1. redis
1. es
1. netty
1. ArrayList/LinkedList/HashMap/ConcurrentHashMap -> Java Collections Framework
1. ~~Jvm.xmind~~
1. ~~类加载/类初始化/对象初始化~~
1. 复习algorithm java 实现代码 
1. ~~计算对象的占用内存的大小~~
1. ~~finally return~~
1. ~~复习learn-basic final 用法~~
1. 1.8 Map/Map.Entry 新添加的default/static 方法



## 2019-08-01

## maven not authorized

1. Check the servers section in the settings.xml file.Is username and password correct?

```html
<servers>
  <server>
    <id>serverId</id>
    <username>username</username>
    <password>password</password>
  </server>
</servers>
```

1. Check the repository section in the pom.xml file.**The id of the server tag should be the same as the id of the repository tag.**

```html
<repositories>
	<repository>
	  <id>serverId</id>  
	  <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
	</repository>
</repositories>
```

1. If the repository tag is not configured in the pom.xml file, look in the settings.xml file.

```html
<profiles>
	<profile>
	  <repositories>
	    <repository>
		    <id>serverId</id>
		    <name>aliyun</name>
		    <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
	    </repository>
	  </repositories>
	</profile>
</profiles>
```

Note that you should ensure that **the id of the server tag should be the same as the id of the repository tag.**



## 2019-07-30

### 排序数组删除重复元素

```c++
// 数组下标0开始
// A.length 数组的capacity
// A.size 数组的元素的个数

// Invariant:A[0..i] 是排序的并且互不重复的元素
ARRAY-DELETE-DUPLICATE-BETTER(A)
  for i=0,j=1 upto A.size-1
    if A[j]!=A[i]
    	swap(A, ++j, i)
    
ARRAY-DELETE-DUPLICATE(A)
	for i=A.size-1 downto 0
		for j=i-1 downto 0
			if A[j]==A[i]
			else break
		if j=i-1
			continue
		else
			// 删除duplicate
			for m=i,n=j+1 upto A.size-1
				A[n++]=A[m];				
```



## 2019-07-29

### 数据库设计优化

指定会员卡类型可以按月数来分`1-月卡；3-季卡；12-年卡`

字段的值域尽量排除null： 

```sql
`gender` CHAR(1) NOT NULL DEFAULT '' COMMENT 'F-female；M-male；空字符-未定义' 
```

### Java finally

see [FinallyTest.java](https://github.com/zhanfengGh/comfenglearn/blob/master/learn-basic/src/test/java/com/feng/learn/basic/FinallyTest.java)

```java
try {
	// do something
  return 0;
} catch (Exception e) {
	// do another thing
  return -1;
} finally {
	// do finally thing
  return 1;
}
// 方法肯定return 1
```

1. try 无异常 -> finally
1. try 有异常 -> catch -> finally
1. finally 有return，以finally return为主

### Java final

1. final class -> 类不能被继承

1. final method -> 方法不能被重写

   > final 用于修饰static method `static final a()` 表示a方法不能被子类重写（隐藏）

1. final field / final static field -> 初始化后不能被重新赋值

   > 基本类型/String 在声明时直接赋值且编译时能确定值，会被编译器优化掉，直接变成常量
   >
   > final field / final static field / final local variable 都会被编译器执行宏替换

## 2019-07-26

1. 复习25号笔记
1. 

## 2019-07-25

1. 复习及整理算法

### 栈

1. 可以用数组实现有界栈

   > S.top==0表示空栈；S.top==array.length表示满栈

1. 可以用带哨兵的单向链表实现无界栈

   > S.top指向哨兵；S.top.next==NIL表示空栈

```c++
// 数据下标以0开始
ARRAY-PUSH(S, x)
	if S.top=array.length
		error
	S[top++]=x
ARRAY-POP(S)
	if S.top==0
		error
	return S[--top]
	
LINKEDLIST-PUSH(S, x)
	S.top.next=node(x, S.top.next)
LINKEDLIST-POP(S, x)
	if S.top.next==NIL
		error
	x=S.top.next.key
	S.top.next=S.top.next.next
	return x
```

### 循环数组有界队列 

#### tail/head/size

1. Q.size/Q.capacity/
1. Q.tail/Q.head 初始化0

```c++
// 数组下边以0开始
ENQUEUE(Q, x)
	if size==capacity
		error
	Q[tail++]=x
	tail=tail==capacity?0:tail
	size+=1
    
DEQUEUE(Q)
  if size==0
    error
  x=Q[head++]
  head=head==capacity?0:head
  size-=1
```

#### tail/head

1. Q.capacity
1. Q.tail/Q.head 初始化0
1. 以牺牲一个存储空间为代价
   1. empty: head==tail
   1. full: (tail+1)%capacity=head

```
ENQUEUE(Q, x)
	if (tail+1)%capacity=head
		error
	else
		Q[tail++]=x
		tail=tail==capacity?0:tail
		
DEQUEUE(Q)
	if head==tail
		error
	x=Q[head++]
	head=head==capacity?0:head
	return x
```



### 顺序统计量

n个元素构成的集合中第i个顺序统计量（order statistic）是该集合中第i个小的元素。

分析算法的循环不变式可得出哪些算法可以用来计算顺序统计量。

选择排序：A[0..i) 是A中最小的i个数，且A[0]≤A[1]≤A[2]≤..≤A[i-1]；A[i..n)排序未知

插入排序：A[0..i) 是有序的；A[i..n)排序未知

堆排序：A[n-1-i,n-1] 是A中最大的i个元素，且A[n-1-i]..≤A[n-1-2]≤A[n-1-1]≤A[n-1]

选择排序/堆排序可用于计算顺序统计量；插入排序不能。

#### 最大值

```c++
MAXIMUM(A)
	max=A[0]
	for i=1 upto A.length-1
		if A[i]>max
			max=A[i]
	return max
```

#### 同时寻找最大值和最小值

比较次数: n*2

```c++
MAXIMUM-MINIMUM(A)
	max=min=A[0]
	for i=1 upto A.length-1
		if A[i]<min
			min=A[i]
		else if A[i]>max
			max=A[i]
	return (max, min)
```

##### 优化版本

比较次数：3n/2

```c++
MAXIMUM-MINIMUM(A)
	if A.length%2==0
		max=min=A[0]
		startIdx=1
	else
		if A[0]<A[1]
			min=A[0], max=A[1]
		startIdx=2
	for i=startIdx upto A.length-2
		if A[i]<A[i+1]
			mi=A[i], ma=A[i+1]
		else
			mi=A[i+1], ma=A[i]
		if mi<min
			min=mi
		if ma>max
			max=ma
		i+=2		
```

#### 基于快排的随机选择算法

快速排序分区后，pivotIdx左边的值都比pivot小；右边的值都比pivot大。若`pivotIdx==i`则pivot就是集合的第i顺序统计量。

```c++
RANDOMIZED-SELECT(A, l, r, k)
	pivotIdx=PARTITION(A, l, r)
	if k==pivotIdx
		return A[pivotIdx]
	else k<pivotIdx
		return RANDOMIZED-SELECT(A, l, pivotIdx-1, k)
	else return RANDOMIZED-SELECT(A, pirvotIdx+1, r, k-(pivotIdx+1))

//Invariant: A[l..j]<A[r]
PARTITION(A, l, r)
  pivot=A[r]; j=l-1
  for i=l upto r-1
    if A[i]<pivot
    	swap(A, i, ++j)
  swap(A, ++j, r)
  return j
```

### 计数排序

待排序的数组的值域在[m-n]，这里假设[0-k）

```c++
// 数组下标以0开始
COUNTING-SORT(A, B, k)
	let C[k]=new array[k] // C[k]临时数据并且初始化0
	for i=0 upto A.length-1
		C[A[j]]+=1
	for i=1 upto C.length-1
		C[i]+=C[i-1]
	for i=A.length-1 downto 0	// 此次循环可以是反序遍历也可以是正序遍历
		B[C[A[j]]]=A[j]
		C[A[j]]-=1
```

> 此次循环可以是反序遍历也可以是正序遍历
>
> 反序遍历可以保证**稳定排序**；正序遍历无法保证

### 基数排序

数字特征：每位都是[0-9]10个数组组成。

```c++
RADIX-SORT(A, d) // d是数组中最大数的位数
	for i=1 upto d
		use a stable sort to sort array A on digit i
```

> stable sort: 计数排序/插入排序/选择排序等

## 2019-07-24

1. 复习`BlockingQueue`的几种实现
2. 复习及整理算法

### 选择排序

Invariant: A[0..i-1] 是A[0..n]中的最小i-1个数，且A[0]≤A[1]≤..≤A[i-1]

```c++
// 下标以0开始
SELECT-SORT(A)
	for i=0 upto A.length-1
		int minIdx=i
		for j=i upto A.length-1
			if A[j]<A[minIdx]
				minIdx=j
		swap(A, i, minIdx)			
```

#### 冒泡排序

```c++
BUBBLE-SORT(A)
	for i=0 upto A.length-1
		for j=A.length-1 downto i+1
			if A[j]<A[j-1]
				swap(A, j, j-1)
```



### 快速排序

```c++
// 下标以0开始
QUICK-SORT(A, i, j)
	if i<j
		pivotIdx=PARTITION-SORT(A, i, j)
		QUICK-SORT(A, i, pivotIdx-1)
		QUICK-SORT(A, pivotIdx+1, j)

// 循环不变式：j左边的数<pivot
// A[left..j]<A[right]
PARTITION-SORT(A, left, right)
	i=left, j=left-1
	pivot=A[right]
	while i<right
		if A[i]<pivot
			swap(A, i, ++j)
    i+=1
  swap(A, ++j, right)
  return j
```

### 插入排序

```c++
// 下标以0开始
INSERT-SORT(A)
  for i=1 upto A.length-1
   	key=A[i]
   	j=i-1
    while j>=0 and A[j]>key
    	A[j+1]=A[j]
    	j-=1
    //A[j]=key
    A[j+1]=keys
```

### 归并算法

```c++
// 下标以0开始
MERGE-SORT(A, i, j)
	if i<j
		int m=(i+j)/2
		MERGE-SORT(A, i, m)
		MERGE-SORT(A, m+1, j)
		MERGE(A, i, m, j)
		
MERGE(A, start, mid, end)
	let B=new array[end-start+1]
	int i=start, j=mid+1, k=0
	while k<B.length
		if A[i]<=A[j]
			B[k++]=A[i++]
		else B[k++]=A[j++]
	for i=0 upto B.length
		A[start++]=B[i++]
```



### Thread interrupt 线程中断

**首先讲 interrupt() 方法：**

1. interrupt 中断操作时，非自身打断需要先检测是否有中断权限，这由jvm的安全机制配置
1. 如果线程处于**sleep, wait, join** 等状态，那么线程将立即退出被阻塞状态，并抛出一个InterruptedException异常
1. 如果线程处于I/O阻塞状态，将会抛出ClosedByInterruptException（IOException的子类）异常
1. 如果线程在Selector上被阻塞，select方法将立即返回
1. 如果非以上情况，将直接标记 interrupt 状态

> 注意：interrupt 操作不会打断所有阻塞，只有上述阻塞情况才在jvm的打断范围内，如处于**锁阻塞**的线程，不会受 interrupt 中断；

## 2019-07-23

### ExecutorService 线程池的关闭

1. new tasks will be accepted ?
1. previously submitted tasks will be executed ?
1. actively executing tasks will be terminated ?

#### shutdown

`void shutdown();` 发起关闭请求后立即返回。

不再接受新提交的任务（具体由RejectHandler处理）。

正在执行的任务和BlockingQueue中的任务依旧会被执行，所有任务执行完成后，关闭线程池

#### shutdownNow

`List<Runnable> shutdownNow();`发起关闭请求后立即返回。

不再接受新提交的任务（具体由RejectHandler处理）。

BlockingQueue中的任务会被返回`List<Runnable>`

正在执行中的任务的线程会收到中断信号。若正在执行任务响应中断，线程可能会接受；若不响应中断，则正在执行中的任务永远都不会结束，**也就意味着线程池永远都不会关闭。**

There are no guarantees beyond best-effort attempts to stop processing actively executing tasks. For example, typical implementations will cancel via **Thread.interrupt**, so any task that fails to respond to interrupts may never terminate.

#### awaitTermination

`boolean awaitTermination(long timeout, TimeUnit unit) throws InterruptedException;`

#### isShutdown

#### isTerminated





### Heap 数据结构

heap数据结构可用于堆排序/优先队列/多路归并

#### 优先队列

see [MaxPriorityQueueInteger.java](https://github.com/zhanfengGh/algorithm/blob/master/java/src/main/java/select/sort/heap/MaxPriorityQueueInteger.java)

1. 以数组实现，下标以1开始
1. heap_size 队列大小

```c++
// O(lgn)
MAX-HEAP-INSERT(PQ, key)
	PQ[++heap_size]=key
	MAX-HEAPIFY-UP(PQ, heap_size)

// O(lgn)
MAX-HEAPIFY-UP(PQ, idx)
	int key=PQ[idx]
	while PARENT(idx)>=1 and PQ[PARENT(idx)]<key
		PQ[idx]=PQ[PARENT(idx)]
		idx=PARENT(idx)
	PQ[idx]=key

// O(1)
// peek the maximum
HEAP-MAXIMUM(PQ)
	return PQ[1]

// take the maximum
// O(lgn)
MAX-HEAP-EXTRACT(PQ)
	int max=PQ[1]
	PQ[1]=PQ[heap_size--]
	MAX-HEAPIFY(PQ, 1)
  return max

// O(lgn)
MAX-HEAPIFY(PQ, idx)
	while hasLeftChild(idx)
    int maxIdx=idx
    if PQ[leftChildIdx(idx)]>PQ[maxIdx]
    	maxIdx=leftChildIdx(idx)
    if hasRightChild(idx) and PQ[rightChildIdx(idx)]>PQ[maxIdx]
    	maxIdx=rightChildIdx(idx)
    if maxIdx!=idx
    	swap(PQ, idx, maxIdx)
      idx=maxIdx
    else break
      
// 删除指定节点
// O(lgn)
MAX-HEAP-DELETE(PQ, idx)
  if PQ[idx]<PQ[heap_size]
  	PQ[idx]=PQ[heap_size--]
  	MAX-HEAPIFY-UP(PQ, idx) // 向上调整
  else
		PQ[idx]=PQ[heap_size--]
		MAX-HEAPIFY(PQ, idx) // 向下调整

// 更改指定节点的key值，可增大/可减小
MAX-HEAP-MODIFY-KEY(PQ, idx, newKey)
  int oldKey=PQ[idx]
  PQ[idx]=newKey
	if newKey>=oldKey
		MAX-HEAPIFY-UP(PQ, idx) // 向上调整
	else MAX-HEAPIFY(PQ, idx) // 向下调整
```

## 2019-07-22

### Java 分批处理List数据

> see [ListBatchDealUtil](https://github.com/zhanfengGh/comfenglearn/blob/master/learn-basic/src/main/java/com/feng/learn/basic/array/ListBatchDealUtil.java)

```java
public static <T> int deal(List<T> list, int batchSize,
                               Function<? super List<T>, Integer> function) {
        int dealtCount = 0;
        int totalSize = list.size();
        int batchCount = totalSize / batchSize + 1;
        for (int i = 0; i < batchCount; i++) {
            int start = i * batchSize;
            int end = (i + 1) * batchSize;
            end = end > totalSize ? totalSize : end; //处理end边界
          	if (start == end) {
              	continue;
            }
            // do something with the subList
            dealtCount += function.apply(list.subList(start, end));
        }
        return dealtCount;
    }
```



### Heap 数据结构

heap数据结构可用于堆排序/优先队列/多路归并

#### 堆排序

已有一个数组，用堆排序对数组进行排序。

see: [**MaxHeapSortIntArray.java**](https://github.com/zhanfengGh/algorithm/blob/master/java/src/main/java/select/sort/heap/MaxHeapSortIntArray.java)

see: todo 范性

see: todo 大小堆

```c++
// 自然许排序A数组
HEAPSORT(A)
	BUILD-MAX-HEAP(A)
	for i=A.length downto 1
		swap(A, 1, i)
		HEAP-MAXIMUM(A, 1, i)
		
// 以数组A建立大堆
BUILD-MAX-HEAP(A)
	for i=PARENT(A.length) downto 1
		HEAP-MAXIMUM(A, i, A.length)
	
// 堆调整 
// 递归基线条件1: 是否有孩子存在
// 递归基线条件2: 是否是最大值
HEAP-MAXIMUM(A, i, heap_size)
	if LEFT(i)<=heap_size // 存在左孩子
		int idx=i;
		if A[LEFT(i)]>A[idx] // 判断左孩子
			idx=LEFT(i)
		if RIGHT(i)<=heap_size and A[RIGHT[i]]>A[idx] // 判断右孩子
			idx=RIGHT(i)
		if idx!=i // 判断是否需要调整
			swap(A, i, idx)
			HEAP-MAXIMUM(A, idx, heap_size) // 递归
```





## 2019-07-19

### 架构优化

![hbase2es](./pictures/yh_hbase2es_app_parallel.JPG)

## 2019-07-17

### Java 多线程注意事项

1. 线程一定要设置名字
   1. new Thread("threadName")
   1. 线程池的ThreadFactory
1. 合适位置响应线程中断`Thread.interrupted()`

### Java Thread

线程越多：cpu 利用率 / 系统资源 / 上下文切换  就越多

> CPU usage, OS resources, and context-switching overhead 

- CPU计算密集型任务：线程推荐数量 `cpu核数 ～ cpu核数*2`
- IO 型任务：线程数要比cpu核数多很多，具体多少需测试

### Java BlockingQueue

#### ArrayBlockingQueue

使用循环数组实现，用`takeIndex`,`putIndex`,`count` 3个参数标记循环队列。

ArrayBlockingQueue 初始化时必须指定数组大小。使用1个`Lock` 2个`Condition`保护。

**ArrayBlockingQueue 是有界队列。**

```java
final Object[] items;
int takeIndex;
int putIndex;
int count;

/** Main lock guarding all access */
final ReentrantLock lock;
/** Condition for waiting takes */
private final Condition notEmpty;
/** Condition for waiting puts */
private final Condition notFull;
```

```java
private void enqueue(E x) {
  final Object[] items = this.items;
  items[putIndex] = x;
  if (++putIndex == items.length) {
    putIndex = 0;
  }
  count++;
}
```

```java
private E dequeue() {
	final Object[] items = this.items;
	E item = (E) items[takeIndex];
	items[takeIndex] = null;
	if (++takeIndex == items.length) {
		takeIndex = 0;
	}
	count--;
	return item;
}
```

#### LinkedBlockingQueue

see [LinkedBlockingQueue](https://github.com/zhanfengGh/comfenglearn/blob/master/learn-basic/src/main/java/com/feng/learn/basic/blockingqueue/LinkedBlockingQueue.java)

```java
private Node<E> head;
private Node<E> tail;
private final int capacity;
private final AtomicInteger counter = new AtomicInteger();

private final Lock putLock = new ReentrantLock();
private final Condition notFull = putLock.newCondition();

private final Lock takeLock = new ReentrantLock();
private final Condition notEmpty = takeLock.newCondition();

```

LinkedBlockingQueue 采用`putLock` and `takeLock`2个`Lock`分别保enqueue和dequeue，并且采用`AtomicInteger` 类型的counter来保护队列的大小。

#### SynchronousQueue



## 2019-07-16

### Java 线程池

#### ThreadPoolExecutor

1. corePoolSize
1. maximumPoolSize
1. keepAliveTime
1. BlockingQueue
1. ThreadFactory
1. RejectedExecutionHandler

![](./pictures/java_ThreadPoolExecutor_activity.png)



### spring redis cache 

#### spring redis cache key中带有不可读的unicode码

原因：redis中key是以2进制存储的，RedisTemplate 默认使用`JdkSerializationRedisSerializer`把key序列化成`byte[]`。即使使用`String`类型作为redis的key，序列化时会加入类信息（即不可读的unicode码）

解决方案：使用`StringRedisSerializer`作为key的序列化。

```java
redisTemplate.setKeySerializer(new StringRedisSerializer())
```

## 2019-07-10

### 线程中断

每个线程（Thread实例）都维护一个中断状态。

### Java 多线程同步

#### 线程封闭

把对象封闭在当前线程中，其他线程不能访问对象。

1. 栈封闭：局部变量（包括形参，代码块局部变量）：他们都被封闭在当前线程的方法栈内。

1. 用volatile声明的变量，在设计上能保证只有一个线程对变量进行更新操作（不会发生竞态条件）。

   > volatile能保证其他线程看到更新后的值，即提供可见性

#### 共享不可变的对象

在多个线程之间共享“不可变对象”，也不需要线程同步。

#### 共享可变对象

把对 “共享”的“可变对象”的并发操作改为**串行操作**。

#### 总结

1. 单个变量

   1. **可用volatile保证其可见性**
   1. **用Atomic*类保证原子性**

1. 多个变量形成不变式

   **暂时没有任何手段可以让多线程同时更新不变式。**

   **只能把多线程通过互斥锁变成单线程对不变式更新。**

1. 编程习惯：除非需要更高的可见性，否则应将所有的域声明为private域；除非需要某个域是可变的，否则应将所有的域声明为final域。对于访问和更新 不变性条件中的多个变量出现竞态条件时，可以通过将这些变量全部保存在一个不可变的对象中来消除竞态条件。这样就可以不用加锁来保证同步

## 2019-07-09

### Java double/long

**针对64为的long或double类型的数据，java的内存模型每次只读32位的数据**。

**Jdk1.8 对double/long的读写是不保证原子性**，在多线程环境下必须加 **volatile** 修饰。

对**引用类型**和**除了double/long的所有基本变量**的读写都是原子性的。

**Reads and writes are atomic for reference variables and for most primitive variables (all types except long and double).**

**Reads and writes are atomic for all variables declared volatile (including long and double variables).**

综合以上2点：volatile修饰的变量都是原子读/或原子写

### Java 内存

从对象的创建、访问、共享角度看Java内存

#### 线程共享角度

线程共享的内存有：

- Java Object Heap  堆

  - Young Generation 年轻代
    - Eden
      - TLAB Thread Local Allocation Buffer
    - Survivor0 / Survivor1
  - Old Generation 老年代

  > 分代是为了提高GC效率/内存分配效率

- Method Area 方法区 JVM 用永久区实现

  > Stores Classes, Methods and other meta data.

  - Runtime Constant Pool 运行时常量池
    - 字面量
    - 符号引用： **类和接口的全限定名**、**字段的名称和描述符** 和 **方法的名称和描述符**

线程私有的内存有：

- Thread Stack 栈
  - Vm stack 虚拟机的栈
  - Native Method Stack 本地方法栈
- Program Counter Register 程序计数器

#### 对象创建角度

1. 加载类meta data 到**方法区**
1. **堆上**分配实例需要的内存（内存大小由类内的**field**确定）
1. 把分配到的内存全部初始化成0
1. 执行对象的初始化块

##### 堆上分配内存

- **指针碰撞**：如果Java堆中内存绝对规整，所有用过的内存放在一边，空闲内存放在另一边，中间一个指针作为分界点的指示器，那分配内存就仅仅是把那个指针向空闲空间那边挪动一段与对象大小相同的距离。
- **空闲列表**：如果Java堆中内存并不规整，那么虚拟机就需要维护一个列表，记录哪些内存块是可用的，以便在分配的时候从列表中找到一块足够大的空间划分给对象实例，并更新列表上的记录。

1. 优先分配在Eden区。采用**指针碰撞**来分配内存

   > Eden区的对象是规整的，指针左边是已使用的内存，指针右边是未使用的内存。

   **指针碰撞的线程安全问题**解决方案：

   1. 对分配内存空间的动作进行同步处理：采用**CAS+失败重试的方式保证更新操作的原子性**；
   1. **把内存分配的动作按照线程划分的不同的空间中：每个线程在Java堆中预先分配一小块内存，称为本地线程分配缓冲（TLAB），哪个线程要分配内存，就在自己的TLAB上分配，如果TLAB用完并分配新的TLAB时，再加同步锁定**。

1. 大内存也可以直接分配在老年代

   > 老年代的内存可以是规整的（采用标记整理的GC算法）；也可以是不规整的（采用标记清理的GC算法）

#### 对象的访问角度

对象已在Java heap上创建好了，并且完成了init。**如何建立引用（reference）到对象的关系？**

1. **句柄访问**：**Java堆**中会划分出一块内存作为句柄池，栈中的reference指向对象的句柄地址，句柄中包含了**对象实例数据**和**类型数据**各自的具体地址信息。

   > 类型数据 是 描述数据的数据/meta data / Class /java 类

   ![这里写图片描述](./pictures/java_memory_object_handle.png)

1. **直接指针访问**：reference中存储的就是对象地址。

   ![这里写图片描述](./pictures/java_memory_object_direct_point.png)

总的来说，这两种对象访问定位方式各有千秋。使用句柄访问的最大好处就是reference中存储的是稳定的句柄地址，对象被移动（垃圾收集时移动对象是非常普遍的行为）时只会改变句柄中的实例数据指针，reference本身不需要修改；而使用直接指针访问的最大好处就是速度快，节省了一次指针定位的时间开销。

## 2019-07-08

### Java 垃圾回收

1. lock down momery
1. mark
1. sweap

**JVM** 采用 **有向图** 来管理内存中的对象，缺点：效率低下。

引用变量和Heap中的对象为有向图的顶点，引用关系为有向图的边。引用边总是从引用变量指向被引用的对象。由于变量都是由线程创建出来的，可以把线程当作是有向图的起始顶点。 

**Java** 中**无用且不可达**的对象，会被GC回收掉，不会造成内存泄漏；但是**无用可达的对象**，不会被GC回收，会造成**内存泄漏**。

![Pasted Graphic 10.tiff](./pictures/java_c_momery_leak.tiff)

#### 2个目标

1. Max pause time goal  

   > 最求的是快速响应，GC `STW`越短越好

1. Max throughput goal

   > 最求吞吐量

#### 早期回收算法

1. Lock down the entire Java Obejct Heap
1. mark
1. sweap / compact

####  创建对象

1. 对象优先在Eden分配。
1. 大对象直接进入老年代。
1. 长期存活的对象将进入老年代。

#### 分区回收算法

为什么要分区：提高GC效率；以什么分区：对象的生命周期是有规律的

Java Object Heap 分为

1. new generation 新生代
1. old generation 老年代/Tenured

> **-XX:NewRadio=2**		Young/old=1/2

分区是基于**对象生命周期**（大部分应用80%～95%的对象很快死亡）。

可以将不同生命周期的对象分代管理，并采用不同的垃圾回收策略，**提高GC效率**

![Pasted Graphic 11.tiff](./pictures/java_memory_generations.tiff)

##### 新生代

![image-20190708150513524](./pictures/java_memory_new_generation.png)

> **-XX:SurvivorRatio=8**  	
>
> Young中survivor/Eden=1/8 Young代中一般有2个survivor,所以每个survivor占整个Young大小的1/10

年轻代采用**Copy算法**（年轻代的对象80%～95%在MinorGC时死亡，只有少数的对象存活）

年轻代是**大片连续内存**，在创建对象时**只需移动Eden区的指针即可**

Copy算法的优点：遍历一边 / 大片连续内存（无碎片）；缺点：不能有大量的存活对象

年轻代在GC时一定是`Stop The World`的，可以采用**单线程的串行算法**或**多线程的并行算法**

##### 年老代

年老代采用**标记->清除** 或 **标记->整理** 算法。常用的回收算法有

1. Serial Old (SerialMSC) 最古老的单线程串行算法，采用的是**标记->整理**

1. Parallel Old (ParallelMSC) mark->sweap and compact 多线程的并行算法，采用的是**标记->整理**

   > 此算法的GC目标是最求最大化吞吐量

1. CMS (Concurrent Mark Sweap) 采用的是**标记->清除**

   ![Pasted Graphic 12.tiff](./pictures/java_gc_cms.tiff)

   > 优点：最求最小GC `STW`、高并发、低停顿、程序暂停时间短，实时性高
   >
   > 缺点：占用更多内存和CPU、有内存碎片

#### G1

用于大内存（11G以上）/ 强劲CPU

#### 组合图

![dd](./pictures/java_gc_algorithm.jpeg)

- Serial收集器（复制算法): 新生代单线程收集器，标记和清理都是单线程，优点是简单高效；

- Serial Old收集器 (标记-整理算法): 老年代单线程收集器，Serial收集器的老年代版本；

- ParNew收集器 (复制算法): 新生代收并行集器，实际上是Serial收集器的多线程版本，在多核CPU环境下有着比Serial更好的表现；

- Parallel Scavenge收集器 (复制算法): 新生代并行收集器，追求高吞吐量，高效利用 CPU。吞吐量 = 用户线程时间/(用户线程时间+GC线程时间)，高吞吐量可以高效率的利用CPU时间，尽快完成程序的运算任务，适合后台应用等对交互相应要求不高的场景；

- Parallel Old收集器 (标记-整理算法)： 老年代并行收集器，吞吐量优先，Parallel Scavenge收集器的老年代版本；

- CMS(Concurrent Mark Sweep)收集器（标记-清除算法）： 老年代并行收集器，以获取最短回收停顿时间为目标的收集器，具有高并发、低停顿的特点，追求最短GC回收停顿时间。

- G1(Garbage First)收集器 (标记-整理算法)： Java堆并行收集器，G1收集器是JDK1.7提供的一个新收集器，G1收集器基于“标记-整理”算法实现，也就是说不会产生内存碎片。此外，G1收集器不同于之前的收集器的一个重要特点是：G1回收的范围是整个Java堆(包括新生代，老年代)，而前六种收集器回收的范围仅限于新生代或老年代。



## 2019-07-06

1. Java 创建对象分配内存 锁 / GC 锁

### Java Memory

#### 虚拟内存

在64位的cpu上，虚拟内存的寻址空间位`0 ～ 2⁶⁴-1`，每个进程的寻址空间都一样。

#### Java 进程

![thrshxq124.png.jpg](./pictures/Jvm_process_memory.jpg)

Java 是一个用C++编写的程序，启动后会创建一个进程。

Java 进程的内存分布

1. 进程的数据区（java这个程序的，和java编写的代码没有关系）
1. process heap （进程的堆）
1. process stack （进程的栈）

JVM （Java Virtual Machine）可控制的内存**只有** `process heap （进程的堆）`

#### JVM 内存

![vo9hlbmdal.png.jpg](./pictures/Jvm_process_momery_2.jpg)

JVM 可控制的内存（ process heap）主要由以下几个部分组成

1. Permanent Space								

   永久区

   > Stores classes, methods and other meta data

   > -XX:PermSize=<value> (initial) / -XX:MaxPermSize=<value> (max)

   > java.lang.OutOfMemoryError: PermGen space

1. Java heap (Java Object heap) 

   Java堆，GC主要是处理Java堆的回收工作

   > Stores Java Objects.

   > -Xms=<value> (initial) / -Xmx=<value> (max)

1. Thread Stack

   线程栈
   
   > Each thread has a separate memory space called "thread stack" 
   >
   > 一个线程一个栈(不和其他线程共享)。**线程越多，使用的内存就越多**。
   
   > -Xss=<value> Too low –Xss value can cause java.lang.StackOverflowError
   
   > java.lang.OutOfMemoryError: unable to create new native thread
   
1. Socket Buffers / Direct Momery Space

   > Direct Momery Space分配的内存不在Object Heap内，因此不会被**GC**回收，必须要自己回收**。**在网络IO应用上可以发挥很高性能（Object Heap内的数据在进行系统调用write时，也是先从Object Heap内拷贝一份数据到此区域，然后把此区域的内存地址传给write）

   > Each tcp connection contains two buffers: Receive buffer ~37k / Send buffer ~25k
   >
   > 每个TCP连接，Java在**进程的heap**中创建2个缓存区（和系统内核级别的tcp缓存没关系），这样Java在IO读写时，读写的是**进程Heap**中的cache，不会发生系统调用（上下文切换）。
   >
   > 一个TCP连接需要～64K的内存，那么`64K*16*1024=1G`16384个TCP连接需要1G的内存。这里猜测**每个TCP的缓存是在需要时才占用内存，不需要时会被JVM释放**。

   > Ability to let Java developers map memory outside the Java Object Heap. 直接在java堆外分配内存
   >
   > java.nio.ByteBuffer.allocateDirect

   > java.lang.OutOfMemoryError: Direct buffer memory

   > -XX:MaxDirectMemorySize=<value>

1. GC Thread and Info

1. JNI / JNI allocate momery

## 2019-07-05

### Java volatile

![img](./pictures/java_volatile_cpu_cache_memory.jpg)

volatile 类似缓存一致性协议（如Intel 的MESI协议）。

当CPU写数据时，如果发现操作的变量是共享变量，即在其他CPU中也存在该变量的副本，会发出信号通知其他CPU将该变量的缓存行置为无效状态，因此当其他CPU需要**读取**这个变量时，发现自己缓存中缓存该变量的缓存行是无效的，那么它就会**从内存重新读取**

Java 中**对象是存储在Java Object Heap上的，是被多个线程共享的**，类似上面的主存。

Java 中每个线程都有自己独有的线程stack，类似上面的Cache。

注意：**volatile 修饰的变量只是在读取时会判断是否需要从内存中重新获取最新值，写入时是不校验的**。

volatile：只保证可见性，不保证原子性

满足以下所有条件时才可以使用volatile变量：

1. **对变量的写入操作不依赖于变量的当前值**，或**只有一个线程更新变量的值**。
1. 该变量不和其**他状态变量**一起**纳入不可变性条件**。

volatile 常用场景：

1. 状态标志 see [StatusFlag](https://github.com/zhanfengGh/comfenglearn/blob/master/learn-basic/src/main/java/com/feng/learn/basic/volatiletest/StatusFlag.java)
1. 逻辑上只有一个线程在更新数据，volatile保证可见性

volatile 实现读写锁策略

synchronized 写加锁，保证只有一个线程对变量更新；volatile 保证更新后的数据对其他线程可见。

```java
@ThreadSafe
public class SpecialCounter {
    // Employs a cheap read-write lock trick
    // All mutative operations MUST be done with the 'this' lock held.
    @GuardedBy("this")
    private volatile int counter = 0;
    public int get() {
        return counter;
    }
    public synchronized void increment() {
        counter++;
    }
}
```

QA [volatile 可见性问题](https://github.com/zhanfengGh/comfenglearn/blob/master/learn-basic/src/main/java/com/feng/learn/basic/thread/volatiletest/C.java)

### Java 基本类型 / 包装类型

```java
public static void main(String... args) {
	int i = 5;
	Integer j = 5;
}
```

区别1: 占用空间

> `int i = 5` 在当前线程的栈内占用 `4 byte` 

> `Integer j = 5` 在当前线程的栈内占用 `8 byte`(64bit引用) + 堆内 `16 byte` (4 byte 内部属性 + 8 byte 对象头 + 4byte对齐)

> 内存占用上 `Integer` 24byte 是 `int` 4byte 的6倍
>
> `Byte` 24byte 是 `byte` 1byte的24倍

区别2:  系统性能损耗

> `int i = 5`只用栈，随着方法的退出便销毁

> `Integer j = 5` 引用在栈上，随着方法的退出便销毁；对象在堆上，需GC回收

### Java 不可变对象

对象一旦被创建（内部属性被赋值）就不能被改变。

使用场景：**多线程编程时，对象的创建和销毁比加锁机制要轻量。**

1. final 声明类（类不可被继承）or 私有化所有构造器并提供类静态初始化方法。

1. private final 声明属性（属性不可以被重复赋值）

1. 内部属性的类型可以是**不可变类型**（基本类型及其包装类、String、BigDecimal等）；也可以是**可变类型**，对可变类型的引用在初始化和获取时，必要要保护性拷贝

   > 保护性拷贝：对可变类型内的所有引用都必须新建对象，然后保护性拷贝新建对象内的引用；对对象内的不可变类型的引用可直接拷贝其引用。可以看出，这是一个递归的过程

1. 对象必须被正确的构造。（构造过程中this对象不能被逸出）

> see https://github.com/zhanfengGh/comfenglearn/blob/master/learn-basic/src/main/java/com/feng/learn/basic/immutable/ImmutableHolder.java

### Java volatile 单例类

```java

public class DoubleCheckSingleton {
  	// instance 没有volatile修饰时是错误的，多线程下会构造出一个或多个instance对象
    // private static DoubleCheckSingleton instance;
  	private static volatile DoubleCheckSingleton instance;
    // 私有化构造
    private DoubleCheckSingleton(){}
    public static DoubleCheckSingleton getInstance() {
        if (instance == null) {
            synchronized (DoubleCheckSingleton.class) {
                if (instance == null) {
                    instance = new DoubleCheckSingleton();
                }
            }
        }
        return instance;
    }
}
```



## 2019-07-04

### Java 日期操作

1. java.util.Date

   表示某一刻的时间

   ```java
   Date now = new Date(); // equals to new Date(System.currentTimeMillis)
   Date time = new Date(1562204983000); // 2019-07-04 09:49:43
   
   long millisSeconds = time.getTime(); // 1562204983000
   boolean after = time.after(now);
   boolean before = time.before(now);
   ```

1. java.text.DateFormat

   Date和表示时间的字符串之间相互转化

   format: Date -> 时间的字符串

   parse: 时间的字符串 -> Date

   > Synchronization
   > Date formats are not synchronized. It is recommended to create separate format instances for each thread. If multiple threads access a format concurrently, it must be synchronized externally.

   ```java
   DateFormat df = DateFormat.getDateTimeInstance();
   SimpleDateFormat sdf = (SimpleDateFormat) df;
   
   // yyyy年MM月dd日 月份和天不够2位前面补0
   sdf.applyPattern("yyyy年MM月dd日");
   Date parse = sdf.parse("2019年7月4日");
   log.info("yyyy年MM月dd日 = {}", sdf.format(parse));            
   
   // yy年M月d日 H:m:s 年份用2位表示，月天时分秒有1位显示1位；有2位显示2位
   sdf.applyPattern("yy年M月d日 H:m:s");
   log.info("yy年M月d日 H:m:s = {}", sdf.format(new Date()));     
   
   // 解析时不care长度
   sdf.applyPattern("y年M月d日");
   parse = sdf.parse("2019年7月4日 19:55");
   log.info("{}", parse);
   ```

1. java.util.Calendar

   read/update Date年月日时分秒等的某个字段

   Calendar中需要注意的：

   1. Calendar的星期是从周日开始的，常量值为0。
   1. Calendar的月份是从一月开始的，常量值为0。
   1. Calendar的每个月的第一天值为1。

## 2019-07-03

### URL 梳理

统一资源定位符的标准格式如下：

`[协议类型]://服务器地址:端口号/资源层级UNIX文件路径文件名?查询#片段ID`

统一资源定位符的完整格式如下：

`[协议类型]://访问资源需要的凭证信息@服务器地址:端口号/资源层级UNIX文件路径文件名?查询#片段ID` 

```
http://www.baidu.com/index.html # 省略默认80端口号
```

[超文本传输协议](https://zh.wikipedia.org/wiki/超文本传输协议)的统一资源定位符将从因特网获取信息的五个基本元素包括在一个简单的地址中：

1. [传送协议](https://zh.wikipedia.org/wiki/統一資源標誌符方案)。
1. 层级URL标记符号(为[//],固定不变)
1. 访问资源需要的凭证信息（可省略）
1. 服务器。（通常为[域名](https://zh.wikipedia.org/wiki/域名)，有时为[IP地址](https://zh.wikipedia.org/wiki/IP地址)）
1. 端口号。（以数字方式表示，若为默认值可省略）
1. 路径。（以“/”字符区别路径中的每一个目录名称）
1. 查询。（GET模式的窗体参数，以“?”字符为起点，每个参数以“&”隔开，再以“=”分开参数名称与数据，通常以UTF8的URL编码，避开字符冲突的问题）
1. 片段。以“#”字符为起点[[2\]](https://zh.wikipedia.org/wiki/统一资源定位符#cite_note-2)

```
file://host/path

# 以下2个是一样的
file://localhost/etc/my.cnf
file:///etc/my.cnf

file://localhost/Users/feng/Downloads/proxy.pac # 浏览器可以直接打开
```

### java 全局静态属性

最好是不变对象。

>  调用者拿到对象后，若对对象的应用作更改，则更改的是全局。

## 2019-07-01

### git 回滚某个文件到指定版本

