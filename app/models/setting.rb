class Setting < ActiveRecord::Base
	include DataTable
	serialize :value
	before_save :make_hashes

    def make_hashes
		self.value = DataTable.assemble_hash_from_array self.value
	end

	def data_hash
		DataTable.get_hash self.value
	end
end
