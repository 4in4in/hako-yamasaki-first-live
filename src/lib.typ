// Функции вёрстки сборника.
//
// lyrics(src, header: ...) принимает текст, в котором каждая строка —
// это строка таблицы, а ячейки разделены символом «|»:
//
//     японский | транскрипция | перевод
//
// Пустая строка — промежуток между строфами. Строка без «|» выводится
// по центру курсивом на всю ширину (используется в приложении 3).
// Внутри ячеек можно писать разметку Typst, например #footnote[...].

#let in-outline = state("in-outline", false)

// Сноска к заголовку, которая не попадает в оглавление.
#let title-note(note) = context {
  if note != none and not in-outline.get() { footnote(note) }
}

#let song(jp, ru, note: none, body) = {
  heading(level: 2, [#jp (#ru#title-note(note))])
  body
}

#let appendix(title, note: none, body) = {
  heading(level: 1, [#title#title-note(note)])
  body
}

#let lyrics(src, header: none, gap: 0.7em) = {
  let sep = regex("\\s*\\|\\s*")
  let lines = src.split("\n")
  let data = lines.filter(l => l.trim() != "").map(l => l.split(sep))
  let ncols = calc.max(..data.map(r => r.len()))
  if header != none { ncols = calc.max(ncols, header.len()) }
  let spacer = table.cell(colspan: ncols, inset: 0pt, v(gap))

  let cells = ()
  if header != none {
    for h in header { cells.push(strong(h)) }
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
