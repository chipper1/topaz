# Define models for every tests

class EmptyColumn < Topaz::Model
  columns
end

class AllTypes < Topaz::Model
  columns(
    type_string: String,
    type_integer: Int32,
    type_float: Float32,
    type_double: Float64,
    type_time: Time,
  )
end

class IdInt64 < Topaz::Model
  columns(
    id: Int64,
  )
end

class SearchedModel < Topaz::Model
  columns(
    name: String,
    age: Int32,
  )
end

class UpdatedModel < Topaz::Model
  columns(
    name: String,
    age: Int32,
  )
end

class DeletedModel < Topaz::Model
  columns(
    name: String,
    age: Int32,
  )
end

class NullableModel < Topaz::Model
  columns(
    test0: String,
    test1: {type: Int32, nullable: false},
    test2: {type: Float64, nullable: true},
  )
end

class DefaultModel < Topaz::Model
  columns(
    test0: String,
    test1: {type: String, default: "OK1"},
    test2: {type: String, default: "OK2", nullable: true},
    test3: {type: String, nullable: true},
  )
end

class JsonParent < Topaz::Model
  columns(name: String)
  has_many(
    childlen: {model: JsonChild, key: p_id}
  )
end

class JsonChild < Topaz::Model
  columns(
    age: Int32,
    p_id: Int32
  )
  belongs_to(parent: {model: JsonParent, key: p_id})
end

class TransactionModel < Topaz::Model
  columns(name: String)
end
