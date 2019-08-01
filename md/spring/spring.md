## spring 框架编程第一点

1. ### 不要继承spring框架的任何类

1. ### 不要继承spring框架的任何类

1. ### 不要继承spring框架的任何类

## spring context

反射创建bean实例1⃣ -> setter方法注入dependencies2⃣ -> invoke init method3⃣ -> spring AOP 创建代理 

1⃣可以调用无参constructor / 有参constructor / 类的static方法 / bean实例的方法 。调用有参构造器时，会根据**配置注入dependency**。

### Dependency Injection

1. 通过 Constructor-based 注入

   1. 有参构造器
   1. 有参static方法

1. 通过 Setter-based 注入

   > Setter-based DI is accomplished by the container calling setter methods on your beans after invoking a no-argument constructor or a no-argument `static` factory method to instantiate your bean.

The `ApplicationContext` supports constructor-based and setter-based DI for the beans it manages. **It also supports setter-based DI after some dependencies have already been injected through the constructor approach.**

可混合使用基于构造器的注入和基于Setter方法的注入。

### bean路径扫描/开启注解依赖注入

`<context:annotation-config/> `启用Ioc注解支持。在xml定义bean时，会处理类中的DI注解（@Autowired，@Resource等）

`<context:component-scan base-package="com.feng.learn.spring" />` 指定扫描路径，把扫描到的带有@Compoent的类都定义成BeanDefination,仅此而已。默认开启`<context:annotation-config/> `

## @Resource/@Autowired

### @Resource 

注解 **javax.annotation.Resource**

```java
@Service("meetingService")
public class MeetingService {
	@Resource(name = "userDao")
	private UserDao userDao;
}
```

1. 指定name值 

   ```java
   @Resource(name = "userDao")
   private UserDao userDao;
   ```

   从容器中找name/ID为“userDao”bean:

   1. 若未找到，报错
   1. 找到一个，是UserDao类型，注入；不是UserDao类型时，尝试转换成UserDao类型，转换失败，报错。

1. 未指定name值

   ```java
   @Resource
   private UserDao userDao;
   ```

   1. 先按默认名字`userDao`从Ioc容器中查找bean。若找到一个，是UserDao类型，注入；不是UserDao类型时，尝试转换成UserDao类型，转换失败，报错；未找到，执行第二步。
   1. 按类型（UserDao）从Ioc容器中查找bean。若一个都没有，报错；找到一个，注入；找到多个，若有一个上有@Primary注入，否者报错。
   1. 不指定value值时，可以注入**interfaces that are well-known resolvable dependencies**（参考@Autowired）

总结：**@Resource若指定名字，则只按名字查找；若未指定名字，先按名字查找，然后按类型查找。**

### @Autowired

```java
@Service("meetingService")
public class MeetingService {
  @Autowired(required = false)
  private MeetingDao meetingDao;
}
```

#### 按类型来注入

> 一个都没有找到，有required=false注入null；没有throw exception
>
> 只有一个，注入
>
> 找到多个，若仅有一个bean上有@Primary注解，注入；否则throw exception

> @Autowired 可以和@Qualifier(spring)联合使用进行过滤

> @Qualifier 容器中可以有多个Qualifier相同的bean（可以同类型/也可以不同类型）存在

#### 使用场景

1. contructor。假如一个类**只有一个**构造器，可以**省了@Autowired**；有多个构造器时**至少一个**要有@Autowired
1. Setter method/arbitrary method。有多个参数时，都会被DI。
1. field

#### 高级用法

@Autowired 可以注入同一类型的

**数组**

**集合**（List/Set）

**Map**（key必须为String，value为需要的类型）

**interfaces that are well-known resolvable dependencies**

1. `BeanFactory`, `ApplicationContext`, `Environment`, `ResourceLoader`, `ApplicationEventPublisher`,`MessageSource`
1. 以上类的扩展接口such as `ConfigurableApplicationContext` or `ResourcePatternResolver`

```java
// 一下示例仅以field作说明，可以用在@Autowired可以用到的任何地方，如构造器和方法中有需要注入的集合时，都会被注入
@Autowired
private MovieCatalog[] movieCatalogs;

@Autowired
@Qualifier("aMovie")
private List<MovieCatalog> movieCatalogList;

@Autowired
private Set<MovieCatalog> movieCatalogSet;

@Autowired
private Map<String, MovieCatalog> movieCatalogMap;

@Autowired
private ApplicationContext applicationContext;
```

## Spring AOP

### 快速使用

