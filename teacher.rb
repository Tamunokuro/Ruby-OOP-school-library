require_relative 'person'

class Teacher < Person
  attr_accessor :specialization

  def initialize(specialization, age, name = 'Unknown', id = Random.rand(1..1000), parent_permission: true)
    super(age, id, name, parent_permission: parent_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end
