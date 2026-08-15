class OrderShippingAddress
  include ActiveModel::Model

  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code
    validates :prefecture_id
    validates :city
    validates :addresses
    validates :phone_number
    validates :token
  end

  validates :postal_code,
            format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Include hyphen(-)' },
            allow_blank: true

  validates :phone_number,
            format: { with: /\A\d{10,11}\z/, message: 'is invalid' },
            allow_blank: true
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    ShippingAddress.create(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      addresses: addresses,
      building: building,
      phone_number: phone_number,
      order_id: order.id
    )
  end
end
