// Tsukushi, a minimal Typst v0.13 template for university coursework reports

#let tsukushi(
  title: "",
  subtitle: "",
  authors: (),
  keywords: (),
  date: datetime.today(),
  deadline: none,
  date-format: "[year]年[month repr:numerical padding:none]月[day padding:none]日",
  lang: "ja",
  font-serif: ("Noto Serif", "Noto Serif CJK JP"),
  font-san: ("Noto Sans", "Noto Sans CJK JP"),
  paper: "a4",
  body,
) = {
  set document(
    title: title,
    author: authors.map(a => a.name),
    keywords: keywords,
    date: date,
  )
  set page(
    numbering: "1",
    number-align: center,
    paper: paper,
  )
  set text(font: font-serif, lang: lang)

  show heading: set text(font: font-san, weight: "medium", lang: lang)
  show heading.where(level: 1): it => pad(top: 1em, bottom: 0.4em, it)

  set par(
    first-line-indent: (amount: 1em, all: true),
    justify: true,
  )

  show figure: it => pad(y: 1em, it)
  show figure.caption: it => pad(top: 0.5em, text(0.8em, it))

  align(center)[
    #block(
      text(
        font: font-san,
        size: 1.9em,
        weight: 700,
        title,
      ),
    )
    #if subtitle != "" {
      block(
        text(
          font: font-san,
          size: 1.4em,
          weight: 700,
          subtitle,
        ),
      )
    }
    #v(1em, weak: true)
  ]

  pad(
    top: 0.75em,
    x: 2em,
    for authors in authors.chunks(3) {
      grid(
        columns: (1fr,) * authors.len(),
        gutter: 1em,
        ..authors.map(author => align(
          center,
          text[
            *#author.name* \
            学籍番号：#author.id \
            所属：#author.affiliation
          ],
        ))
      )
    }
  )


  align(
    center,
    text(
      size: 0.9em,
      if deadline == none {
        date.display(date-format)
      } else [
        締切日：#deadline.display(date-format) \
        提出日：#date.display(date-format)
      ],
    ),
  )

  body
}
