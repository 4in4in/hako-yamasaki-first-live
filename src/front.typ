#import "meta.typ": *

#set align(center)

#v(4cm)
#text(size: 30pt)[山崎ハコ]
#v(0.2em)
#text(size: 22pt)[ファーストライブ]

#v(2.5cm)
#text(size: 22pt)[Хако Ямасаки]
#v(0.2em)
#text(size: 17pt)[«Первый концерт»#footnote[В оригинале альбом называется “First Live”, слова записаны японской азбукой катакана.]]

#v(1.5cm)
#text(size: 11pt)[Перевод, транскрипция и примечания: #author]

#v(1fr)

#text(size: 8pt, fill: luma(35%))[
  Русский перевод, транскрипция и примечания © #author, #years. \
  Распространяются по лицензии #link(license-url)[Creative Commons #license]: \
  можно свободно читать и делиться с указанием автора, нельзя изменять и использовать в коммерческих целях. \
  Права на оригинальные тексты песен принадлежат их авторам. \
  Исходники сборника: #link(source-url, source-url)
]

#v(1cm)
#places \
#years.split("–").first()
