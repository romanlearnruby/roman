
puts "Romakha".length # => 7

# Интерполяция в Ruby — это способ "вставить" значение переменной или вычислить выражение прямо внутри строки	

name = "Alice" # (В этом примере значение переменной name было интерполировано в строку greeting с использованием #{})
greeting = "Hello, #{name}!"
puts greeting  # => Hello, Alice!

ticket_price = 150
message = "Два билета в кино стоят #{ticket_price * 2} рублей."
puts message

# Поиск в строке

sentence = "У меня есть красивая собака." # (есть строка и вы хотите проверить, содержится ли в ней определенное слово. Для этого вы можете использовать метод .include?)

if sentence.include?("собака")
  puts "В предложении упоминается слово 'собака'."
else
  puts "В предложении нет упоминания слова 'собака'."
end

word = "rubyist" # (Методы .start_with? и .end_with? используются для проверки начинается ли строка с 
# определенной подстроки или заканчивается определенной подстрокой соответственно)

if word.start_with?("rub")
  puts "Строка начинается с 'rub'"
end

if word.end_with?("ist")
  puts "Строка заканчивается на 'ist'"
end

word = "Hello" # (.upcase - преобразует все символы строки в верхний регистр)
puts word.upcase  # Выведет: HELLO

word = "Hello" # (.downcase - преобразует все символы строки в нижний регистр)
puts word.downcase  # Выведет: hello

word = "HeLLo WoRLd" # (.swapcase - меняет регистр всех символов строки на противоположный)
puts word.swapcase  # Выведет: hEllO wOrlD

=begin
	
Примечание:
Если к этим методам добавить !, например, .upcase!, .downcase! или .swapcase!, 
это будет означать, что изменения будут применены непосредственно к объекту строки, к которому применяется метод, без создания новой строки.
Другими словами, методы с ! изменяют исходную строку "на месте".

Подход с использованием ! считается "опасным", потому что он меняет исходное значение. Это может вызвать нежелательные побочные эффекты, 
если исходное значение было бы нужно позже в коде.

=end

# ---------------------------------------------------------------------------------------------------------

# Конкатинация и разбитие строк

# Конкатенация — это процесс объединения двух или более строк в одну

# 1. С помощью оператора +:

str1 = "Hello"
str2 = " World"
puts str1 + str2  # => Hello World

# 2. С помощью метода concat:

str1 = "Hello"
str2 = " World"
str1.concat(str2)
puts str1  # => Hello World

# 3. С помощью символа << (известного также как "shovel operator"):

str1 = "Hello"
str2 = " World"
str1 << str2
puts str1  # => Hello World

# Разбитие строк

# Разбивать строки на подстроки обычно требуется, когда вы анализируете данные или обрабатываете входные значения. В Ruby это можно сделать с помощью метода split

str = "Hello World"
parts = str.split
puts parts.inspect  # => ["Hello", "World"] (Использование inspect делает вывод более понятным, так как мы можем четко видеть, что parts является массивом
# и видим каждый элемент внутри этого массива)

# ----------------------------------------------------------------------------------------------------------------------------------------

# Замена подстрок

str = "Я люблю руби. руби - это круто!" # (Метод .sub заменяет только первое вхождение указанной подстроки)
new_str = str.sub("руби", "Ruby")
puts new_str  # => "Я люблю Ruby. руби - это круто!"

str = "Я люблю руби. руби - это круто!" # (Метод .gsub заменяет все вхождения указанной подстроки)
new_str = str.gsub("руби", "Ruby")
puts new_str  # => "Я люблю Ruby. Ruby - это круто!"

# Более сложная замена:

str = "Цена: 5 долларов. Скидка: 3 доллара." # (Строка, которую мы хотим изменить)

new_str = str.gsub(/\d/, 'X') # (Регулярное выражение /\d/)

# \d - это специальный символ в регулярных выражениях, который означает "любая цифра от 0 до 9"
# /.../ - это литерал регулярного выражения в Ruby, который определяет регулярное выражение внутри слэшей
# В итоге /\d/ будет находить все вхождения одной цифры в строке

puts new_str  # => "Цена: X долларов. Скидка: X доллара."

# -------------------------------------------------------------------------------------------------------------

# Поиск подстроки через регулярное выражение

text = "Мой email: example@mail.com. Есть и другие адреса."

# Регулярное выражение для поиска электронных адресов:
regex = /\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z]{2,}\b/i

# \b соответствует границе слова, что обеспечивает поиск email-адресов, которые являются отдельными словами в тексте
# [A-Za-z0-9._%+-]+ соответствует одной или более букве, цифре, точке, подчеркиванию, проценту, плюсу или минусу перед символом "@"
# @ соответствует символу "@"
# [A-Za-z0-9.-]+ соответствует одной или более букве, цифре, точке или дефису после символа "@"
# \.[A-Z]{2,} соответствует точке, за которой следуют 2 или более буквы (домен верхнего уровня, например, ".com")
# i это модификатор, который делает регулярное выражение нечувствительным к регистру


# Ищем первое соответствие:
match = text.match(regex) # Метод .match возвращает объект MatchData (если находит соответствие) или nil (если соответствие не найдено)

if match
  puts "Найденный email: #{match[0]}" # match[0] содержит полное соответствие регулярному выражению
else
  puts "Email не найден"
end