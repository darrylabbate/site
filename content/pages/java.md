+++
title = "Java II Study Guide"
url   = "/java2"
+++

## Interfaces

### Overriding (`@Override`)
Declaring a method with the same name as a method in a parent class. This is used to define a specific implementation of a method for a particular class.

```java
// Overrides the default toString() implementation
@Override
public String toString() {}
```

### Overloading
Define multiple methods of the same name with different method signatures. The methods must have the same return type, but can have different parameters (both quantity and type).

```java
int add(int);
int add(int, int);
int add(int, int, int);
int add(float, float);
```

### Interface
A class containing analogous methods for the purpose of implementing in subclasses.

```java
interface Bicycle
{
    void changeGear(int newGear);
    void increaseSpeed(int increment);
    void decreaseSpeed(int increment);
}
```
```java
// The compiler will require this class to implement all methods in the
// Bicycle interface.
class MyBicycle implements Bicycle
{
    private int speed = 0;
    private int gear  = 1;

    void changeGear(int newGear)      { gear   = newGear;   }
    void increaseSpeed(int increment) { speed += increment; }
    void decreaseSpeed(int increment) { speed -= increment; }
}
```

### Abstract Class
A superclass that *cannot* be instantiated as its own object or class. Subclasses are extended from abstract classes and inherit all attributes from the superclass.

```java
abstract class GraphicObject
{
    int x, y;
    ...
    void moveTo(int newX, int newY) {
        ...
    }
    abstract void draw();
    abstract void resize();
}
```
```java
class Circle extends GraphicObject
{
    void draw()   {...}
    void resize() {...}
}
class Rectangle extends GraphicObject
{
    void draw()   {...}
    void resize() {...}
}
```

### Abstract Classes vs Interfaces

#### Similarities

* Cannot be instantiated
* May contain a mix of methods declared with or without implementations

#### Differences

* Abstract classes can declare fields that are not `static` and `final`
* Abstract classes can define `public`, `private` and `protected` concrete methods
* In Interfaces, all fields are automatically `public`, `static` and `final`
* In Interfaces, all methods are `public`
* You can only extend one class, but you can implement multiple interfaces.

#### Abstract Class use cases

* Sharing code among several closely related classes
* You need common methods or fields with modifiers other than `public`
* You want to declare non-static or non-final fields

#### Interface use cases

* You expect unrelated classes to implement your interface
* You want to specify behavior of certain data types, but not concerned with who implements this behavior
* Taking advantage of multiple inheritance

---

## Client-Server Model

In the context of Java, the client-server model represents an application structure which defines method invocation as a "contract" between the "client" and the "server."

The client typically commands the server to invoke methods. The idea (in the context of CSCI2120) is to define a series of conditions which must be met in order for the program to execute successfully.

#### Preconditions(`@require`)

* Responsibility of the "client"
* Must be true at the *beginning* of method invocation
* Typically imposes constraints on values of arguments/parameters

#### Postconditions (`@ensure`)

* Responsibility of the "server"
* Must be true at the *end* of method invocation
* Typically imposes constraints on return values

#### Invariants (`@invariant`)

* Responsibility of the "programmer of the server"
* Must be true throughout method invocation
* Typically imposes constraints on instance variables

#### Notes

* If a contract is broken, the "server" guarantees nothing

---

## Testing

#### Functional Testing

Testing the program as a whole

#### Unit Testing

Testing the individual components

#### "White Box" Testing

Testing when given full access to the source code

#### "Gray Box" Testing

Testing when given some access to the source code

#### "Black Box" Testing

Testing when given no access to the source code

#### Test-Driven Implementation

Writing tests before developing the program

#### Implementation-Driven Testing

Testing code after writing the program

---

## Design Patterns

### Adapter

The adapter pattern is used to bridge two objects that would be otherwise incompatible. A real-world analogy would be an adapter for microSD cards to work with normal SD slots.

This pattern can be implemented in Java via either composition or inheritance.

#### Example from class

```java
// Dog.java
public class Dog
{
    // protected keyword allows subtypes direct access
    protected String name;
    protected double height;
    protected double weight;

    public Dog(String name, double height, double weight) {
        this.name = name;
        this.height = height;
        this.weight = weight;
    }

    public String getName()   { return this.name;           }
    public double getWeight() { return this.weight;         }
    public double getHeight() { return this.height;         }
    public void   speak()     { System.out.println("woof"); }
}
```

#### Composition

```java
// Kelb.java (Kelb = Dog in Arabic)
public class Kelb {

    private Dog innerDogness;

    public Kelb(Dog d) {
        innerDogness = d;
    }

    public void ahkey() { innerDogness.speak(); }
}
```

#### Inheritance

```java
public class Kelb extends Dog
{
    public Kelb(String name, double weight, double height) {
        super(name,weight,height);
    }

    public void ahkey() { speak(); }
}
```

### Strategy Pattern

Strategy Pattern is used when classes only differ by their behavior. The example in class was to design a game where a player could be aggressive, timid, zen, etc.

