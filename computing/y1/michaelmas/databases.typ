#import "@preview/cetz:0.4.2"

#set page(
  numbering: "1",
  supplement: [p.],
  number-align: right,
  header: [
    #set text(8pt)
    #smallcaps[Computer Science Lecture Notes]
    #h(1fr) _Databases_
  ],
)

#let definition(title: "Definition", body) = {
  block(
    fill: luma(230),
    inset: 8pt,
    radius: 4pt,
  )[
    === #title
    #body
  ]
}

= Databases

== Storing Data

#table(
  columns: (auto, auto),
  table.header([*Format*], [*Where*]),
  [ Fixed field record ],
  [ Used in punch cards, each record can store 80 characters, some of the 80 characters are allocated to different fields. ],
  [ Comma separted value record ],
  [ More flexible than fixed field records, as there is no character limit to the value of a field. ]
)

A *simple associative store* will have the *API formal specification*.
```ml
store: string * string -> unit
retrieve: string -> string option (* either the value stored, or nothing at all *)
```

#definition([
  #table(
    columns: (auto, auto),
    table.header([*Keyword*], [*Meaning*]),
    [Value],
    [What is being stored.],
    [Field],
    [A place to hold a value.],
    [Schema],
    [A strongly typed specification of the database.],
    [Key],
    [The field(s) used to locate a record.],
    [Index],
    [A derived structure used to quickly find relevant record.],
    [Query],
    [A lookup function.],
    [Update],
    [A modification of data.],
    [Transaction],
    [An atomic change of a set of field.]
  )

  An update is often implemented as a transaction.
], title: "Definitions")

== Abstraction and Interfaces

We hope to have a fairly narrow interface that can map onto many operations. In an ideal world:
- All operations are done through the interface.
- The interface never change.

But in real world, large database projects are often a mess, and fixing the mess sometimes requires changing the interface. Changing interfaces break applications!

=== Logical Arrangement of a Database
The *DBMS* uses the *disc drive*, which is an abstraction over the *secondary storage*. This gives a consistent, nonchanging API which applications can use.

This API is often in form of SQL queries, SQL injection is an example of insecurity in the interface.

=== Operating System View of a Database
The *DBMS* is a process running in userspace.
- An *application* communicates with the *DBMS* through *kernel space communication*.
- Then the *DBMS* use *kernel space drivers* to access the *DBMS*.
An alternative implementation have the *DBMS* access a non-OS partition directly.

Data can be stored in primary store, secondary store, or distributed.

#definition([
  *Big data* is data too big to fit in primary store.
])

== DBMS Operations

#table(
  columns: (auto, auto),
  table.header([*Operation*], [*Description*]),
  [*C*\reate],
  [Insert new data],
  [*R*\ead],
  [Query the database],
  [*U*\pdate],
  [Modify objects in the database],
  [*D*\elete],
  [Remove data]
)

=== Management Operations
- Create/change schema
- Create views
- Indexing/stats generation
- Reorganise data layout and backups

=== Amount of Writing
Database implementation choice depends on the amount of writing.
- A database can have a lot of lookups but rarely changes (e.g. library catalogue).
- *Transaction optimised*: concurrent queries and updates, they will affect the consistency of reads.

#definition([
  *Atomicity* is where changes are apparent to all users at once. An overhead is needed to achieve this.
])
- *Append only journal*: inverse of a transaction optimised DB, data is never updated.

=== Consistency Checks

Consistency rules includes value range check, foreign key referential integrity, value atomicity (all values are atomic), entity integrity (no missing fields).


== Types of Databases
=== Relational Database
Consists of 2D tables.
- One row per record (a.k.a. a tuple), each with a number of fields.
- A table can have a schema.
- The ordering of the fields are unimportant.

=== Distributed Databases
Database can be spread over multiple machines.

#table(
  columns: (auto, auto),
  table.header([*Benefit*], [*Description*]),
  [Scalability],
  [Dataset may be too large for a single machine.],
  [Fault tolerance],
  [Service can survive the failure of some machines.],
  [Lower latency],
  [Data can be located closer to the users.]
)

Downsides: overhead after an update to provide a consistent view.

#table(
  columns: (auto, auto),
  table.header([*Keyword*], [*Meaning*]),
  [*C*\onsistency],
  [All reads return data that is up to date.],
  [*A*\ccessibility],
  [All clients can find some replica of the data.],
  [*P*\artition tolerance],
  [The system continues to operate despite arbitrary message loss or failure of parts of the system.]
)

