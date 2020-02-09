

class SmartComp
  attr_reader :current_key, :left_key, :right_key, :top_key, :bottom_key

    def initialize(current_key)
      @current_key = current_key
      @left_key = @current_key[0] + (@current_key[1].to_i - 1).to_s
      @right_key = @current_key[0] + (@current_key[1].to_i + 1).to_s
      @top_key = (@current_key[0].ord - 1).chr + @current_key[1]
      @bottom_key = (@current_key[0].ord + 1).chr + @current_key[1]
    end

end
