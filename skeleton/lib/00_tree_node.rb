class PolyTreeNode
  attr_reader :value, :parent, :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(parent)
    #update previous parent's child if exists
    @parent.children.delete(self) unless @parent.nil?

    if parent.nil?
      @parent = nil
    else
      @parent = parent
      unless parent.children.include? (self)
        # parent.add_child(self)
        parent.children << self
      end
    end
  end

  def add_child(child)
    @children << child
    child.parent = self
  end

  def remove_child(child)
    raise "not a valid child" unless @children.include? (child)
    @children.delete(child)
    child.parent = nil
  end

  def dfs(target_value)
    return self if @value == target_value
    @children.each do |child|
      result = child.dfs(target_value)
      return result if result
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      node = queue.shift
      return node if node.value == target_value
      queue += node.children
    end
    nil
  end


end

# n1 = PolyTreeNode.new(1)
# n2 = PolyTreeNode.new(2)
# n3 = PolyTreeNode.new(3)
# n2.parent = nil
# n3.parent = n1
# p n2
