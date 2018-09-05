###################################################################
## use delegate insted of belongs_to through
## OOP: LoD by delegate method
### bad ###
# class Company
#   has_many :dogs, through: :employee
# end
# class Dog
#   #=> syntax error! through can't be used with belongs_to
#   belongs_to :comapny, through: :employee
#   # abuse Law of Demeter
#   employee.company
# end
### good ###
delegate :company, :to => :employee, allow_nil: :true


###################################################################
# validate with associated model
class Employee < ActiveRecord::Base
  validates :salary, presence: true
end

class CompanyEmployee < ActiveRecord::Base
  belongs_to :company
  belongs_to :employee, validate: true
  # => it{expect{company.employees << employees}.to raise_error(ActiveRecord::RecordInvalid)}
end

###################################################################
## difference between destroy and delete
Model.find_by(col: "foo").destroy #=> callback will be called
Model.find_by(col: "foo").delete  #=> callback won't be called

###################################################################
## Rails counter_cache not updating correctly
class UserRelation < ActiveRecord::Base
  belongs_to :user, counter_cache: :relation_count
  belongs_to :relation
  before_destroy {user.relation_count = user.relation_count - 1} # this decrese count
end
class User < ActiveRecord::Base
  def remove_relation(relation)
    # relations.delete relation # this doesn't call callback
    relations.destroy relation  # this calls callback
  end
end
