# ansack.configure do |config|
#   config.add_predicate 'equals_diddly', # 述語名
#                        # Arelの述語(eqとか)
#                        # Arelについては 第9章 RansackのためのArel入門 を参照してね。
#                        arel_predicate: 'eq',
#                        # 入力値の整形
#                        # デフォルトは何もしないよ。
#                        formatter: proc { |v| "#{v}-diddly" },
#                        # 入力値のバリデーション。戻り値がfalseの場合はこの条件は無視される。
#                        # デフォルトはpresent?でバリデートするよ。
#                        validator: proc { |v| v.present? },
#                        # 述語allと述語anyを使えるようにする。
#                        # デフォルトはtrue
#                        compounds: true,
#                        # 入力値の型変換
#                        # デフォルトはDBのカラムの型を利用する。
#                        type: :string
# end