# point : scope is lambda.

# 効果
# クラスメソッドによる定義と違って、`scope`からはじまることにより、「ああ、これはクエリなんだな」と読む人が一瞬で理解できて、可読性があがったと感じる
# `scope`を使うことで、戻り値が`ActiveRecord::Relation`オブジェクトを返されることが約束されている(ので、メソッドチェーンできることがすぐわかる)

### scopeを使わないコード

def self.index(params)
  Blog.where_if_need(params[:user_id]).page(params[:page]).order(created_at: :desc)
end
def self.where_if_need(user_id)
  if user_id
    self.where(user_id: user_id)
  else
    self
  end
end

### scopeを使ったコード

scope :index, ->(params) { by_user_id_if_need(params[:user_id]).order(created_at: :desc).page(params[:page]) }
scope :by_user_id_if_need, lambda { |user_id|
  if user_id.present?
    where(user_id: user_id)
  end
}
