class Phone < ApplicationRecord
  START_PHONE = 1_111_111_111
  FINISH_PHONE = 9_999_999_999

  validates :phone,
            uniqueness: true,
            numericality: true,
            inclusion: START_PHONE..FINISH_PHONE

  class << self
    def stringified(phone)
      phone.to_s.insert(3, '-').insert(7,'-')
    end

    def convert_to_integer(phone)
      return unless phone
      phone.tr('^0-9', '').to_i
    end
  end
end