It is impossible to achieve all 3 in a distributed database. _(why?)_

System that offers *eventual consistency* will eventually reach a consistent state once activity ceases.

#line(length: 100%)

== ER Model

ER model is an implementation independent technique of describing the data we store in a database.

#definition([
  #table(
    columns: (auto, auto, auto),
    table.header([*Keyword*], [*Meaning*], [*Symbol*]),
    [Entity], [Model things in the real world], [Rectangle],
    [Attributes], [Represent properties], [Oval],
    [Key], [Uniquely identifies an entity instance.], [Underline],
  )
], title: "Definitions")

A key can be *composite*. Examples of *natural keys* are a person's name and nation ID unumber. They may not be unique, it is often better to use a *synthetic key* - beware of using keys that are out of your control.

#definition([
  A *synthetic key* is auto-generated by the database and only has meaning within the database.
])

The *scope* of the model is the limited subset of all the real world attributes of the object.

=== Relationship Cardinalities

==== Many-to-many Relationships

- Represented in undecorated lines.
- Any $S$ can be related to 0 or more $T$.
- Any $T$ can be related to 0 or more $S$.

Note relations can also have attributes.

#cetz.canvas({
  import cetz.draw : *

  rect((0, 0), (2, 1))
  rect((8, 0), (10, 1))
  line((4, 0.5), (5, 1), (6, 0.5), (5, 0), (4, 0.5))
  line((2, 0.5), (4, 0.5))
  line((6, 0.5), (8, 0.5))

  content((1, 0.5), "S")
  content((5, 0.5), "R")
  content((9, 0.5), "T")
})

==== Rules for Modelling

- An attributes exists at most once for any entity or relation.
- Rule of atomicity: every value in a box must be atomic (a.k.k. 1NF)

Do not put a comma separated list in the value, more likely than not we will need to break up the list again when searching, which requires text processing.

=== Tenary Relationships

They may be appropriate, depending on use.

#cetz.canvas({
  import cetz.draw : *

  rect((0, 0), (2, 1))
  rect((6, 0), (8, 1))
  rect((3, -2), (5, -1))
  line((3, 0.5), (4, 1), (5, 0.5), (4, 0), (3, 0.5))
  line((2, 0.5), (3, 0.5))
  line((5, 0.5), (6, 0.5))
  line((4, 0), (4, -1))

  content((1, 0.5), "S")
  content((4, 0.5), "R")
  content((7, 0.5), "T")
  content((4, -1.5), "U")
})

What about 3 binary relationships?

#cetz.canvas({
  import cetz.draw : *

  rect((0, 0), (2, 1))
  rect((6, 0), (8, 1))
  rect((12, 0), (14, 1))
  rect((6, -3), (8, -4))
  line((3, 0.5), (4, 1), (5, 0.5), (4, 0), (3, 0.5))
  line((9, 0.5), (10, 1), (11, 0.5), (10, 0), (9, 0.5))
  line((6, -1.5), (7, -2), (8, -1.5), (7, -1), (6, -1.5))
  line((2, 0.5), (3, 0.5))
  line((8, 0.5), (9, 0.5))
  line((11, 0.5), (12, 0.5))
  line((5, 0.5), (6, 0.5))
  line((7, 0), (7, -1))
  line((7, -2), (7, -3))

  content((1, 0.5), "S")
  content((4, 0.5), "X")
  content((10, 0.5), "Y")
  content((7, 0.5), "R")
  content((13, 0.5), "T")
  content((7, -1.5), "Z")
  content((7, -3.5), "U")
})

Which one is appropriate depends on the situation, each entity should represent a real world object.

- *Many-to-one* relationships are denoted by an arrow towards the one end.
- *One-to-one* relationships are denoted by two arrow, one at each end.

If $R$ is both many-to-one and one-to-many between $S$ and $T$, it is one-to-one between $S$ and $T$.

#definition([
  A *bijection* is where every member in one set is related to one member of the other set.
])

One-to-one cardinality doesn't mean one-to-one correspondence: not all elements in $S$ are related to an element in $T$.

=== Weak Entity

#definition([
  The *weak entity* cannot exist without the *strong entity* existing.
])

- E.g. an alternative title (weak) for a movie (strong).
- Has *discriminators*, not keys. Combined with the *key* from the strong entity uniquely defines the weak entity.

=== Entity Hierarchy (OO-like)
- Subentities inherit the attribues and relations of the parent entity.
- Multiple inheritance is possible.
- We represent the relation with an _IS A_ relation (upside down triangle in diagram).

