# rogpe [ Calculator Project ]

TDD - RSPEC | Ruby

Exemplo da aplicação: 

[www.about.me/rodolfopeixoto](http://www.about.me/rodolfopeixoto) 

Versão do Projeto 0.1
================

Sobre esta versão
---------------------
Site desenvolvido:
Utilizei: 
 - Ruby 2.4
 - RSpec 3.7

 - GEMs

``` 
 gem 'spring-commands-rspec', group: :development
```

 Utilize o comando abaixo para gerar o /bin/rspec
 
 ```
 bundle exec spring binstub rspec
 ```

```
gem install faker
```

ATENÇÃO
---------------------


Configuração inicial
---------------------


Documentação
----------------------


### Factory Bot Rails

**create** ou **build**

O **build** cria uma instância e não salva no banco de dados.
O **create** cria e salva no banco de dados.

```
require 'rails_helper'

RSpec.describe Customer, type: :model do
  it 'Create a Customer' do
    customer = create(:customer)
    expect(customer.full_name).to eq("Sr. Rodolfo Peixoto")
  end
end

```



#### Faker

```
require 'rails_helper'

RSpec.describe Customer, type: :model do
  it 'Create a Customer' do
    customer = create(:customer)
    expect(customer.full_name).to start_with("Sr. ")
  end

  it { expect{ create(:customer) }.to change{Customer.all.size}.by(1) }
end

```

```
FactoryBot.define do
  factory :customer do
    name Faker::Name.name  
    email Faker::Internet.email
  end
end

```


#### Override

```
require 'rails_helper'

RSpec.describe Customer, type: :model do
  it '#full_name - Override attributes' do
    customer = build(:customer, name: 'Rodolfo Gomes Peixoto')
    expect(customer.full_name).to eq("Sr. Rodolfo Gomes Peixoto")
  end
end


```

#### Aliases

```
FactoryBot.define do
  factory :customer, aliases: [:user] do
    name Faker::Name.name  
    email Faker::Internet.email
  end
end

```


#### Herança (FactoryBot)

A herança nada mais é do que os factories alinhados, como abaixo.

**OBS** Caso você adicione só customer e tendo valores obrigatórios em vip e days_to_pays por exemplo,
vip e days_to_pay receberá null, pois ele não entrar dentro do factory.

```
customer = build(:customer)
expect(customer.vip).to be nil
```

```
FactoryBot.define do
  factory :customer, aliases: [:user] do
    name Faker::Name.name  
    email Faker::Internet.email

    factory :customer_vip do
      vip true
      days_to_pay 30
    end

    factory :customer_default do
      vip false
      days_to_pay 15
    end
  end
end

```


```
require 'rails_helper'

RSpec.describe Customer, type: :model do
  it '#full_name - Override attributes' do
    customer = build(:customer, name: 'Rodolfo Gomes Peixoto')
    expect(customer.full_name).to eq("Sr. Rodolfo Gomes Peixoto")
  end
  it 'Customer default' do
    customer = build(:customer_default)
    expect(customer.vip).to be false
  end
  it 'Customer vip' do
    customer = build(:customer_vip)
    expect(customer.vip).to be true
  end
  it 'Customer ' do
    customer = build(:customer)
    expect(customer.vip).to be nil
  end
  it 'Customer with days_to_pay nil' do
    customer = build(:customer)
    expect(customer.days_to_pay).to be nil
  end

  it { expect{ create(:customer) }.to change{Customer.all.size}.by(1) }
end

```

### Links diretos:


Desenvolvimento
---------------------
-   [Rodolfo Peixoto](http://www.rogpe.me)
