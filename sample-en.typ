#import "@preview/tablex:0.0.8": tablex, rowspanx, colspanx
#import "@preview/polylux:0.3.1": *
#import "uni-theme-en.typ": *

// define theme colors
#let color-a = rgb("04364A");
#let color-b = rgb("176B87");
#let color-c = rgb("448C95");

#show: uni-theme.with(
  short-author: "Author 1",
  short-title: "Example Title of the Presentation",
  date: datetime(year:2024, month: 2, day:2),
  color-a: color-a,
  color-b: color-b,
  color-c: color-c,
)

#title-slide(
  authors: ("Author 1", "Author 2"),
  title: "Example Title of the Presentation",
  subtitle: "Approach to solving the problem",
  lab-name: "XXX",
  institution-name: "YYY University",
)

#slide(title: [Outline], sub-title: [What is the problem?], new-section: [Content])[

== Motivation

- What is the problem?

== Contribution

A new approach to solving the problem.
- How does it work?
- What are the results?

]

#slide(title: [Example], new-section: [Content])[

Reference to the table: @madje2022programmable

```rust
enum {
  A { a: u8 },
}
```

]

#slide(title: [Bibliography], new-section: [])[
  #set text(size: 15pt)
  #bibliography(title:none, style: "the-institution-of-engineering-and-technology","ref.bib")
]