# PROBLEM
# params and db-schema is different
# my_id in params vs myself_id in db-schema

# the request
# curl -X POST \
#     -H "Content-Type: application/json" \
#     -d "{\"smth_id\":\"1\",\"my_id\": \"2\", \"your_id\": \"3\" }"   \
#     http://localhost:3000/api/v1/id_regist

# model
# class IdRegist
# end

# == Schema Information
#
# Table name: id_regists
#
#  id              :integer          not null, primary key
#  smth_id         :integer
#  myself_id       :string(255)       # <= this is the point!!!!!
#  your_id         :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

# Solution1
class Api::V1::IdRegistsController < Api::V1::BaseController
  before_action :param_alias # <= this is one of the solution!

  private
  def param_alias
    params[:id_regist][:myself_id] = params[:my_id]
  end
end

# Solution2
# use this method in controller
wrap_parameters include: [:smth_id, :my_id, :your_id]  # but you have to write all of params and my_id will be still my_id, not converted to myself_id
