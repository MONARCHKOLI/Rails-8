class Package < ApplicationRecord
  belongs_to :order
  enum status: { pending: 0, in_transit: 1, delivered: 2, returned: 3 }

  after_update :update_order_status, if: :saved_change_to_status?

  private

  def update_order_status
    if delivered?
      order.update(status: :delivered)
    elsif returned?
      order.update(status: :cancelled)
    end
  end
end
