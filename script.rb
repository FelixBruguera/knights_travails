class Board
    attr_accessor :positions, :edges, :starting_pos
    
    def initialize
      @starting_pos = [nil,nil]
      @positions = []
      for file in 0..7
        for rank in 0..7
          @positions.push([file, rank])
        end
      end
    end
  
    def potencial_moves(pos)
      moves = []
      moves.push([pos[0]+2,pos[1]+1]) unless pos[0]+2 > 7 || pos[1]+1 > 7
      moves.push([pos[0]+1,pos[1]+2]) unless pos[0]+1 > 7 || pos[1]+2 > 7
      moves.push([pos[0]+2,pos[1]-1]) unless pos[0]+2 > 7 || pos[1]-1 < 0
      moves.push([pos[0]-1,pos[1]+2]) unless pos[0]-1 < 0 || pos[1]+2 > 7
      moves.push([pos[0]+1,pos[1]-2]) unless pos[0]+1 > 7 || pos[1]-2 < 0
      moves.push([pos[0]-2,pos[1]+1]) unless pos[0]-2 < 0 || pos[1]+1 > 7
      moves.push([pos[0]-1,pos[1]-2]) unless pos[0]-1 < 0 || pos[1]-2 < 0
      moves.push([pos[0]-2,pos[1]-1]) unless pos[0]-2 < 0 || pos[1]-1 < 0
      moves
    end
  
    def create_graph
      @edges = []
      for i in @positions do
         @edges.push(potencial_moves(i))
      end
      @edges
    end
  
    def knight_moves(pos,target, queue = [], visited = [], parents = {})
      @starting_pos = pos if @starting_pos == [nil,nil]
      index = @positions.index(pos)
      queue.shift unless queue.empty?
      visited.push(pos) unless visited.include?(pos)
      @edges[index].each {|edge| parents[edge] = pos unless parents.keys.include?(edge)}
      if @edges[index].include?(target)
        path = []
        path.prepend(target)
        until path.include?(@starting_pos)
          path.prepend(parents[target])
          target = parents[target]
        end
        puts "You made it in #{path.length-1} steps, your path was:"
        return p path
      end
      @edges[index].each { |elem| queue.push(elem) unless queue.include?(elem)}
      knight_moves(queue[0], target, queue, visited, parents)
    end
        
  end
  chess = Board.new
  chess.create_graph
  chess.knight_moves([0,0],[7,7])