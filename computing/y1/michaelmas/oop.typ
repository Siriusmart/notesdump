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

== Data Representation

=== Primitive and Reference Types

#defs([
  - A *primitive value* is a chunk of memory that holds the value of the variable.
  - *Objects* are referred to by reference - the variable links to a separate chunk of memory.
])

#grid2(
  [
    Changes to the block of memory being pointed to willl reflect in both reference variables.

    #note([
      An array is a reference type.
    ])
  ],
  cetz.canvas({
    import cetz.draw : *

    rect((0, 0), (3, 2));
    content((1.5, 1), "Object")

    rect((-3, 1.2), (-1.5, 1.7))
    content((-2.25, 1.45), "0x123")
    line((-1.5, 1.45), (0, 1.45), mark: (end: ">"))
    content((-3.4, 1.45), $a$)

    rect((-3, 0.8), (-1.5, 0.3))
    content((-2.25, 0.55), "0x123")
    line((-1.5, 0.55), (0, 0.55), mark: (end: ">"))
    content((-3.4, 0.55), $b$)
  })
)

=== String Optimisation

A string is immutable and stored in a read-only part of memory. Variables assigned the same string content will have the same reference address from optimisation.

=== The Call Stack

A function puts 3 things on the *call stack* when called.
- Local variables created by the function.
- Memory address to jump to when complete (return address).
- A copy of the arguments passed to it.

They are held in the function's *stack frame* in the call stack.

#def([
  A *stack* is a FIFO data structure.
])

*Local variables* are deleted when a stack frame is popped. Static variables have global scope.

#note([
  There is no tail call optimisation in Java.
])

=== The Heap

We cannot resize variables in the stack: that would require moving everything above it on the stack.
*The heap* is more flexible, there are gaps between objects in the heap.

- Primitives and references cannot change size, so they go on the stack.
- Everything else goes on the heap.

=== Pointers and References

#def([
  A *pointer* is a chunk of memory that holds an address to another memory.
])

#tab2(
  [Pointers], [References],
  [Can be treated like numbers, can do arithmetic with it.], [References are restricted pointers.],
  [Gives us raw memory access (which could be dangerous).], [],
  [No way to test if a pointer is valid.], [References can be tested.],
)

C, C++ Supports both references and pointers, ML and Java only allow references.

#hr

=== Pass by Value/Reference

- *All Java parameters are pass by value.* These _values_ passed to a function can include references that points to an object in heap.
- In C, the variables passed to a function can point to a variable from the calling function.

== Inheritance

Inheritance is where a *subclass* inherits state and functionality from a *superclass*.
- Subclass use the `extend` keyword to inherit from a superclass.
- The subclass can directly access public and protected members of the superclass.

All Java classes must inherit from some other class, if not specfied it will inherit from `java.lang.Object`.
```java
public class MyClass; // will be replaced by the compiler as:
public class MyClass extends Object;
```

In a UML diagram, inheritance is an unfilled arrow pointing towards the superclass.

```java
class A;
class B extends A;
class C extends B;
```

When constructor is not explicitly written for `C`, when creating `C`, we will call:
+ Constructor of `C`
+ Which calls the constructor of `B`
+ Which calls the constructor of `A`

We can explicitly call the constructor of the superclass with `super()`;

=== Type Casting

- *Widening conversion* cast up the tree, e.g. $C to B to A$
- *Narrowing conversion* is checked at runtime, if the type does not match will cause type errors.

```java
B b1 = new C()
B b2 = new B();

C c1 = (C) b1; // ok
C c2 = (C) b2; // type error
```

=== Shadowing

If a variable in the subclass has the same name as the superclass, we can specify where the variable comes from.
```java
// running in C
// these are all different variables
this.x = 10;
((B) this).x = 20;
((A) this).x = 30;
```

#note([
  This is very ugly, please avoid at all cost.
])

=== Overriding

#def([
  *Annotations* are not part of the language, but hints to the compiler so it can perform stricter checks.
])

