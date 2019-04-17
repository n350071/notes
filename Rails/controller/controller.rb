# mass assignment with instance valiables
@something = Something.new something_params.merge({extra: params[:extra]})

# コントローラ内のインスタンス変数を知る
self.instance_variable_names
