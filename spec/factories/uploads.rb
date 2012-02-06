# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :upload do
    filename "MyString"
    url "MyString"
    downloads 1
    charge_id 1
  end
end
