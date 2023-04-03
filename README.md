# EzDiagram

This gem aims to add 'has_many' and 'has_one' relation functionality, so it can produce a class diagram on .png format


Esta gema visa adicionar a funcionalidade de relação 'has_many' e 'has_one', para que possa produzir um diagrama de classes no formato .png

---
## Requirements attended / Requisitos atendidos:

  -  able to find out what are the attributes of the instance and the class and also what are the methods of the instance and the class / capaz de descobrir quais são os atributos da instância e da classe e também quais são os métodos da instância e da classe

  - The class diagram must be generated from any class / O diagrama de classes deve ser gerado a partir de uma classe qualquer
  - From this class all that are related must be discovered and drawn / A partir dessa classe todas que estiverem relacionadas devem ser descobertas e desenhadas
  - It has a method inside of it which output is a dotfile content /Tem um método dentro dele cuja saída é um conteúdo dotfile

---
## Installation / Instalação

Please be sure to have graphviz on your machine before starting the install process
Favor confirmar que possui graphviz em sua maquina antes de começar o processo de instalação

ex: 
```
apt install graphviz
```

then, on the project folder/então na pasta do projeto:
```
./bin/setup
```
---
## Usage / Uso

Add the gem to your project/Adicione a gema ao seu projeto:
```
require 'ez_diagram'

or/ou

gem 'ez_diagram'
```

Insert it's call on the main entity/ Insira sua chamada na entidade principal:

```
class BaseClass
  extend EzDiagram
end
```

Add has_many or has_one where there's need/ Adicione has_many ou has_one aonde for necessário:

```
class Person < BaseClass
  attr_accessor :name, :driver_license, :addresses

  has_one DriverLicense
  has_one AuthorizedDriver
  has_many Address
end
```

---
## "Under the hood" / "Sob o capô":
Inside this gem's gears is built a dot file which will be served to graphviz whos is going to generate a png file at the end of the process.

Dentro das engrenagens desta gema é construído um arquivo dot que será servido ao graphviz que irá gerar um arquivo png ao final do processo.

---
 ## Improvements / Melhorias:

  - refactor code / refatoração de código
  - make more tests / realizar mais testes
  - add 'belongs_to' funtionality / adicionar funcionalidade 'belongs_to'

---
## Tests / Testes:

This gem has tests :D

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests.

Esta gema tem testes :D

Depois de entrar no repositório, execute `bin/setup` para instalar as dependências. Em seguida, execute `rake spec` para executar os testes.

---
## Contributing / Contribuindo:

Bug reports and pull requests are welcome on GitHub at **still to come...**

Bug reports e pull requests são bem vindos no GitHub em **still to come...**

---
## This gem's pendings / pendencias dessa gema:

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).