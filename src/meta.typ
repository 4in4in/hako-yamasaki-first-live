// Данные, которые попадают на титул, в колонтитулы и в метаданные PDF.
#let author = "4in4in"
#let years = "2024–2026"
#let places = "Санкт-Петербург – Химки – Москва"
#let license = "CC BY-NC-ND 4.0"
#let license-url = "https://creativecommons.org/licenses/by-nc-nd/4.0/deed.ru"
#let source-url = "https://github.com/4in4in/hako-yamasaki-first-live"

// Версия передаётся при сборке: typst compile --input version=v1.0 ...
// (scripts/build.sh и workflow берут её из git describe --tags).
#let version = sys.inputs.at("version", default: "dev")
#let build-date = datetime.today().display("[year]-[month]-[day]")