You essentially create a `Strategy` superclass with individual subclasses implementing the `Strategy` superclass. The benefit is a `Player` class only needs to instantiate a `Strategy` object instead of a particular Strategy subclass. Then your "`Runner`" will define the behavior of the `Player`.

### Singleton Pattern

Singleton is used when you need to restrict the amount of instances of a class.

```java
class Singleton
{
    private static Singleton instance;

    private Singleton() {
      ...
    }

    public static synchronized Singleton getInstance()
    {
      if (instance == null) instance = new Singleton();
      return instance;
    }

    public void doSomething() {...}
}
```

The hallmark of the Singleton pattern is a `getInstance()` method, which effectively creates the sole instance of itself.

Furthermore, a `private` constructor guarantees that the class is inaccessible to the outside world.

Use cases for the Singleton pattern include loggers and configuration classes.

### Observer Pattern

The Observer pattern implements a means of monitoring the state of an object, so that dependencies of an object are notified upon change of state.

Key principles of implementing the Observer pattern:

* A class which `implements Observer`
* A class which `extends Observable`

The `Observer` in the implementation must `@Override` `update()`.

The `Observable` defines methods which can call `notifyObservers()` `setChanged()` among others. These methods provide a means for notifying observers of state change.

---

## Serialization

*TODO: Expand this section*

At high, language-agnostic level, serialization is the process of converting data from format to another. The purpose is to be able to perform I/O actions, such as reading from and writing to files.

Serialization is the process of converting an object to binary format, while *writing a formatted text file* id for the purposes of human readable text.

---

## Exceptions

An error is essentially when the program exits with an unchecked failure, i.e. exit code `1`.

An exception is a way to handle errors and define behavior when errors occur.

Checked exceptions are exceptions caught at compile-time, whereas unchecked exceptions are caught at runtime.

### Try/catch

Try/catch blocks are similar to if/else statements. Multiple `catch` statements are allowed after a single `try` statement for catching different types of exceptions. You can also catch multiple exception types in a single `catch` statement with the following syntax:

```java
catch(IOException|FileNotFoundException ex) {...}
```

### Throws

Exception `throws` are for the external method implementation. You define a `throws` as the type of error you want to give to whatever is calling the method.

Example of implementing a custom exception:

```java
class ExamOneException extends Exception
{
    public ExamOneException() {}
    public ExamOneException(String msg) { super(msg); }
    public ExamOneException(Exception e) { super(e); }
    public ExamOneException(String msg, Exception e) { super(msg, e); }
}
```
```java
class ExamOne
{
    int grade;

    public static void main(String[] args) throws ExamOneException
    {
        if (grade < 90) {
            throw new ExamOneException("I should have gotten an A");
        }
    }
}
```

## Recursion

**Recursion** occurs when a function (method) is applied within its own definition.

Recursive functions always have at least one **base case**, which is a terminating scenario that doesn't employ recursion. The remaining rules are designed to funnel all other cases towards a base case, altering input parameters with each successive recursive call.

**Direct recursion** is when a function calls itself directly. An example of  **indirect recursion** is when a function calls a different function, which then calls the original function.

### Example

```c
// Fibonacci sequence (direct recursion)
int fib(int n)
{
  return (n < 2) ? n : fib(n - 1) + fib(n - 2);
}
```

---

## Generics

**Generics** (or parameterized polymorphism in other languages) are a way of specifying methods which can take arguments or return values of varying (but related) types.

As an example, generics are useful for defining methods for sorting arrays of different types.

Generic methods require a type parameter (denoted with diamond brackets `<>`) to specify that the method is generic.

### Bounded Type Parameters

Constraints can be placed on the types of parameters which can be passed to a generic method. Just as **generics** are similar to parameterized polymorphism in Haskell, **upper bounds** are similar to typeclass constraints.

```java
// Constraining the paramaters x, y and z to Comparable instances
public static <T extends Comparable<T>> T max(T x, T y, T z)
{
  ...
}
```
```haskell
-- Doing the same in Haskell
-- Comparable isn't a real thing in Haskell but whatevs
max :: (Comparable a) => a -> a -> a -> a
max x y z = ...
```

### Wildcards

**Wildcards**, unlike **generics**, do not enforce consistency in types for parameters and return values.

### Erasure

**Erasure** is the process of the compiler translating generic parameters, constraints, etc into concrete types.

---

## Data Structures

### List

**`List`** extends `Collection` and supports all operations from it:

```java
void add(int index, Object O) {}           // Adds element at index
boolean addAll(int index, Collection c) {} // Adds all elements from a specified collection to a list
                                           // Not sure why boolean
Object remove(int index) {}                // Removes whatever element is at index
Object get(int index) {}                   // Returns element at index
Object set(int index, Object new) {}       // Replaces element at given index
                                           // Returns the element which was replaced
```

### Queue

First in, first out

### Stack

Last in, first out

Supports push and pop operations
