class A
  include EventAgent
  include Publisher


  def initialize
    new_agent_id
  end
end

class S
end
