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


#### attributes_for()

O attributes_for retorna um hash com do registro passado por parâmetro.

```
  it 'Use the attributes_for' do
    attrs = attributes_for(:customer)
    attrs1 = attributes_for(:customer_vip)
    attrs2 = attributes_for(:customer_default)
    puts attrs
    puts attrs1
    puts attrs2
  end

  #=> {:name=>"Earline Ratke MD", :email=>"maudie.stark@rennerjohnson.com"}
  #=> {:name=>"Earline Ratke MD", :email=>"maudie.stark@rennerjohnson.com", :vip=>true, :days_to_pay=>30}
  #=> {:name=>"Earline Ratke MD", :email=>"maudie.stark@rennerjohnson.com", :vip=>false, :days_to_pay=>15}
```

#### Transient Attributes [ Atributos transitórios ]

É um atributo do factory passageiro que não será chamado pelo teste. 


factories/customers.rb

```
FactoryBot.define do
  factory :customer, aliases: [:user] do

    transient do
      upcased false
    end

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

    after(:create) do |customer, evaluator|
      customer.name.upcase! if evaluator.upcased
    end

  end
end

```

models/customer_spec.rb

```
require 'rails_helper'

RSpec.describe Customer, type: :model do
  #...
  it 'Trasient Attribute' do
    customer = create(:customer_default, upcased: true)
    expect(customer.name.upcase).to eq(customer.name)
  end

  it { expect{ create(:customer) }.to change{Customer.all.size}.by(1) }
end



#### Trait

Agrupar atributos para factories herdadas.


File: factories/customers.rb

```
FactoryBot.define do
  factory :customer, aliases: [:user] do

    transient do
      upcased false
    end

    name Faker::Name.name  
    email Faker::Internet.email
    
    trait :male do
      gender 'M'
    end
    trait :female do
      gender 'F'
    end

    trait :vip do
      vip true
      days_to_pay 30
    end

    trait :default do
      vip false
      days_to_pay 15
    end

    factory :customer_male, traits: [:male]
    factory :customer_female, traits: [:female]
    factory :customer_vip, traits: [:vip]
    factory :customer_default, traits: [:default]
    factory :customer_male_vip, traits: [:male, :vip]
    factory :customer_female_vip, traits: [:female, :vip]
    factory :customer_male_default, traits: [:male, :default]
    factory :customer_female_default, traits: [:female, :default]

    after(:create) do |customer, evaluator|
      customer.name.upcase! if evaluator.upcased
    end

  end
end

```

file: models/customer_spec.rb

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


  it 'Use the attributes_for' do
    attrs = attributes_for(:customer)
    attrs1 = attributes_for(:customer_vip)
    attrs2 = attributes_for(:customer_default)
    puts attrs
    puts attrs1
    puts attrs2
  end

  it 'Trasient Attribute' do
    customer = create(:customer_default, upcased: true)
    expect(customer.name.upcase).to eq(customer.name)
  end

  it 'Cliente Masculino Vip' do
    customer = create(:customer_male_vip)
    expect(customer.gender).to eq('M')
    expect(customer.vip).to be true
  end 

  it 'Cliente Masculino' do
    customer = create(:customer_male)
    expect(customer.gender).to eq('M')
  end

  it { expect{ create(:customer) }.to change{Customer.all.size}.by(1) }
end

```


#### Callback

after(:build) -> Depois de ser criado em memória com build ou create

before(:create) -> Antes de efetivamente salvar

after(:create) -> Depois que é salvo


#### Sequences

Como usar uma sequences

```
sequence(:email) { |n| "meu_email#{n}@email.com" }
```

Podemos também dar um número inicial para o sequence:

```
sequence(:email,35) { |n| "meu_email#{n}@email.com" }
```



Podemos também dar um caracter inicial para o sequence:

OBS: Podemos utilizar qualquer objeto que implemente o método next.

```
sequence(:email,'a') { |n| "meu_email#{n}@email.com" }
```


#### Associations (belongs_to)

O factory é esperto o suficiente para verificar a associação.

```
FactoryBot.define do
  factory :order do
    sequence(:description) { |number| "Pedido número: #{number}" }
    customer # associação belongs_to
  end
end

```


```
require 'rails_helper'

RSpec.describe Order, type: :model do
  it 'Tem 1 pedido' do
    order = create(:order)
    expect(order.customer).to be_kind_of(Customer)
  end
end

```

Pode-ser sobreescrever e dizer explicitamente que desejamos instânciar o objeto e associar ele:

```
require 'rails_helper'

RSpec.describe Order, type: :model do
  it 'Tem 1 pedido' do
    customer = create(:customer)
    order = create(:order, customer: customer)
    expect(order.customer).to be_kind_of(Customer)
  end
end
```



Caso desejemos sobreescrever a factory basta adicionar association

```
FactoryBot.define do
  factory :order do
    sequence(:description) { |number| "Pedido número: #{number}" }
    association :customer, factory: :customer # = customer
  end
end
```



#### Create List

Para não criar na mão cada item, podemos criar uma lista de itens para testar.

```
require 'rails_helper'

RSpec.describe Order, type: :model do
  it 'Tem 1 pedido' do
    order = create(:order)
    expect(order.customer).to be_kind_of(Customer)
  end

  it 'Tem 3 pedidos' do
    orders = create_list(:order, 3)
    expect(orders.count).to eq(3)
  end
end

```


Pode-se sobreescrever um determinado atributo.

```
require 'rails_helper'

RSpec.describe Order, type: :model do
  it 'Tem 1 pedido' do
    order = create(:order)
    expect(order.customer).to be_kind_of(Customer)
  end

  it 'Tem 3 pedidos' do
    orders = create_list(:order, 3, description: 'Produto viabilizado')
    expect(orders.count).to eq(3)
  end
end
```

### Links diretos:


Desenvolvimento
---------------------
-   [Rodolfo Peixoto](http://www.rogpe.me)
