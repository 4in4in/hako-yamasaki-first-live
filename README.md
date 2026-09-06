# Хако Ямасаки – «Первый концерт» / 山崎ハコ・ファーストライブ

Русский перевод и транскрипция всех песен концертного альбома
Хако Ямасаки «First Live» (1976), с примечаниями и переводом
реплик между композициями.

Готовый PDF: **https://4in4in.github.io/hako-yamasaki-first-live/**

## Структура

```
src/main.typ            общий макет, колонтитулы, порядок разделов
src/meta.typ            автор, годы, лицензия — то, что печатается на титуле и в подвале
src/lib.typ             функции song / appendix / lyrics
src/front.typ           титульный лист
src/transcription.typ   «О транскрипции»
src/songs/*.typ         по файлу на песню
src/appendix/*.typ      приложения
fonts/                  Zen Antique (SIL OFL)
site/                   страница для GitHub Pages
```

Каждая песня записана как таблица из трёх колонок,
по строке на строку текста, ячейки разделены `|`:

```
японский | транскрипция | перевод
```

Пустая строка — промежуток между строфами. Внутри ячейки можно
использовать разметку Typst, например `#footnote[...]`.

## Сборка

Нужен [Typst](https://typst.app/) 0.13 или новее.

```sh
typst compile --root . --font-path fonts src/main.typ build/hako-yamasaki-first-live.pdf
```

Для правки с живым обновлением:

```sh
typst watch --root . --font-path fonts src/main.typ build/hako-yamasaki-first-live.pdf
```

## Публикация

При каждом пуше в `main` GitHub Actions собирает PDF и выкладывает его
вместе со страницей из `site/` на GitHub Pages. При пуше тега вида `v*`
PDF дополнительно прикрепляется к GitHub Release.

## Лицензия

Русский перевод, транскрипция и примечания распространяются по лицензии
[Creative Commons Attribution-NonCommercial-NoDerivatives 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/deed.ru)
(CC BY-NC-ND 4.0). Их можно свободно читать и распространять с указанием
автора; нельзя изменять и использовать в коммерческих целях.

Права на оригинальные японские тексты песен принадлежат их авторам.
Английские переводы в приложениях 1 и 2 взяты из открытых источников,
указанных в сносках, и приведены для справки.

Шрифт Zen Antique используется по лицензии SIL Open Font License 1.1,
текст лицензии — в `fonts/OFL.txt`.
