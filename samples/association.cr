require "../src/topaz"
require "sqlite3"

######################
# Association Sample #
######################

# You can define associations for each model
# For now, let me define 2 models
class SampleParent < Topaz::Model
  columns # Empty columns
  # This meant that SampleParent has multiple SampleChilds
  # You can access it as children where parent_id of the children equals to the id
  has_many(
    children: {model: SampleChild, key: parent_id}
  )
end

class SampleChild < Topaz::Model
  # Define foreign key
  columns(
    parent_id: Int64
  )
  # This meant that SampleChild belongs to a SampleParent
  # You can access SampleParent as parent where id of it equals to parent_id
  belongs_to(
    parent: {model: SampleParent, key: parent_id}
  )
end

# Setup db
Topaz::Db.setup("sqlite3://./db/sample.db")

# Setup tables
SampleParent.drop_table
SampleParent.create_table
SampleChild.drop_table
SampleChild.create_table

# Let me create a parent
p = SampleParent.create

# Here we create 3 children belong to the parent
child1 = SampleChild.create(p.id.to_i64)
child2 = SampleChild.create(p.id.to_i64)
child3 = SampleChild.create(p.id.to_i64)

# Select all children
p.children.size
# => 3
p.children.first.id
# => 1

# Find a parent
child1.parent.id
# => 1
