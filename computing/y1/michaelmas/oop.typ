#import "@local/lecture:0.1.0" : *
#import "@preview/cetz:0.4.2"

#set page(
  numbering: "1",
  supplement: [p.],
  number-align: right,
  header: [
    #set text(8pt)
    #smallcaps[Computer Science Lecture Notes]
    #h(1fr) _Object Oriented Programming_
  ],
)

= Object Oriented Programming

To be maintainable is to be
- Simple to locate code responsible for a particular feature.
- Simple to understand what the code does.
- Simple to modify behaviour.
- Difficult to introduce bugs.

== Types of Languages

#defs([
  - *Declarative languages* specifies what to do (not how to do it).
    - Includes *functional, logic and reactive languages* (which reasons about streams of data).
    - E.g. HTML and SQL
    - OCaml: you give an example on how to achieve something, the compiler has the choice to do something completely different (e.g. tail recursion).
  - *Imparative languages* specifies what and how to do it.
    - *Procedural languages* group things into functions.
    - *OOP* groups procedures together - dividing a large procedural program into many small chunks, which are easier to reason about.
])

Characteristics of OOP are:
- Encapsulation
- Abstraction
- Inheritance
- _Subtype_ polymorphism

Languages often pick and mix concepts for the language creator to complete their tasks.
- E.g. procedural programming in OCaml.
- Functional programming in C++.

OOP is not always appropriate, smaller programs *don't need abstractions*, e.g. using Python for data science. But OOP is better for larger scale programs.

== The JVM

Java was made for the web, where each machine visiting a page has different processors.
#tab2(
  [*Model*], [*Note*],
  [Traditional model], [The compiler compiles source code for a particular machine, that can only run on that type of system. But how do you compile for every system and serve the correct binaries to visitors?],
  [Using an interpreter], [High level languages are not space efficient (not suitable for the 2000s internet speed), and source code is visible to everyone.],
  [The Java model], [The Java compiler compiles Java source code to *bytecode*, which is translated to machine code on the fly. ]
)

#def([
  *Bytecode* is machine code for a fictional machine.
])

Translating from bytecode to machine code is quick, as the toughest part of compilation is going from source code to compiled code.

Bytecode is slower than native code, but compared to interpreted code:
- Bytecode is compiled and not easy to reverse engineer.
- JVM ships with libraries making the bytecode small.

=== The JIT

JVM uses a *JIT* which profiles your code. If it sees a code running over and over again, it compiles it to machine code. So Java programs become faster the longer you run them.

It is used for backend: servers are long running programs that the JVM can learn and optimise.

== Java

=== Basic Language Features

==== Project Layout

There is *one class per file*, and the class name and file name must match (this is to make the code more maintainable).
- The *JRE* is what you need to run Java bytecode.
- The *JDK* is what you need to compile Java. The JRE is a subset of JDK.

==== Data Types

Java is strongly typed. Types are either built-in *primitive types* or *reference types*, which starts with a capital letter.

#grid(
  columns: (50%, auto),
  [
    - `boolean`
    - `byte`
    - `short`
    - `int`
  ],
  [
    - `long`
    - `float`
    - `double`
    - `char`, which is the only *unsigned integer*.
  ]
)

Variables can be *promoted* or *narrowed* to another type.

(DANGER!) Inferring types on local variables can make the code more clear... or more confusing.
```java
var courseName = "Java"; // clearly a String
var n = 1;               // what type is this?
```

==== Procedures

A Java _"function"_ is made up of a *prototype* and a *body*, the prototype specifies the function name, arguments and return type. There are *no pure functions* in Java. There are only procedures which can manipulate state outside the functions.

#hr

== Encapsulation

#defstable(
  [Object], [A bundle of state and behaviour.],
  [Class], [A template for a specific type of object.]
)

- The state of an object is called a *field*, the behaviour are called *methods*.
- A class defines a *type* and the *implementation of methods*.

=== Class

All code in Java are contained in classes.

For best readability, in each file declare in order.
+ Imports
+ Constants
+ Fieilds
+ Constructors
+ Methods

==== Constructors

Constructors have the same name as the class, have no return types (why?), and can be overloaded.

```java
public class MyClass {
  public MyClass(int a) {}
  public MyClass(int a, int b) {}
}
```

#note([
  If you don't declare any constructors, Java will declare one for you.

  You can look at class file signatures with
  ```sh
  javap -c MyClass.class
  ```
])

=== Parameterised Classes

Polymorphism can be done through generics. Classes are defined with placeholder types.

```java
public class Vec2D<T> {
  public T x;
  public T y;
}
```

We fill them in when we create an object with them.

```java
Vec2D<Integer> l = new Vec2D<Integer>();
```

#note([
  The type parameter must be a *reference type*.
])

=== Statics

Objects don't allow global state as state is self contained.

#def([
  A *static field* is created only once in the program's execution.
])

#tab2(
  [Pros], [Cons],
  [Auto synchronised cross instances.], [Make code harder to understand.],
  [Space efficient.]
)

#note([
  Make static fields `final` whenevr possible.
])

*Static methods* don't belong to an object, they are used to group related methods.

=== Universal Modelling Language

#tab1(
  [MyClass],
  [
    \- privateField #br
    \+ publicField
  ],
  [
    \- privateMethod() #br
    \+ publicMethod()
  ]
)

Model *has-a* association with arrows.

#grid2(
  [
    - A college has zero or more students.
    - A student has one college.
  ],
  cetz.canvas({
    import cetz.draw : *

    content((0,0), tab1([College], []))
    content((4,0), tab1([Student], []))
    line((1, 0), (2.9, 0), mark: (start: ">", end: ">"))
    content((1.2, 0.4), $1$)
    content((2.6, 0.4), $0...$)
  })
)
The college can store its students in a list, the student can store his college in a single variable.

=== Visibility

We want to provide an API that exposes what it needs to and hide everything else. Encapsulation allows us to decouple the API from the underlying state: changing how the state is represented internally will not affect code depending on it.

#table(
  columns: (auto, auto, auto, auto, auto),
  align: center,
  [], [*Class*], [*Subclass*], [*Package*], [*Everywhere*],
  [`public`], $tick$, $tick$, $tick$, $tick$,
  [`protected`],$tick$,$tick$,$tick$, [],  
  [no modifier],$tick$,$tick$,[], [],  
  [`private`],$tick$  
)

#note([
  *Encapsulation* is also called information hiding.
])

Public state is almost never needed:
- Create private variables by default.
- Never make a public variable private, it can break code.

== Immutability

#tab2(
  [Immutable], [Mutable],
  [Easier to reason about.], [Updating values in place is more efficient.],
  [Reduces scope for bugs.], [],
  [Thread safe.], []
)

#def(
  [*Immutable classes*: state can be set at initialisation but cannot be changed.]
)

Immutable classes can be achieved with the `final` modifier, or using Java *records* (since Java 16).

```java
public record Vec2D(int x, int y) {}
```

Immutable classes are everywhere in the JDK: `Integer`, `String`, `LocalDate`, `Optional`, etc.

#hr
