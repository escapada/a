class Paper < ActiveRecord::Base
	#scope :printer, :conditions => ['printer = ?', 1]
	#scope :noprinter, :conditions => ['printer = ?', 0]

	scope :printer, where(printer: 1)
	scope :noprinter, where(printer: 0)
end
