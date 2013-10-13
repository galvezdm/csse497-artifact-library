
FactoryGirl.define do
  factory :users do
    first_name "Elmer"
    last_name "Guerri"
    email "eguerri@aol.com"
    phone_number "702-858-1890"
    address "2345 Inuit Way"
    state "IN"
    postal_code "23428"
    password "Pueblo"
  end

  factory :friend1, class: User do
    first_name "Mark"
    last_name "Fitzgerald"
  end

  factory :friend2, class: User do
    first_name "John"
    last_name "Paford"
  end

  factory :artifact do
  end

  factory :collection do
    name "Eskimo"
  end
end