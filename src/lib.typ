// Функции вёрстки сборника.
//
// Текст песни записывается в raw-блоке с пометкой `lyrics`:
//
//     ```lyrics
//     название | название в транскрипции | название по-русски
//
//     японский | транскрипция | перевод
//     ...
//     ```
//
// Каждая строка блока — строка таблицы, ячейки разделены «|».
// Пустая строка — промежуток между строфами. Если первая строфа состоит
// из одной строки, она считается заголовочным рядом и выделяется жирным.
// Строка без «|» выводится по центру курсивом на всю ширину
// (используется в приложении 3). Внутри ячеек работает разметка Typst,
// например #footnote[...].
//
// Правило, которое превращает такие блоки в таблицу, подключается
// в main.typ:  #show raw.where(lang: "lyrics"): it => lyrics(it.text)

#let in-outline = state("in-outline", false)

// Сноска к заголовку, которая не попадает в оглавление.
#let title-note(note) = context {
  if note != none and not in-outline.get() { footnote(note) }
}

// Применяется через  #show: song.with("日本語", "Русское название")
#let song(jp, ru, note: none, body) = {
  heading(level: 2, [#jp (#ru#title-note(note))])
  body
}

// Применяется через  #show: appendix.with("Приложение N: ...")
#let appendix(title, note: none, body) = {
  heading(level: 1, [#title#title-note(note)])
  body
}

#let lyrics(src, gap: 0.7em) = {
  let sep = regex("\\s*\\|\\s*")
  let lines = src.split("\n")

  // Заголовочный ряд: первая строфа из одной строки.
  let header = none
  let first-blank = lines.position(l => l.trim() == "")
  if first-blank != none {
    let head = lines.slice(0, first-blank).filter(l => l.trim() != "")
    if head.len() == 1 and head.at(0).contains("|") {
      header = head.at(0).split(sep)
      lines = lines.slice(first-blank + 1)
    }
  }

  let data = lines.filter(l => l.trim() != "").map(l => l.split(sep))
  let ncols = calc.max(..data.map(r => r.len()))
  if header != none { ncols = calc.max(ncols, header.len()) }
  let spacer = table.cell(colspan: ncols, inset: 0pt, v(gap))

  let cells = ()
  if header != none {
    for h in header { cells.push(strong(eval(h.trim(), mode: "markup"))) }
    cells.push(spacer)
  }
  let prev-blank = true
  for l in lines {
    if l.trim() == "" {
      if not prev-blank { cells.push(spacer) }
      prev-blank = true
      continue
    }
    prev-blank = false
    let parts = l.split(sep)
    if parts.len() == 1 {
      cells.push(table.cell(
        colspan: ncols,
        align: center,
        emph(eval(parts.at(0).trim(), mode: "markup")),
      ))
      continue
    }
    while parts.len() < ncols { parts.push("") }
    for c in parts { cells.push(eval(c.trim(), mode: "markup")) }
  }

  table(
    columns: (1fr,) * ncols,
    stroke: none,
    align: horizon + left,
    inset: (x: 4pt, y: 2pt),
    ..cells,
  )
}
