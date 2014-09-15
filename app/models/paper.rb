class Paper < ActiveRecord::Base
	scope :printer, where(printer: 1)
	scope :noprinter, where(printer: 0)
end