Use the `@Override` annotation to make sure it overrides a function from superclass.
```java
@Override
public void myFunc();
```

#defs([
  - An *abstract class* forces a subclass to override abstract methods.
  - An *abstract method* has no implementation.
])

- In UML, an abstract class has _italic_ name if drawn in computer, { curly braces } if drawn by hand.
- Interfaces just have the word "interface" in an UML diagarm.

Interface groups classes that implements a set of methods.

=== Inheritance vs Composition

- Inheritance represents an _is-a_ relationship.
- Composition represents a _has-a_ relationship.

#grid2(
  [
    Implementation of a stack with inheritance (inapproprite)
    ```java
    class Stack extends Vector;
    ```
  ],
  [
    A better implementation uses composition.
    ```java
    class stack {
      private Vector internal;
    }
    ```
  ]
)

#hr

== Polymorphism

- *Subtyping polymorphism* is where many kinds of objects provide the same method.
- *Parametric polymorphism* uses generics.
- *Ad-hoc polymorphism* uses overloading.

#grid2([
  *Static polymorphism* decides the function to run at runtime.
  ```java
  Person p = new Student();
  p.dance(); // this runs Person::dance()
  ```

  Java applies dynamic polymorphism on state and static methods.
],
[
  *Dynamic polymorphism* decides at runtime when we know the child's type.
  ```java
  Person p = new Student();
  p.dance(); // this runs Student::dance()
  ```

  Java applies dynamic polymorphism on methods.
]
)

#note([
  Dynamic polymorphism has a runtime overhead.
])

Polymorphism allows:
- Less changes needed to add features.
- So less likely to make mistakes.

=== Multiple Inheritance

Inheriting from multiple classes causes name clash called the *diamond problem*.

#grid2(
  [
    There will be loads of state and method name clashes.

    What should happen if we call `plumbtrician.doJob()`?

    In Java
    - Classes can have at most 1 direct parent.
    - But multiple interfaces are allowed: interfaces don't have implementations, it just says the class must provide the methods.

      If the interfaces require the same method that's fine.

      #note([
        Interfaces can have *default implementations*, so new functions can be added without breaking existing classes (that implements the interface).
      ])
    ],
    cetz.canvas({
      import cetz.draw : *

      rect((0, 0), (2, 1))
      content((1, 0.5), "Employee")

      rect((0-2, 0-2.5), (2-2, 1-2.5))
      content((3, -2), "Electrician")
      rect((0+2, 0-2.5), (2+2, 1-2.5))
      content((-1, -2), "Plumber")

      rect((0-0.2, 0-5), (2 +0.2, 1-5))

      line((-1, -1.5), (-1, -0.75), (1, -0.75), (1, 0), mark: (end: ">"))
      line((3, -1.5), (3, -0.75), (1, -0.75), (1, 0), mark: (end: ">"))

      line((1, -4), (1, -3.25), (-1, -3.25), (-1, -2.5), mark: (end: ">"))
      line((1, -4), (1, -3.25), (3, -3.25), (3, -2.5), mark: (end: ">"))

      content((1, -4.5), "Plumbtrician")
    })
  )

=== Method Resolution

When there is a name clash, the resolution priority from highest to lowest is
+ Class methods
+ Interface methods
+ Methods from superclass

To call a default method from an interface, write
```java
class MyClass implements InterA, InterB {
  public void myMethod() {
    InterA.super.myMethod(); // calls InterA implementation
    InterB.super.myMethod(); // calls InterB implementation
  }
}
```

== OOP Principles

=== OCP: Open to extension, Close to modification
- Make classes easy to add new behaviour.
- But hard to change existing behaviour.

=== LSP: Liskov Substitution Principle

Subtypes must be behaviourally substitute to the parent type without negative side effects.

E.g. code below is not behaviourally substitute for the interface it is implementing.
```java
class MyClass implements InterA {
  public void myMethod() {
    throw new UnsupportedOperationException("myMethod");
  }
}
```

#hr
