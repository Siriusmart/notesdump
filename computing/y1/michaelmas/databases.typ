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

#block(
  fill: luma(230),
  inset: 8pt,
  radius: 4pt,
)[
  === Definitions
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
]

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

#block(
  fill: luma(230),
  inset: 8pt,
  radius: 4pt,
)[
  === Definition
  *Big data* is data too big to fit in primary store.
]

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
#block(
  fill: luma(230),
  inset: 8pt,
  radius: 4pt,
)[
  === Definition
  *Atomicity* is where changes are apparent to all users at once. An overhead is needed to achieve this.
]
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
