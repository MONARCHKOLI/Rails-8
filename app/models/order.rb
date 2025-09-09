class Order < ApplicationRecord
  belongs_to :user

  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  has_one :package, dependent: :destroy

  # ✅ Replace enum with constants + helper methods
  STATUSES = {
    pending: 0,
    processing: 1,
    shipped: 2,
    delivered: 3,
    cancelled: 4
  }.freeze

  # default value
  attribute :status, :integer, default: STATUSES[:pending]

  # Getter
  def status_name
    STATUSES.key(self.status)&.to_s
  end

  # Setter using symbol or string
  def status_name=(name)
    self.status = STATUSES[name.to_sym]
  end

  # Predicate helpers
  STATUSES.keys.each do |name|
    define_method("#{name}?") do
      self.status == STATUSES[name]
    end
  end

  after_create :notify_admins

  private

  def notify_admins
    User.where(role: :admin).each do |admin|
      Notification.create!(user: admin, message: "New order ##{id} by #{user.email}")
    end
  end
end
