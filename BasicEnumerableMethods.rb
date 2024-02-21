=begin
	
Basic Enumerable Methods - Основные методы перечислений
В предыдущих уроках вы узнали о циклах, а также о массивах и хэшах. Вы скоро обнаружите, что вам придется много раз итерировать (повторять что-то несколько раз) 
по коллекциям в качестве разработчика, что может вызвать головокружение. Помните подход DRY (Don’t Repeat Yourself), о котором мы говорили в уроке о методах? 
Ну, Ruby продолжает следовать принципу DRY с помощью чего-то, называемого перечисляемыми объектами.

Перечисляемые объекты - это удобный набор встроенных методов в Ruby, которые включены как часть как массивов, так и хэшей. Существуют некоторые шаблоны итерации, 
которые вы будете делать снова и снова, такие как преобразование, поиск и выбор подмножеств элементов в ваших коллекциях. Перечисляемые объекты были разработаны 
для упрощения реализации этих шаблонов итерации (и, следовательно, вашей жизни как разработчика) намного, намного проще.

Мы пройдемся по перечисляемым методам, которые вы будете чаще всего использовать и встречать на практике. Это, конечно, не исчерпывающий список, поэтому обязательно 
ознакомьтесь с документацией Ruby, чтобы узнать, что еще предлагает модуль Enumerable.

--------------------------------------------------------------------------------------------------------------------------------------------------
Жизнь до перечислений

Предположим, что вы хотите составить список гостей на свой день рождения, используя массив ваших друзей, но не хотите приглашать своего друга Брайана, 
потому что он немного странный на вечеринках и всегда выпивает слишком много.

С помощью циклов, которые вы изучили до сих пор, вы могли бы сделать что-то вроде этого:
=end

friends = ['Sharon', 'Leo', 'Leila', 'Brian', 'Arun']   # Создается массив friends, содержащий имена друзей
invited_list = []  # Cоздается пустой массив invited_list, в который будут добавляться имена друзей, кроме "Brian"

for friend in friends do  # Выполняется цикл for, который перебирает каждого друга в массиве friends
  if friend != 'Brian'
  invited_list.push(friend) # Eсли имя друга не равно "Brian", то это имя добавляется в массив invited_list с помощью метода push
  end
end

puts invited_list.inspect #=> ["Sharon", "Leo", "Leila", "Arun"]

=begin
	
Это не слишком сложно, но представьте, что вам придется делать это для каждой вечеринки, которую вы устраиваете сейчас и до конца времен! 
Было бы проще просто перестать общаться с Брайаном.
	
=end

friends = ['Sharon', 'Leo', 'Leila', 'Brian', 'Arun']

puts friends.select { |friend| friend != 'Brian' } #|friend| используется для объявления блока кода, который принимает один параметр (в данном случае friend). 
# Этот параметр представляет собой текущий элемент массива, который проходится блоком кода.
# Таким образом, выражение |friend| говорит Ruby, что внутри блока кода будет использоваться переменная friend, которая будет представлять собой каждый элемент 
# массива при каждой итерации

friends = ['Sharon', 'Leo', 'Leila', 'Brian', 'Arun']

puts friends.reject { |friend| friend == 'Brian' }
 #=> ["Sharon", "Leo", "Leila", "Arun"]

# ----------------------------------------------------------------------------------------------------------------------------------------------------
=begin
	
Метод each
Метод #each является дедушкой среди методов перечислений, oн может сделать всё. Однако, как вы увидите в течение этого урока, то, что вы можете использовать 
#each для практически любой задачи, не означает, что это всегда лучший или наиболее эффективный инструмент для выполнения задачи.

Вызов метода #each для массива пройдет по этому массиву и передаст каждый элемент в блок кода, где можно выполнить определенную задачу:
	
=end

friends = ['Sharon', 'Leo', 'Leila', 'Brian', 'Arun']

puts friends.each { |friend| puts "Hello, " + friend }

#=> Hello, Sharon
#=> Hello, Leo
#=> Hello, Leila
#=> Hello, Brian
#=> Hello, Arun
#=> ["Sharon", "Leo", "Leila", "Brian" "Arun"]

=begin
	
Что, если в блок, который вы хотите передать методу, требует больше логики, чем можно поместить в одну строку, то это начинает выглядеть менее читаемо и громоздко. 
Для многострочных блоков принято использовать синтаксис do...end вместо {...}:
	
=end

my_array = [1, 2]

my_array.each do |num|
  num *= 2
  puts "The new number is #{num}."
end

#=> The new number is 2.
#=> The new number is 4.

=begin
	
