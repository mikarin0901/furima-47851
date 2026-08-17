FactoryBot.define do
  factory :order_shipping_address do
    postal_code { '123-4567' }
    prefecture_id { 2 }
    city { '松山市' }
    addresses { '朝生田町1-2-3' }
    building { 'テストマンション101' }
    phone_number { '09012345678' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
