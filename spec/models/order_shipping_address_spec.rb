require 'rails_helper'

RSpec.describe OrderShippingAddress, type: :model do
  before do
    @order_shipping_address = OrderShippingAddress.new(
      user_id: 1,
      item_id: 1,
      postal_code: '123-4567',
      prefecture_id: 2,
      city: '松山市',
      addresses: '朝生田町1-2-3',
      building: 'テストマンション101',
      phone_number: '09012345678',
      token: 'tok_abcdefghijk00000000000000000'
    )
  end

  context '商品購入ができる場合' do
    it 'すべての値が正しく入力されていれば購入できる' do
      expect(@order_shipping_address).to be_valid
    end

    it '建物名が空でも購入できる' do
      @order_shipping_address.building = ''
      expect(@order_shipping_address).to be_valid
    end
  end

  context '商品購入ができない場合' do
    it '郵便番号が空では購入できない' do
      @order_shipping_address.postal_code = ''
      @order_shipping_address.valid?
      expect(@order_shipping_address.errors.full_messages).to include("Postal code can't be blank")
    end

    it '郵便番号にハイフンがない場合は購入できない' do
      @order_shipping_address.postal_code = '1234567'
      @order_shipping_address.valid?
      expect(@order_shipping_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
    end

    it '都道府県が未選択では購入できない' do
      @order_shipping_address.prefecture_id = 1
      @order_shipping_address.valid?
      expect(@order_shipping_address.errors.full_messages).to include("Prefecture can't be blank")
    end

    it '市区町村が空では購入できない' do
      @order_shipping_address.city = ''
      @order_shipping_address.valid?
      expect(@order_shipping_address.errors.full_messages).to include("City can't be blank")
    end

    it '番地が空では購入できない' do
      @order_shipping_address.addresses = ''
      @order_shipping_address.valid?
      expect(@order_shipping_address.errors.full_messages).to include("Addresses can't be blank")
    end

    it '電話番号が空では購入できない' do
      @order_shipping_address.phone_number = ''
      @order_shipping_address.valid?
      expect(@order_shipping_address.errors.full_messages).to include("Phone number can't be blank")
    end

    it '電話番号が9桁では購入できない' do
      @order_shipping_address.phone_number = '090123456'
      @order_shipping_address.valid?
      expect(@order_shipping_address.errors.full_messages).to include('Phone number is invalid')
    end

    it '電話番号が12桁では購入できない' do
      @order_shipping_address.phone_number = '090123456789'
      @order_shipping_address.valid?
      expect(@order_shipping_address.errors.full_messages).to include('Phone number is invalid')
    end

    it '電話番号にハイフンがある場合は購入できない' do
      @order_shipping_address.phone_number = '090-1234-5678'
      @order_shipping_address.valid?
      expect(@order_shipping_address.errors.full_messages).to include('Phone number is invalid')
    end

    it 'user_idが空では購入できない' do
      @order_shipping_address.user_id = nil
      @order_shipping_address.valid?
      expect(@order_shipping_address.errors.full_messages).to include("User can't be blank")
    end

    it 'item_idが空では購入できない' do
      @order_shipping_address.item_id = nil
      @order_shipping_address.valid?
      expect(@order_shipping_address.errors.full_messages).to include("Item can't be blank")
    end

    it 'tokenが空では購入できない' do
      @order_shipping_address.token = nil
      @order_shipping_address.valid?
      expect(@order_shipping_address.errors.full_messages).to include("Token can't be blank")
    end
  end
end
