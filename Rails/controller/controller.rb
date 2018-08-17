# mass assignment with instance valiables
@something = Something.new something_params.merge({extra: params[:extra]})
