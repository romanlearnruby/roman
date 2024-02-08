=begin
	
Debugging - отслеживание и исправление как ошибок, так и неожиданного поведения в вашем коде - неизбежная часть работы разработчика. 
Искусство нахождения причины проблем и их устранения в коде известно как отладка. Происхождение этого термина - классическая история из области компьютерных наук.
В этом уроке мы рассмотрим все основные методы, которые вы можете использовать для отладки вашего кода, если возникнут проблемы.

Reading the stack trace - когда ваша программа на Ruby вылетает из-за ошибки, она создает стену текста, известную 
как трассировка стека, которая затем выводится в вашем терминале. Трассировка стека выглядит примерно так:

Traceback (most recent call last):
        3: from /path/to/your/ruby/script.rb:5:in `<main>'
        2: from /path/to/your/ruby/script.rb:3:in `foo'
        1: from /path/to/your/ruby/script.rb:7:in `bar'
/path/to/your/ruby/script.rb:7:in `baz': undefined method `baz' for nil:NilClass (NoMethodError)

тот stack trace сообщает о проблеме в файле /path/to/your/ruby/script.rb. В нем указаны последовательные вызовы функций или методов 
(от самого глубокого к самому верхнему). Каждая строка представляет собой один уровень стека вызовов:

Последний вызов baz в методе bar в строке 7 файла script.rb привел к ошибке.
Метод bar был вызван из метода foo в строке 3.
Метод foo был вызван из основной точки входа программы (метод <main> в строке 5).
Ошибка указывает на то, что на строке 7 была попытка вызвать метод baz на объекте nil, что привело к ошибке NoMethodError

-------------------------------------------------------------------------------------------------------------------------------------------
Debugging with puts
-------------------------------------------------------------------------------------------------------------------------------------------
Процесс отладки заключается в подтверждении предположений о вашем коде, пока вы не найдете что-то, что противоречит вашим предположениям. 
Например, возвращает ли переменная или метод то, что вы ожидаете? Дает ли расчет или итерация по массиву или хэшу ожидаемый вывод?

=end

def isogram?(string)
  original_length = string.length

  p original_length  # => 4

  string_array = string.downcase.split

  p string_array    # => ["odin"]

  unique_length = string_array.uniq.length

  p unique_length   # => 1

  original_length == unique_length

end

puts isogram?("Odin")

#=> false

=begin
	
----------------------------------------------------------------------------------------------------------------------------
Debugging with puts and nil
----------------------------------------------------------------------------------------------------------------------
Использование puts - отличный способ отладки, но есть ОГРОМНОЕ предостережение при его использовании: вызов puts на чем-либо, что является nil 
или пустой строкой или коллекцией, просто выведет пустую строку в ваш терминал.

Это один из случаев, когда использование p приведет к большему количеству информации. Как упоминалось выше, p - это комбинация puts и #inspect, 
последний из которых по сути печатает строковое представление того, на чем он вызван. Чтобы проиллюстрировать это, попробуйте следующее в REPL:

puts "Using puts:"
puts []
p "Using p:"
p []

----------------------------------------------------------------------------------------------------------------------------------
Debugging with Pry-byebug
------------------------------------------------------------------------------------------------------------------------
Pry - это Ruby-дополнение, которое предоставляет интерактивную оболочку REPL во время выполнения вашей программы. REPL, предоставленный Pry, очень похож 
на IRB, но имеет дополнительные функции. Рекомендуемый Ruby-дополнение для отладки - Pry-byebug, и оно включает в себя Pry в качестве зависимости. 
Pry-byebug добавляет отладку пошагово и навигацию по стеку.

Чтобы использовать Pry-byebug, сначала вам нужно установить его в вашем терминале, выполнив команду gem install pry-byebug. Затем вы можете сделать 
его доступным в вашей программе, добавив его в верхней части вашего файла с помощью require 'pry-byebug'. Наконец, для использования Pry-byebug вам 
просто нужно вызвать binding.pry в любой точке вашей программы.

Чтобы следовать этим примерам, сохраните код в файл Ruby (например, script.rb), а затем запустите файл в вашем терминале (например, ruby script.rb)
	
=end

require 'pry-byebug'

def isogram?(string)
  original_length = string.length
  string_array = string.downcase.split

  binding.pry

  unique_length = string_array.uniq.length
  original_length == unique_length
end

isogram?("Odin")

#----------------------------------------------------------------------------------

require 'pry-byebug'

def some_method
  x = 10
  y = 20
  binding.pry # Остановка выполнения программы здесь
  z = x + y
end

some_method

=begin
	
Теперь мы будем использовать команды отладчика pry-byebug для изучения состояния программы

Запустим программу и остановимся на точке останова:
[1] pry(main)> next

Посмотрим на текущее местоположение в коде:
[2] pry(main)> whereami

Просмотрим значение переменной x:
[3] pry(main)> x

Просмотрим значение переменной y:
[4] pry(main)> y

Просмотрим значение переменной z:
[5] pry(main)> z

Продолжим выполнение программы до конца:
[6] pry(main)> continue
	
=end
