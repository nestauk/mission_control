class ProgressUpdate < ApplicationRecord
  scope :order_recent, -> { order(date: :desc, value: :desc) }

  belongs_to :indicator

  # has_one :authorship, as: :authorable
  # has_one :author, through: :authorship, source: :contact

  enum status: { on_track: 0, at_risk: 1, off_track: 2 }

  has_rich_text :content

  validates :date, :status, presence: true
  validates :value, presence: true, if: ->(o) { o.indicator&.target_value.present? }

  after_save :update_indicator
  after_destroy :update_indicator

  private

  def update_indicator
    last_update = indicator.progress_updates.order_recent.first
    indicator.update(
      last_progress_update_date: last_update&.date,
      last_progress_update_status: last_update&.status,
      last_progress_update_value: last_update&.value
    )
  end
end
