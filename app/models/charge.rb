class Charge
  attr_accessor :created_at, :amount, :user

  def initialize(data)
    @created_at = Time.at(data.created)
    @amount = data.amount / 100.0
    @user = User.where(customer_id: data.customer).first
  end

  def self.history(user: nil)
    return [] if user.present? && user.customer_id.nil?
    Stripe::Charge.list(customer: user&.customer_id).map { |data| Charge.new(data) }
  end
end
