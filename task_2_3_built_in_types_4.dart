void main() {
  // Задание 4
  // a. Создать Map телефонных номеров с именем numberBook  и типом данных
  // (“имя”: “номер телефона”), заполнить данными:
  // Иван: 2264865, Татьяна: 89523366684, Олег: 84952256575.
  final numberBook = {
    'Иван': '2264865',
    'Татьяна': '89523366684',
    'Олег': '84952256575',
  };

  // b. Вывести на экран весь телефонный справочник numberBook.
  print(numberBook);
  // или:
  numberBook.forEach((key, value) => print('$key: $value') );

  // c. Вставить новый номер в карту: Екатерина: 2359942
  numberBook['Екатерина'] = '2359942';
}
