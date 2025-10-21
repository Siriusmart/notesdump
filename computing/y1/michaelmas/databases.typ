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