#line(length: 100%)

== The Relational Model

Before the relational model, you need to know about the data's low level representation to write a database application.
- We give the user a model of data and language for manipulating the data that is independent of the implementation details.
- The model is based on mathematical relations.

=== Mathematical Relations

#definition(title: "Definitions", [
  - The *cartesian product* is the set of all possible pairs.
    $
    S times T = { (s, t) | s in S, t in T }
    $
  - A *binary relation* of $S times T$ is any set $R$ with
    $
    R subset.eq S times T
    $
  - $R$ is a *binary relation*.
  - $S$ and $T$ are referred to as *domains*.
])

We are interested in finite relations $R$ that are explicitly stored in a database, which _does not include_ infinite relations like the modulus. (e.g. $6 mod 5 = 1$)

=== N-ary Relations

If we have $n$ domains, then $n$-ary relation $R$ is the set
$
R subset.eq S_1 times S_2 times dots.c times S_n = { (s_1, s_2, dots, s_n) | s_1 in S_1, s_2 in S_2, dots, s_n in S_n }
$

#definition([
  *Tabular presentation* of a relation is where each tuple has a column number.
  #table(
    columns: (auto, auto, auto, auto),
    table.header([*1*], [*2*], [*$dots$*], [*$n$*]),
    $a_1$, $b_1$, $dots$, $x_1$,
    $a_2$, $b_2$, $dots$, $x_2$,
    $a_3$, $b_3$, $dots$, $x_3$,
    $a_4$, $b_4$, $dots$, $x_4$,
  )
])

=== Named Columns

Because referring to tuples by column number is annoying.
- Associate an attribute name $A_i$ with each domain in $S_i$.
- Use records instead of tuples.

#definition([
  A *database relation* is the finite set
  $
  R subset.eq {{(A_1, s_1), (A_2, s_2), dots, (A_n, s_n)} | s_i in S_i}
  $
])

We specify $R$'s schema as $R(A_1: S_1, A_2: S_2, dots A_n: S_n)$.

=== Example: Students

Using the schema _Students(name: string, sid: string, age: integer)_:
```py
Students = {
  { (name, "sirius"), (sid: "12345"), (age: 19) }
}
```

== Query Language

- The input of a query language is a collection of relatin instances $R_1, R_2, dots, R_k$.
- The output is a single relational instance $Q(R_1, R_2, dots, R_k)$.

We want to create a high level query language $Q$ that is independent of the data, there are many ways to do that.

=== The Relational Algebra Abstract Syntax

It is generally a tree structure

#grid(
  columns: (auto, auto),
  column-gutter: 30pt,
  $
  Q &::= \
  &| R wide wide & "base relation" \
  &| sigma_p(Q) & "selection" \
  &| pi_x(Q) & "projection" \
  &| Q times Q & "product" \
  &| Q - Q & "difference" \
  &| Q union Q & "union" \
  &| Q inter Q & "intersection" \
  &| rho_M(Q) & "rename"
  $,
  [
    - $p: x mapsto "bool"$ is a boolaen predicate.
    - $X = { A_1, A_2, dots }$ is a vector (a set of attributes).
    - $M = { A_1 mapsto B_1, A_2 mapsto B_2, dots }$ is a list of mappings that takes in one attribute name, and output another attribute name.

    #definition([
      $Q$ is *well formed* if all attribute names of the result are distinct.
    ])
    - $Q_1 times Q_2$ requires the subqueries to share no column names.
    - $Q_1 union Q_2$ requires the subqueries to share all column names.
  ]
)

=== Mapping RA to SQL

RA is based directly on the underlying set theory.
- Formal semantics/specification works by mapping the query language back to set theory.

=== Operators

#table(
  columns: (auto, auto, auto),
  table.header([*RA*], [*SQL*], [*Notes*]),
  $sigma_(A > 12)(R)$,
  ```sql
  SELECT DISTINCT *
  FROM R
  WHERE R.A > 12
  ```,
  [-],
  $pi_(B,C)(R)$,
  ```sql
  SELECT DISTINCT B, C
  FROM R
  ```,
  [-],
  $rho_({B mapsto E, D mapsto F})(R)$,
  ```sql
  SELECT A, B as E, C, D as F
  FROM R
  ```,
  [
    If we want to swap 2 rows, we will need to rename them one at a time.
  ],
  $R union S$,
  ```sql
  (SELECT * FROM R) UNION
  (SELECT * FROM S)
  ```,
  [
    $R$ and $S$ must have the same schema.
  ],
  $R inter S$,
  ```sql
  (SELECT * FROM R) INTERSECT
  (SELECT * FROM S)
  ```,
  [],
  $R - S$,
  ```sql
  (SELECT * FROM R) EXCEPT
  (SELECT * FROM S)
  ```,
  [
    In set theory, $R - S = R inter (-S)$, but this doesn't make sense on databases, as $-S$ would mean everything that is not in $S$.
  ],
  $R times S$,
  ```sql
  SELECT A, B, C, D
  FROM R
  CROSS JOIN S
  ```,
  [
    In set theory, the cartesian product is a set of tuples. In SQL, that tuple is flattened.
  ]
)

