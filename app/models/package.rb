class Package < ApplicationRecord
  belongs_to :order
  enum status: { pending: 0, in_transit: 1, delivered: 2, returned: 3 }

  after_update :update_order_status, if: :saved_change_to_status?

  after_update_commit :broadcast_status

  def broadcast_status
    OrderStatusChannel.broadcast_to(order, {
      status: status,
      tracking_number: tracking_number,
      expected_delivery: expected_delivery
    })
  end


  private

  def update_order_status
    if delivered?
      order.update(status: :delivered)
    elsif returned?
      order.update(status: :cancelled)
    end
  end
end
