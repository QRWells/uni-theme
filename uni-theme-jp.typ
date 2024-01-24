#import "@preview/polylux:0.3.1": *

#let theme-colors = state("theme-colors", (:))
#let theme-short-title = state("theme-short-title", none)
#let theme-short-author = state("theme-short-author", none)
#let theme-progress-bar = state("theme-progress-bar", true)
#let theme-date = state("theme-date", datetime.today())
#let theme-sans = state("theme-sans", "Noto Sans CJK JP")
#let theme-serif = state("theme-serif", "Noto Serif CJK JP")

#let uni-theme(
  aspect-ratio: "16-9",
  short-title: none,
  short-author: none,
  date: datetime.today(),
  progress-bar: true,
  color-a: rgb("115E59"),
  color-b: rgb("0A2463"),
  color-c: rgb("815E5B"),
  sans: "Noto Sans CJK JP",
  serif: "Noto Serif CJK JP",
  body
) = {
  set page(
    paper: "presentation-" + aspect-ratio,
    margin: 0em,
    header: none,
    footer: none,
  )
  set text(size: 25pt, font: sans)
  show footnote.entry: set text(size: .6em)
  show link: it => underline(it)
  show raw.where(block: false): box.with(
    fill: luma(245),
    inset: (x: 8pt, y: 1pt),
    outset: (y: 4pt, x : -2pt),
    radius: 4pt,
  )
  show raw.where(block: true): block.with(
    fill: luma(245),
    width: 100%,
    inset: (x: 8pt, y: 4pt),
    outset: (y: 8pt),
    radius: 4pt,
  )

  theme-progress-bar.update(progress-bar)
  theme-colors.update((a: color-a, b: color-b, c: color-c))
  theme-short-title.update(short-title)
  theme-short-author.update(short-author)
  theme-date.update(date)
  theme-sans.update(sans);
  theme-serif.update(serif);

  body
}

#let title-slide(
  title: [],
  subtitle: none,
  authors: (),
  lab-name: none,
  institution-name: none,
  logo: none,
  background-img: none
) = {
  let authors = if type(authors) ==  "array" { authors } else { (authors,) }

  let content = locate( loc => {
    let colors = theme-colors.at(loc)
    let date = theme-date.at(loc)
    if logo != none {
      align(right, logo)
    }
    align(horizon, {
      pad(left: 1em, {
        block(
          inset: 0em,
          breakable: false,
          {
            text(size: 2em, fill: colors.a, strong(title))
            if subtitle != none {
              v(1em, weak: true)
              text(size: 1.25em, fill: colors.a.lighten(25%), subtitle)
            }
          }
        )
        set text(size: 1em)
        grid(
          columns: (1fr,) * calc.min(authors.len(), 3),
          column-gutter: 1em,
          row-gutter: 1em,
          ..authors.map(author => text(fill: black, author))
        )
        if lab-name != none {
          parbreak()
          text(size: .9em, [#lab-name 研究室])
        }
        if institution-name != none {
          linebreak()
          text(size: .8em, institution-name)
        }
        if date != none {
          linebreak()
          text(size: .7em, date.display("[year]年[month padding:none]月[day padding:none]日"))
        }
      })
    })
  })

  set page(
    background: {
      set image(fit: "stretch", width: 100%, height: 100%)
      background-img
    },
    margin: 1em,
  ) if background-img != none

  polylux-slide(content)
}


#let slide(
  title: none,
  sub-title: none,
  header: none,
  footer: none,
  new-section: none,
  body
) = {
  let body = pad(x: 2em, y: .5em, body)
  
  let progress-barline = locate( loc => {
    if theme-progress-bar.at(loc) {
      let cell = block.with( width: 100%, height: 100%, above: 0pt, below: 0pt, breakable: false )
      let colors = theme-colors.at(loc)

      utils.polylux-progress( ratio => {
        grid(
          rows: 2pt, columns: (ratio * 100%, 1fr),
          cell(fill: colors.a),
          cell(fill: colors.c)
        )
      })
    } else { [] }
  })

  let header-text = {
    if header != none {
      header
    } else if title != none {
      if new-section != none {
        utils.register-section(new-section)
      }
      locate( loc => {
        let colors = theme-colors.at(loc)
        let serif = theme-serif.at(loc)
        block(inset: (x: .5em), grid(
          columns: (60%, 40%),
          stack(
            dir: ltr,
            spacing: 5%,
            align(top + left, heading(level: 2, text(fill: colors.a, title))),
            align(bottom + left, text(font: serif, style: "oblique", size: 0.75em, fill: colors.a.lighten(55%), sub-title))
          ),
          align(top + right, text(weight: "bold", fill: colors.b.lighten(80%), utils.current-section)
        )))
      })
    } else { [] }
  }

  let header = {
    set align(top)
    grid(rows: (auto, auto), row-gutter: .5em, progress-barline, header-text)
  }

  let footer = {
    set text(size: 10pt)
    set align(center + bottom)
    let cell(fill: none, it) = rect(
      width: 100%, height: 100%, inset: 1mm, outset: 0mm, fill: fill, stroke: none,
      align(horizon, text(fill: white, it))
    )
    if footer != none {
      footer
    } else {
      locate( loc => {
        let colors = theme-colors.at(loc)
        let date = theme-date.at(loc)
        show: block.with(width: 100%, height: auto, fill: colors.b)
        grid(
          columns: (25%, 1fr, 15%, 10%),
          rows: (1.5em, auto),
          cell(fill: colors.a, theme-short-author.display()),
          cell(theme-short-title.display()),
          cell(fill: colors.c, date.display("[year]/[month]/[day]")),
          cell(fill: colors.c, logic.logical-slide.display() + [~/~] + utils.last-slide-number)
        )
      })
    }
  }

  let top-margin = if sub-title != none { 3em } else { 2.5em }

  set page(
    margin: ( top: top-margin, bottom: 0.6em, x: 0em ),
    header: header,
    footer: footer,
    footer-descent: 0em,
    header-ascent: 0.6em,
  )

  logic.polylux-slide(body)
}

#let focus-slide(background-color: none, background-img: none, body) = {
  let background-color = if background-img == none and background-color ==  none {
    rgb("#0C6291")
  } else {
    background-color
  }

  set page(fill: background-color, margin: 1em) if background-color != none
  set page(
    background: {
      set image(fit: "stretch", width: 100%, height: 100%)
      background-img
    },
    margin: 1em,
  ) if background-img != none

  set text(fill: white, size: 2em)

  logic.polylux-slide(align(horizon, body))
}