#each также работает для хэшей с небольшим дополнительным функционалом. По умолчанию каждая итерация передаст в блок как ключ, так и значение отдельно или 
вместе (в виде массива), в зависимости от того, как вы определите переменную блока:

=end

my_hash = { "one" => 1, "two" => 2 }

my_hash.each { |key, value| puts "#{key} is #{value}" }

#=> one is 1
#=> two is 2

my_hash.each { |pair| puts "the pair is #{pair}" }

#=> the pair is ["one", 1]
#=> the pair is ["two", 2]

#----------------------------------------------------------------------------------------------------------------------------------------------------

=begin

The each_with_index method

Этот метод почти такой же, как #each, но предоставляет дополнительную функциональность, передавая две переменные блока вместо одной при итерации по массиву. 
Значение первой переменной - это сам элемент, в то время как значение второй переменной - это индекс этого элемента в массиве. Это позволяет выполнять более 
сложные действия.

Например, если мы хотим напечатать только каждое второе слово из массива строк, мы можем сделать это следующим образом:
Здесь используется метод each_with_index для перебора элементов массива fruits вместе с их индексами. На каждой итерации переменная fruit принимает значение 
текущего элемента массива, а переменная index - его индекса.

Условие if index.even? проверяет, является ли индекс четным числом. Если да, то выполняется код в блоке {|fruit, index| puts fruit}, который выводит на экран 
текущий элемент массива (переменная fruit). Если индекс нечетный, то элемент не выводится.

Таким образом, в результате выполнения этого кода на экран будет выведено только каждый второй элемент массива fruits: "apple" и "strawberry".

=end

fruits = ["apple", "banana", "strawberry", "pineapple"]

fruits.each_with_index { |fruit, index| puts fruit if index.even? }

#----------------------------------------------------------------------------------------------------------------------------------------------------

=begin 

The map method:
Помнишь, как мы пытались использовать #each, чтобы записать все имена твоих друзей заглавными буквами? Для справки, вот код, который мы попробовали:

friends = ['Sharon', 'Leo', 'Leila', 'Brian', 'Arun']
friends.each { |friend| friend.upcase }

#=> ['Sharon', 'Leo', 'Leila', 'Brian', 'Arun']

Как мы видим, #each возвращает исходный массив, но это не то, что мы хотим. МЫ ХОТИМ ЗАГЛАВНЫЕ БУКВЫ!
Давайте модифицируем наш код с #each, чтобы заставить его работать:

friends = ['Sharon', 'Leo', 'Leila', 'Brian', 'Arun']
shouting_at_friends = []

friends.each { |friend| shouting_at_friends.push(friend.upcase) }
#=> ['Sharon', 'Leo', 'Leila', 'Brian', 'Arun']

shouting_at_friends #=> ['SHARON', 'LEO', 'LEILA', 'BRIAN', 'ARUN']

Это работает! Однако это потребовало немного дополнительной работы. Нам пришлось ввести еще один массив, который мог бы хранить преобразованные элементы. 
Этот код начинает выглядеть более громоздко и подозрительно напоминает пример с циклом for из первого раздела, от которого мы пытаемся избавиться.

К счастью, у нас есть метод #map для перечисления, который спасает нас от наших страданий!

=end

friends = ['Sharon', 'Leo', 'Leila', 'Brian', 'Arun']

puts friends.map { |friend| friend.upcase }
#=> `['SHARON', 'LEO', 'LEILA', 'BRIAN', 'ARUN']`

my_order = ['medium Big Mac', 'medium fries', 'medium milkshake']

puts my_order.map { |item| item.gsub('medium', 'extra large') }  # Метод .gsub в Ruby используется для замены всех вхождений определенного подстроки в строке 
#другой подстрокой
#=> ["extra large Big Mac", "extra large fries", "extra large milkshake"]

salaries = [1200, 1500, 1100, 1800]

puts salaries.map { |salary| salary - 700 }
#=> [500, 800, 400, 1100]

#---------------------------------------------------------------------------------------------------------------------------------------------------
=begin

Метод select
Вы уже видели метод #select в действии в начале этого урока в нашем стремлении сделать Брайана изгоям.
Метод #select (также называемый #filter) передает каждый элемент массива в блок кода и возвращает новый массив только с элементами, для которых условие, 
установленное в блоке, оценивается как true.
=end

responses = { 'Sharon' => 'yes', 'Leo' => 'no', 'Leila' => 'no', 'Arun' => 'yes' }
puts responses.select { |person, response| response == 'yes'}
#=> {"Sharon"=>"yes", "Arun"=>"yes"}

#----------------------------------------------------------------------------------------------------------------------------------------------------
=begin 

