#import "lib.typ": *
#import "meta.typ": *

#set document(
  title: "Хако Ямасаки – «Первый концерт»",
  author: author,
  keywords: ("山崎ハコ", "Hako Yamasaki", "перевод", "транскрипция"),
)

#set page(
  paper: "a4",
  margin: (top: 20mm, bottom: 20mm, x: 18mm),
  header: context if counter(page).get().first() > 1 {
    set text(size: 8pt)
    [Хако Ямасаки – «Первый концерт» #h(1fr) 山崎ハコ・ファーストライブ]
  },
  footer: context if counter(page).get().first() > 1 {
    set text(size: 7pt, fill: luma(40%))
    grid(
      columns: (1fr, auto, 1fr),
      align: (left, center, right),
      [© #author, #years],
      text(size: 8pt, fill: black, counter(page).display()),
      link(license-url, license),
    )
  },
)

#set text(font: ("Zen Antique", "Noto Serif CJK JP", "Noto Serif"), size: 10pt, lang: "ru")
#set par(justify: true)
#set heading(numbering: none)
#show heading.where(level: 1): set align(center)
#show heading.where(level: 1): set text(size: 12pt, weight: "bold")
#show heading.where(level: 1): set block(above: 1.4em, below: 1em)
#show heading.where(level: 2): set align(center)
#show heading.where(level: 2): set text(size: 12pt, weight: "bold")
#show heading.where(level: 2): set block(above: 1em, below: 0.8em)
#show table: set text(size: 8pt)
#show table: set par(justify: false)
#show footnote.entry: set par(justify: false)
#show outline: it => {
  in-outline.update(true)
  it
  in-outline.update(false)
}

#include "front.typ"

#pagebreak()
#outline(title: [Оглавление], depth: 2, indent: 1.5em)

#pagebreak()
#include "transcription.typ"

#pagebreak()
= Сторона А
#include "songs/01-harmonica-fuki-otoko.typ"
#pagebreak()
#include "songs/02-kikyou-no-hana.typ"
#pagebreak()
#include "songs/03-crazy-love.typ"
#pagebreak()
#include "songs/04-mizuwari.typ"
#pagebreak()
#include "songs/05-futsukayoi.typ"

#pagebreak()
= Сторона Б
#include "songs/06-hitori-uta.typ"
#pagebreak()
#include "songs/07-kibun-o-kaete.typ"
#pagebreak()
#include "songs/08-sayonara-no-kane.typ"
#pagebreak()
#include "songs/09-kaette-koi.typ"
#pagebreak()
#include "songs/10-mukaikaze.typ"

#pagebreak()
#include "appendix/1-mizuwari-en.typ"
#pagebreak()
#include "appendix/2-hitori-uta-en.typ"
#pagebreak()
#include "appendix/3-between-songs.typ"