#definition(title: "Note", [
  The *`DISTINCT`* keyword removes duplicates: each $A, B, C, D$ might be unique, but $B, C$ may be not. Not being distinct is fine in SQL but not fine in set theory as a set contains no duplicates.
])

=== The Natural Join

If we ignore domain types and write a relation schema as $R(A)$, where $A={A_1, A_2, dots}$.
- $R(A, B) = R(A union B)$ assumes $A inter B = emptyset$
- $u.[A] = v.[A]$ means $u.A_1 = v.A_1 and u.A_2 = v.A_2 and dots$.
  - For the fields specified, the two records completely agree with each other.

For $R(A, B)$ and $S(B, C)$, define the natural join $R join S$.
$
R join S = { space t | (exists u in R, v in S) space u.[B] = v.[B], space t = u.[A] union u.[B] union v.[C] space}
$

```sql
SELECT *
FROM R
NATURAL JOIN S
```

- If `NULL` values exists, then equality gets more complicated (how?), there are further variations of natural joins (left/right/inner/outer).
- If we want to use a custom predicate, use `WHERE` instead of `NATURAL`.

#line(length: 100%)

== Relational Data Model

How do we store data in a table?

=== Data Redundancy

One approach is to store everything in one big table.

A big table is a redundant data representation, and redundancy can lead to inconsistencies. (Example: movies database)
- We should be able to insert a person without knowing his role in a film.
- If we delete all films about a director, we lose information about the director.
- If a director's name is mispelled, we need to update it for all films.

#definition(title: "Rule", [
  Rule for removing *data redundancy*: store one fact in one place.
])

It also cause performance issues:
- To maintain consistency for every user, a simple transaction involves many things to do.
- Many records have to be locked to maintain atomicity, so it is less concurrent than it could be.

Breaking down tables reduces redundancy, but we will need to do joins which is expensive.
- The naive implementation requires doing a cartesian product, which has quadratic time.
- Actual database implementations uses heuristics to reduce time complexity.

#definition(title: "Rule", [
  The record should semantically depend on the key.

  E.g. timestamp of birth should not be used as the key for a person, as a person's name does not depend on the timestamp.
])

An *all key table* is needed to store a many-to-many relation.

=== Relational Keys

#definition([
  A *relational key* is a unique handle on a record.
])

Let $R(X)$ is a relational schema and $Z subset.eq X$. If for any record $u$ and $v$:
$
u[Z] = v[Z] arrow.double.long u[X] = v[X]
$
Then $Z$ is a *superkey* of $R$.

If no proper subset of $Z$ is a key for $R$, then $Z$ is a *key* for $R$. Then for $R(Z union Y)$, we write
$
R(underline(Z), Y)
$

=== Foreign Key

Suppose we have $R(Z, Y)$, let $S(W)$ be a relational schema where $Z subset.eq W$. We say $Z$ represents a foreign key in $S$ for $R$ if for any instance
$
pi_Z (S) subset.eq pi_Z (R)
$
Think of the foreign key as a pointer.

A foreign key is denoted with an overline.

#definition([
  A database has *referential integrity* when all foreign key constrains are satisfied.
])

=== Simplifying Relations

We can combine tables together using *type tags* to reduce the number of tables.

#grid(
  columns: (auto, auto),
  column-gutter: 30%,
  [
    ==== Before
    $
    R(underline(X\, Z), U) \
    Q(underline(X\, Z), V)
    $
  ],
  [
    ==== After
    $
    R Q (underline(X\, Z\, "type"), U, V)
    $
    Where $"type" = {u, v}$.
  ]
)

Notice all attributes are still semantically dependent on the key.
- Advantage: one less table, so less joins needed.
- Disadvantage: if a record does not have a relation, then the field storing the attribute will be `NULL`.
