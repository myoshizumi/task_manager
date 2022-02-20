FactoryBot.define do
  factory :task do
    name { 'test_name' }
    detail { 'test_detail' }  
    expired_at { '01/01 11:11'} 
    status { '完了' } 
  end
end
