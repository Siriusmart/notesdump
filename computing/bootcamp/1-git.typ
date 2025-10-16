#set page(
  numbering: "1",
  supplement: [p.],
  number-align: right,
  header: [
    #set text(8pt)
    #smallcaps[Computing Bootcamp Notes]
    #h(1fr) _Git and Version Control_
  ],
)

= Intro to Version Control

#block(
  fill: luma(230),
  inset: 8pt,
  radius: 4pt,
)[
  === Definition
  A version control system tracks and manages changes to files over time.
]

== Git and GitHub
- *Git* is a popular VSC.
- *GitHub* is a Git hosting service.


#block(
  fill: luma(230),
  inset: 8pt,
  radius: 4pt,
)[
  === Definitions
- A *commit* records the contents of the files at a specific point of time.
- A *repository* contains all the files being tracked and their history.
]

== Basic Git Commands
=== `git clone <url>`
Creates a local copy of a remote repo.
=== `git diff`
List unstaged changes.
=== `git status`
Similar to `git diff`, but also list untracked files.
=== `git add <filename>`
Add stage a changed file.
=== `git commit -m 'message'`
Creates a new commit with staged files.
=== `git push`
Sends committed changes to a remote repository.
=== `git log`
Shows a list of all commits ever made to the repository.

== Squashing Commits
It is good practice to make frequent commits, so each small change can be reverted. To reduce the number of commits, multiple commits can be *squashed* to a single commit.
```bash
git rebase -i HEAD~3
```
This command includes the last 3 commits in *interactive rebasing*, which opens a text editor.
```diff
pick commit_hash1 message1
pick commit_hash2 message2
pick commit_hash3 message3
```
Replacing `pick` with `squash` will cause the commit to be merged into the `pick` commit above.

You should only squash un-pushed, local commits and *never* remote commits.

== Code Reviews <code-reviews>
#block(
  fill: luma(230),
  inset: 8pt,
  radius: 4pt,
)[
  === Definition
  Code review is the practice of having other developers read and provide feedback on your code before it gets merged into the main project, so code quality can be assured.
]

=== When giving feedbacks
- Ask questions instead of demanding changes.
- Explain your reasoning.
- Comment on the code, not the person.

=== When receiving feedbacks
- Respond to every feedback.
- Don't take it personally.

== Creating Pull Requests

#block(
  fill: luma(230),
  inset: 8pt,
  radius: 4pt,
)[
  === Definitions
  - A *branch* is a separate timeline of commits from the main project.
  - A *pull request* is a formal request to merge code (changes) from one branch to another.
]

=== Create a branch
```bash
git switch -c branch-name
```
=== Push the branch
```bash
git push origin branch-name
```
=== Open a pull request
On GitHub, click *compare and pull request*, where your code #link(<code-reviews>)[can be reviewed].

=== Good PR Practices
As with commits, pull requests should be small and frequent.
