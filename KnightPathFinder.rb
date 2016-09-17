require_relative 'skeleton/lib/00_tree_node'
require 'byebug'

class KnightPathFinder
  attr_reader :tree
  def initialize(pos)
    @pos = pos
    @visited = [pos]
    @tree = build_move_tree(@pos)
  end

  def valid_moves(pos)
    #returns all possible valid moves
    #get all moves first (including not valid moves)
    #for each move it returns, call valid_move? on it
    x,y = pos
    all_moves = [[x+2, y-1], [x+2, y+1], [x-2, y-1], [x-2, y+1], [x-1, y-2], [x-1, y+2], [x+1, y-2], [x+1, y+2]]
    all_moves.select {|pos| valid_move?(pos)}
  end

  def valid_move? (pos)
    x, y = pos
    return false unless x.between?(0, 7) && y.between?(0,7)
    true
  end

  def new_move_positions(pos)
    possible_moves = valid_moves(pos)

    next_possible_moves = possible_moves.reject {|pos| @visited.include?(pos)}
    @visited += next_possible_moves
    next_possible_moves
  end

  # def build_move_tree(pos)
  #   queue = [pos]
  #   root_node = nil
  #   until queue.empty?
  #     node = PolyTreeNode.new(queue.shift)
  #     root_node = node if root_node.nil?
  #     children = new_move_positions(node.value)
  #     # p children
  #     children.each do |child|
  #       node.add_child(PolyTreeNode.new(child))
  #     end
  #     # p node.children
  #     queue += children
  #   end
  #   root_node
  # end

  def build_move_tree(pos)
    queue = [pos]
    chess_tree = []
    # debugger
    until queue.empty?
      node = PolyTreeNode.new(queue.shift)
      children = new_move_positions(node.value)

      children.each do |child|
        node.add_child(PolyTreeNode.new(child))
      end

      queue += children
      chess_tree << node
    end
    chess_tree
  end

  def find_path(target)
    p root = @tree.first
    root.bfs(target)
  end


end

kpf = KnightPathFinder.new([0,0])
kpf.find_path([3, 3])
p kpf.tree.first.children.first