Метод reduce
Метод #reduce (также называемый #inject) возможно, один из самых сложных для освоения перечислителей для новичков в программировании. Общая идея заключается в том, 
что он принимает массив или хэш и сокращает его до одного объекта. Вы должны использовать #reduce, когда хотите получить на выходе одно значение.

Классическим примером использования #reduce является получение суммы массива чисел. Сначала давайте исследовать, как мы могли бы достичь этого, используя #each:
=end
my_numbers = [5, 6, 7, 8]
sum = 0

my_numbers.each { |number| sum += number }

#=> 26

=begin 
Это не так уж и плохо с точки зрения количества строк кода, но мы должны были ввести временную локальную переменную (sum) вне перечислителя. Было бы гораздо лучше, 
если бы мы могли сделать все это внутри перечислителя:
=end

my_numbers = [5, 6, 7, 8]

puts my_numbers.reduce { |sum, number| sum + number }
#=> 26

=begin 
Мы также можем установить другое начальное значение для аккумулятора, передав значение непосредственно в метод #reduce.
Этот код использует метод reduce для обработки массива my_numbers. Исходное значение аккумулятора задается как 1000 (передается в метод reduce в качестве аргумента). 
Затем для каждого элемента массива my_numbers выполняется блок кода, где текущее значение аккумулятора (sum) складывается с текущим элементом массива (number). 
Результат суммирования сохраняется в аккумуляторе для следующей итерации.

Таким образом, код выполняет следующие операции:

Итерация 1: sum = 1000 + 5 = 1005
Итерация 2: sum = 1005 + 6 = 1011
Итерация 3: sum = 1011 + 7 = 1018
Итерация 4: sum = 1018 + 8 = 1026
И наконец, метод reduce возвращает окончательное значение аккумулятора, которое в данном случае равно 1026.

=end

my_numbers = [5, 6, 7, 8]

puts my_numbers.reduce(1000) { |sum, number| sum + number }
#=> 1026

votes = ["Bob's Dirty Burger Shack", "St. Mark's Bistro", "Bob's Dirty Burger Shack"]

result = votes.reduce(Hash.new(0)) do |result, vote|
  result[vote] += 1
  result
end

puts result
#=> {"Bob's Dirty Burger Shack"=>2, "St. Mark's Bistro"=>1}

#-------------------------------------------------------------------------------------------------------------------------------------------------
=begin 

Методы с восклицательным знаком
Ранее мы упоминали, что перечислители, такие как #map и #select, возвращают новые массивы, но не изменяют массивы, на которых они были вызваны. Это сделано 
намеренно, поскольку мы часто не хотим изменять исходный массив или хэш, и не хотим случайно потерять эту информацию. Например, если бы перечислители мутировали 
исходный массив, то использование #select для фильтрации Брайана из списка приглашений навсегда бы удалило его из списка наших друзей. Вау! Это немного радикально. 
Брайан может быть странным на вечеринках, но он все равно наш друг.

=end

friends = ['Sharon', 'Leo', 'Leila', 'Brian', 'Arun']

friends.map { |friend| friend.upcase }
#=> `['SHARON', 'LEO', 'LEILA', 'BRIAN', 'ARUN']`

puts friends
#=> ['Sharon', 'Leo', 'Leila', 'Brian', 'Arun']

friends = ['Sharon', 'Leo', 'Leila', 'Brian', 'Arun']

friends.map! { |friend| friend.upcase }
#=> `['SHARON', 'LEO', 'LEILA', 'BRIAN', 'ARUN']`

puts friends
#=> `['SHARON', 'LEO', 'LEILA', 'BRIAN', 'ARUN']`

#---------------------------------------------------------------------------------------------------------------------------------------------------------
=begin 

Значения, возвращаемые перечислителями
Итак, если использование методов с восклицательным знаком не является хорошей идеей, но нам нужно повторно использовать результат метода перечислителя в 
нашей программе, что мы можем сделать вместо этого?

Один из вариантов - поместить результат метода перечислителя в локальную переменную:

=end

friends = ['Sharon', 'Leo', 'Leila', 'Brian', 'Arun']

invited_friends = friends.select { |friend| friend != 'Brian' }

friends
#=> ['Sharon', 'Leo', 'Leila', 'Brian', 'Arun']

invited_friends
#=> ["Sharon", "Leo", "Leila", "Arun"]

# Еще лучшим вариантом было бы обернуть ваш метод перечислителя в определение метода:

friends = ['Sharon', 'Leo', 'Leila', 'Brian', 'Arun']

def invited_friends(friends)
  friends.select { |friend| friend != 'Brian' }
end

puts friends
#=> ['Sharon', 'Leo', 'Leila', 'Brian', 'Arun']

puts invited_friends(friends)
 #=> ["Sharon", "Leo", "Leila", "Arun"]