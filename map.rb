#Note to self: when in Rome, do as the Romans
#do....apparently class names are CamelCase and
#member names are lower_case_underscores

class Map
	@grid
	@width
	@height
	@area

	def initialize w, h
		@width = w
		@height = h
		@area = @width * @height
		
		@grid = Array.new(@area, 0)
	end
	
	#returns value of (x,y)
	#in screen coordinates
	#(0->..x)
	#(| ....)
   #(V ....)
   #(x ....)
   #
	def index_of x, y
		index = (y* @width) + x
		return index
	end
	
	#...and gets an (x,y) from an array index value
	def coords_of z
		if z == 0 then 
			return Array.new(2, 0)
		end		
		x = z % @width	
		y = (z / @width).floor
		return [x, y]		
	end
	
	#what's stored there
	def value x, y
		index = index_of x, y
		return @grid[index]
	end 
	
	#store this there
	def set x, y, delta
		index = index_of x, y
		@grid[index] = delta
	end
	
	#two functions, one task, ay Dios mio!
	def get x, y
		index = index_of x, y
		return @grid[index]
	end

end