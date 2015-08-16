load 'map.rb'

$SPACE = 0
$WALL = 1
$ENTER = 2
$EXIT = 3
$STATE_PLAY = 0
$STATE_FINISHED = 1
$STATE_BONUS = 2

class State
	@map	
	@width
	@height
	@waldo
	@state
	@entrance_i
	@exit_i
	def initialize w, h
		@state = $STATE_PLAY
		@map = Map.new w, h
		@width = w
		@height = h
		@waldo = 0
		@waldo = @map.index_of 1, 1
		walls
		@exit_i = (rand(@height-2)+1)
		@entrance_i = (rand(@height-2)+1)
		make_entrance 0, @entrance_i 
		make_exit (@width-1), @exit_i
		@waldo = @map.index_of 0, @entrance_i
		
		
	end
	
	def get_entrance_i
		return @entrance_i
	end
	
	def get_exit_i
		return @exit_i
	end
	
	def get_map
		return @map
	end	
	
	def get_height
		return @height
	end
	
	def get_width
		return @width
	end	
	
	def move_waldo x, y
		if ((x>(@width-1))||(y>(@height-1))||(y<0)||(x<0)) then
			return false		
		end
		@waldo = @map.index_of x, y
		return true
	end	
	
	def move_down
		waldo = wheres_waldo_c
		wx = waldo[0]
		wy = waldo[1]
		if (@map.value(wx, wy+1) != 1) then
			move_waldo wx, (wy+1)
		end
	end
	
	def move_up
		waldo = wheres_waldo_c
		wx = waldo[0]
		wy = waldo[1]
		if(@map.value(wx, wy-1) != 1) then
			move_waldo wx, wy-1
		end
	end
	
	def move_left
		waldo = wheres_waldo_c
		wx = waldo[0]
		wy = waldo[1]
		if(@map.value(wx-1, wy) != 1) then
			move_waldo wx-1, wy
		end
	end
	
	def move_right
		waldo = wheres_waldo_c
		wx = waldo[0]
		wy = waldo[1]
		if(@map.value(wx+1, wy) != 1) then
			move_waldo wx+1, wy
		end
		if((@map.value(wx+1, wy) == 3) &&(@state != $STATE_BONUS)) then #found it!
			move_waldo wx+1, wy
			@state = $STATE_FINISHED
		end
		
			
	end
	
	def wheres_waldo
		return @waldo
	end
	
	def wheres_waldo_c
		return @map.coords_of @waldo
	end
	
	def walls
		(0..(@height-1)).each do |i|
			if((i==0)||(i==(@height-1)))
				(0..@width).each do |j|
					@map.set j, i, $WALL
				end
			
			else
				@map.set 0, i, $WALL
				@map.set (@width-1), i, $WALL			
			end
		end
	end
	
	def make_entrance x, y
		@map.set x, y, $ENTER
	end
	
	def make_exit x, y
		@map.set x, y, $EXIT
	end
	
	def get_state
		return @state
	end
	
	
	def set_state x
		@state = x
	end

end