> 示例项目 xqcx-spring-aop (https://github.com/zhanfengGh/comfenglearn.git)

1. `@EnableAspectJAutoProxy` 开启 使得带有@Aspect注解的bean会被Spring容器当成切面来处理
1. `@Aspect` and `@Component` 共同标注在类上时，才会被当成切面。只有`@Apect` 不是容器的bean，只有`@Composent` 不是切面。
1. 被@Aspect标注的类只是**JOPO**。只有注解被spring容器理解时才会起作用。

基于@Aspectj 注解的声明式编程有点：简单/缺点：必须有切面的源码（自己编写的当然有，要是用别人的类和方法就不行了），这时就需要给予XML来编写AOP。

### AOP 常用场景

1. 日志
1. spring cache
1. Spring transaction
1. spring security

### AOP相比委托/继承模式优点

1. 解藕/核心逻辑只需关心自己逻辑即可
1. 可随时开闭切面功能（如Spring Cache等）
1. 切面逻辑集中到一起，有助于后续维护

### 通知函数

```
@Before
@AfterReturning
@AfterThrowing
@After
@Around
```

### @AspectJ / Spring 切面语法

```
execution(* *(..)) // 所有方法
execution(public * *(..)) //所有公共方法
execution(* set*(..)) // 所有的set方法
execution(public * set*(..)) // 所有public set 方法

within(com.feng.learn.controller.*) // 包下所有类的所有方法
execution(* com.feng.learn.controller.*.*(..)) 

within(com.feng.learn.controller.UserController) // UserController 的所有方法
execution(* com.feng.learn.controller.UserController.*(..))

子类
within(com.feng.learn.dao.UserDao+)

包含包以及子包
within(com.feng.learn.controller..*)
execution(* com.feng.learn.controller..*.*(..))

具体方法
execution(User com.feng.learn.controller.UserController.get(long))

bean指示符 （Spring AOP 特有）
bean(*Service)

@within 类上有特定注解的类内所有的方法
@within(com.feng.learn.aop.AAnnotation)

@annotation 方法上有特定注解
@annotation(com.feng.learn.aop.AAnotation)
```

### 通知方法参数的传递

```java
// 切入点：com.feng.learn包以及子包下所有的 以long类型的参数作为方法的第一个参数 的所有方法
@Before(value = "within(com.feng.learn..*) && args(id,..)")
public void before(JoinPoint jp, long id) {
}

// 切入点：com.feng.learn包以及子包下所有的 以long类型的参数作为方法参数且返回值类型为User 的所有方法
// returning也会作为切入点筛选的条件
@AfterReturning(value = "within(com.feng.learn..*) && args(id)", returning = "user")
public void afterReturning(JoinPoint jp, long id, User user) {
	System.out.println(jp);
}
// 切入点：com.feng.learn包以及子包下所有的 以long类型的参数作为方法参数且方法运行时实际的异常是UserException 的所有方法
// throwing也会作为切入点筛选的条件 
@AfterThrowing(value = "within(com.feng.learn..*) && args(id)", throwing = "e")
public void afterThrowing(JoinPoint jp, long id, UserException e) {
	System.out.println(jp);
}
// 对于RuntimeException，方法上是不需要声明的，运行时若throw，也会被拦截
@AfterThrowing(value = "within(com.feng.learn..*) && args(id)", throwing = "e")
public void afterThrowing(JoinPoint jp, long id, RuntimeException e) {
	System.out.println(jp);
}

@After(value = "within(com.feng.learn..*) && args(id)")
public void after(JoinPoint jp, long id) {
  System.out.println(jp);
}
```

### Advice（通知）优先级

1. 对前置通知（Advice）优先级越高，执行顺序越靠前；对于后置通知优先级越高，执行顺序越靠后。

1. 同一个切面中（同一个带有@Aspect注解的Bean定义）对同一个切入点定义的多个advice，优先级是按定义时的顺序，越靠前优先级越高。

   > ?错误：对于@After 通知，定义越靠**前，优先级越高，执行就越靠后**。
   >
   > spring-aop:4.3.13.RELEASE 实测结果: **@After 通知的执行顺序和定义顺序相同**，和第一点不符合。
   >
   > 对于@After 通知，定义越靠**后，优先级越高，执行就越靠后**。

1. 对不同切面中对同一个切入点声明的多个Advice，按@Order（只放在类上有效）定义优先级，@Order值越小，优先级越高

### 原理解析

#### Java-面向切面编程AOP

AOP是一个编程思想，比较有名的Java实现框架有**AspectJ和spring AOP**。AspectJ是一个独立的实现框架；spring AOP也是一个实现框架。

spring AOP以 **动态代理** 实现AOP，在Spring AOP中，要使用AspectJ的切点表达式语言来定义切点，注解式实现@Aspect/@Pointcut/@After/@Before/@Around 等用到了AspectJ 框架中的一些注解（只是借用一些注解），但底层实现依旧是**动态代理**。

实际应用中：

   	1. 可以单独应用spring AOP实现AOP
   	2. 也可以使用注入式AspectJ切面， 底层实现依旧是**动态代理**。

#### AOP几个常用概念

1. Join point连接点 

   可以在哪里放入切入点，由于spring AOP使用动态代理的方式实现aop，所以springAOP只能用**方法**作为连接点。

1. Aspect 切面 **在哪里**  **做什么**

   - 切入点 Pointcut 在哪里

   - 通知 Advice 做什么

1. Weaving 织入

   把切面应用到目标对象并创建代理的过程：

   1. 编译时织入，需要特殊的Java编译器。AspectJ的织入编译器就是以这种方式织入切面的
   1. 类加载时织入，切面在目标类加载到JVM时被织入。这种方式需要特殊的类加载器（ClassLoader），它可以在目标类被引入应用之前增强该目标类的字节码。AspectJ 5的加载时织入（load-time weaving，LTW）就支持以这种方式织入切面。
   1. 运行时织入（动态代理）切面在应用运行的某个时刻被织入。一般情况下，在织入切面时，AOP容器会为目标对象动态地创建一个代理对象。Spring AOP就是以这种方式织入切面的。

#### Spring AOP

Spring AOP 依靠 **代理** 来实现（pure java implementation），在 **运行时** 把advice和被代理的对象 编织 在一起。默认使用 JDK的动态代理来代理interface；使用 CGLIB 来代理类。

Spring AOP 可以借用AspectJ的注解来快速实现注解式编程。使用**AspectJ**的语法来声明切面（切入点，通知等），启用@AspectJ时需要aspectjweaver.jar来对**@AspectJ**语法进行解析，在底层依旧使用**SpringAOP**来实现，因此不需要依赖**AspectJ**框架的编译器和编织器（**weaver**）。

## Spring 常用注解



## Spring Bean init/destroy

组合使用时，init/destroy的执行顺序由上到下：

1. @PostConstruct/@PreDestroy
1. InitializingBean / DisposableBean 接口
1. Bean 定义时指定。在beans上定义所有bean通用的默认的init（default-init-method）／destroy（default-destroy-method）方法；在bean的init-method／destroy-method bean会覆盖beans的设置

## Spring Expression Language (SpEL)

```
#{1}
#{3.14159}
#{'Hello'}
#{true}
#{beanName}
#{beanName.beanField}
#{beanName.beanMethod()}
#{beanName.beanMethod().toUpperCase()} // beanMethod() 返回String
#{beanName.beanMetho()?.toUpperCase()} // 非空判定
#{T(java.lang.Math).PI} // T()运算符的真正价值在于它能够访问目标类型的静态方法和常量
#{T(java.lang.Math).random()}
	
	
#{2 * T(java.lang.Math).PI * circle.radius}
#{T(java.lang.Math).PI * circle.radius ^ 2}
#{disc.title + ' by ' + disc.artist} // 字符串连接

#{counter.total == 100}

#{scoreboard.score > 100 ? 'Winner' : "Loser"} // 三元运算符
#{disc.title ?: "default"} // #{disc.title !=null ? disc.title : "default"}

#{jukebox.songs[4].title} 
#{jukebox.songs[T(java.lang.Math).random() * jukebox.songs.size()].title}
#{'This is a string'[3]} // 's'

#{jukebox.songs.?[artist eq 'John']} // 返回一个集合，.?[]接受的是过滤条件
#{jukebox.songs.^[artist eq 'John']} // 第一个满足条件
#{jukebox.songs.$[artist eq 'John']} // 最后一个满足条件
#{jukebox.songs.![title]} // 返回歌曲名称的结合 
#{jukebox.songs.?[artist eq 'John'].![title]} // 所有John的歌曲的名字

```

## Spring Validate

校验注解表示属性字段需要满足的条件，需要配合spring的具体实现注解`@Validated`/`@Valid`才能实现验证。

> 对于某个实现类方法上的基本类型byte/short/char/int/long/float/double/boolean及其包装类型的验证，需要在实现类上加`@Validated`注解。
>
> 且若方法是重写接口的方法，则必须将 校验注解 放在接口的方法上（当然接口和实现类的方法上都可以有，但是实现类的方法上不能比接口上的限制注解多）；`@Validated`可以**只放在接口上**也可以**只放在类上**，当然接口和类上都放也没有问题

> 对于自定义model， 校验注解 加在model的属性上，`@Validated`放在方法的形参上即可。若需要对model中的字段进行多层检验（model的字段是另一个model），在字段上加上`@Valid`即可。

> 对于List/Set 类型的字段@NotNull/@Size(min=1) 才能保证至少有一个元素。

> TODO 验证方法上的List/Set/Map形参的校验方法

```
JSR提供的校验注解：         
@Null   被注释的元素必须为 null    
@NotNull    被注释的元素必须不为 null    
@AssertTrue     被注释的元素必须为 true    
@AssertFalse    被注释的元素必须为 false    
@Min(value)     被注释的元素必须是一个数字，其值必须大于等于指定的最小值    
@Max(value)     被注释的元素必须是一个数字，其值必须小于等于指定的最大值    
@DecimalMin(value)  被注释的元素必须是一个数字，其值必须大于等于指定的最小值    
@DecimalMax(value)  被注释的元素必须是一个数字，其值必须小于等于指定的最大值    
@Size(max=, min=)   被注释的元素的大小必须在指定的范围内    
@Digits (integer, fraction)     被注释的元素必须是一个数字，其值必须在可接受的范围内    
@Past   被注释的元素必须是一个过去的日期    
@Future     被注释的元素必须是一个将来的日期    
@Pattern(regex=,flag=)  被注释的元素必须符合指定的正则表达式    


Hibernate Validator提供的校验注解：  
@NotBlank(message =)   验证字符串非null，且长度必须大于0    
@Email  被注释的元素必须是电子邮箱地址    
@Length(min=,max=)  被注释的字符串的大小必须在指定的范围内    
@NotEmpty   被注释的字符串的必须非空    
@Range(min=,max=,message=)  被注释的元素必须在合适的范围内
```

## spring cache

spring cache apply caching to **Java method**.

缓存是通过spring AOP 的代理实现的，调用方法时，先执行代理：根据参数判断缓存是否存在，若存在直接返回cache；若不存在调用方法，然后把方法的返回结果放入缓存。下次调用时，hit cache，return fast。

This abstraction is materialized by the

- `org.springframework.cache.Cache` 
- `org.springframework.cache.CacheManager` 

spring cache **不会加锁**，并发访问时取决于底层实现。

使用spring cache时，开发者只需要关心一下2点：

- caching declaration - identify the methods that need to be cached and their policy
- cache configuration - the backing cache where the data is stored and read from

Declarative annotation-based caching

- `@EnableCaching` 放在配置类上激活cache，若没有，即使方法上有@Cacheable也没用。

- `@Cacheable` triggers cache population

  > 有cache，返回cache；没有cache，invoke method，cache result。

- `@CacheEvict` triggers cache eviction

- `@CachePut` updates the cache without interfering with the method execution

  > 有没有cache都 invoke method then cache result。

- `@Caching` regroups multiple cache operations to be applied on a method

- `@CacheConfig` shares some common cache-related settings at class-level

使用注意事项：

1. `<cache:annotation-driven/> ` or `@EnableCaching` 只在自己所在的application context中生效。这个和事务的注解一样。

   > This means that, if you put `<cache:annotation-driven/>` in a `WebApplicationContext` for a `DispatcherServlet`, it only checks for beans in your controllers, and not your services.

1. `@Cacheable`,`@CacheEvit`,`@CachePut`默认情况下（使用代理）只能放在public方法上，放在protected/private/package-visiable的方法上时，不会报错，但是**不会生效**。

   > ```java
   > @EnableCaching(mode = AdviceMode.PROXY)
   > ```

1. spring 推荐`@Cache*`类注解放在具体的实现类/方法上。可以放在接口/接口方法上，仅在使用**基于接口的代理**时才会生效。spring 默认也是使用基于接口的代理。

   > @EnableCaching(mode = AdviceMode.PROXY, proxyTargetClass = false) 
   >
   > 满足以上2点时才是Java  interface-based proxies
   >
   > You certainly can place the `@Cache*` annotation on an interface (or an interface method), but this works only as you would expect it to if you are using interface-based proxies. The fact that Java annotations are *not inherited from interfaces* means that if you are using class-based proxies ( `proxy-target-class="true"`) or the weaving-based aspect ( `mode="aspectj"`), then the caching settings are not recognized by the proxying and weaving infrastructure, and the object will not be wrapped in a caching proxy, which would be decidedly *bad*.

1. spring cache 默认配置`@EnableCaching(mode = AdviceMode.PROXY, proxyTargetClass = false) ` 下是使用Java interface-based proxies。也就是说只有外部invoke才会被intercepted；内部调用是不会执行缓存逻辑的，即使方法上有`@Cache*`注解。