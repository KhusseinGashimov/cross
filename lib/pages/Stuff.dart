class Stuff {
  final String name;
  final String crew;
  final String description;
  final String url;
  Stuff(this.name, this.crew, this.description, this.url);
}

List<Stuff> stuffs = [
  Stuff(
      "James Cameron",
      "Director",
      "Дже́ймс Фрэ́нсис Кэ́мерон — канадский кинорежиссёр, чаще всего работавший в жанре фантастического боевика. Кэмерон впервые добился признания как режиссёр фильма «Терминатор». Затем критический и коммерческий успех обрели такие его картины как «Чужие», «Бездна», «Терминатор 2: Судный день» и «Правдивая ложь».",
      "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcRs26JTLwyva-ouQvFgOd7G7tQa4yEzuyZqkcL8qfFRThJrFRAejHzJZVHlmpQfsw5luFuvGA"),
  Stuff("Джон Ландау", "Producers", "Джон Ландау — американский кинопродюсер.",
      "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcQGDEg2ooVKxSJIdMaIGJf9sDgh-nv7hhOSE3FL6e2pNqjTk4c9K7BH7no_Wh47UPZ7Z7teRQ"),
];
