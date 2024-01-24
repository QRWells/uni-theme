#import "@preview/tablex:0.0.8": tablex, rowspanx, colspanx
#import "@preview/polylux:0.3.1": *
#import "uni-theme-jp.typ": *

// define theme colors
#let color-a = rgb("04364A");
#let color-b = rgb("176B87");
#let color-c = rgb("448C95");

#show: uni-theme.with(
  short-author: "論文太郎",
  short-title: "短いタイトル",
  date: datetime(year:2024, month: 2, day:2),
  color-a: color-a,
  color-b: color-b,
  color-c: color-c,
)

#title-slide(
  title: "論文のタイトル",
  authors: ("論文太郎", "論文花子"),
  subtitle: "サブタイトル",
  lab-name: "XXX",
  institution-name: "XXX大学",
)

#slide(title: [概要], sub-title: [この発表に何がある], new-section: [導入])[

== 動機

- なぜこの研究を行ったのか？

== 貢献

- 何をしたのか？
- 何ができるようになったのか？

]

#slide(title: [例], new-section: [内容])[

- 引用は @madje2022programmable のように書く
- コードは`a + b = c`のように書く

```cpp
#include <iostream>
```

]

#slide(title: [参考文献], new-section: [])[
  #set text(size: 15pt)
  #bibliography(title:none, style: "the-institution-of-engineering-and-technology","ref.bib")
]