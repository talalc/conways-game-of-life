class Cell
	attr_accessor :neighbors
	def initialize
		@alive = [true, false].sample #true
		@neighbors = 0
		@set_to_birth = false
		@set_to_kill = false
	end
	def alive?
		@alive
	end
	def set_to_birth?
		@set_to_birth
	end
	def set_to_kill?
		@set_to_kill
	end
	def kill
		@alive = false
	end
	def birth
		@alive = true
	end
	def set_to_birth
		@set_to_birth = true
	end
	def set_to_birth_off
		@set_to_birth = false
	end
	def set_to_kill
		@set_to_kill = true
	end
	def set_to_kill_off
		@set_to_kill = false
	end

end

class Life
	attr_accessor :grid
	def initialize(size)
		@grid = Array.new(size.to_i) { Array.new(size.to_i) }
		@grid.each_index do |index1|
			@grid[index1].each_index do |index2|
				@grid[index1][index2] = Cell.new
			end
		end
	end

	def count_neighbors_mid(index1,index2)
		@grid[index1][index2].neighbors += 1 if @grid[index1-1][index2].alive?
		@grid[index1][index2].neighbors += 1 if @grid[index1+1][index2].alive?
		@grid[index1][index2].neighbors += 1 if @grid[index1][index2-1].alive?
		@grid[index1][index2].neighbors += 1 if @grid[index1][index2+1].alive?
		@grid[index1][index2].neighbors += 1 if @grid[index1-1][index2-1].alive?
		@grid[index1][index2].neighbors += 1 if @grid[index1+1][index2+1].alive?
		@grid[index1][index2].neighbors += 1 if @grid[index1-1][index2+1].alive?
		@grid[index1][index2].neighbors += 1 if @grid[index1+1][index2-1].alive?
	end

	def count_neighbors(index1,index2,arr)
		arr.each do |a|
			@grid[index1][index2].neighbors += 1 if @grid[a[0]][a[1]].alive?
		end
	end

	def check

		@grid.each_index do |index1|
			@grid[index1].each_index do |index2|
				arr = []
				if index1 == 0 && index2 == 0
					arr << [index1,index2+1]
					arr << [index1+1,index2]
					arr << [index1+1,index2+1]
					count_neighbors(index1,index2,arr)
				elsif index1 == @grid.size-1 && index2 == 0
					arr << [index1-1,index2]
					arr << [index1,index2+1]
					arr << [index1-1,index2+1]
					count_neighbors(index1,index2,arr)
				elsif index1 == 0 && index2 == @grid.size-1
					arr << [index1,index2-1]
					arr << [index1+1,index2]
					arr << [index1+1,index2-1]
					count_neighbors(index1,index2,arr)
				elsif index1 == @grid.size-1 && index2 == @grid.size-1
					arr << [index1,index2-1]
					arr << [index1-1,index2]
					arr << [index1-1,index2-1]
					count_neighbors(index1,index2,arr)
				elsif index1 == 0
					arr << [index1,index2+1]
					arr << [index1+1,index2+1]
					arr << [index1+1,index2]
					arr << [index1+1,index2-1]
					arr << [index1,index2-1]
					count_neighbors(index1,index2,arr)
				elsif index1 == @grid.size-1
					arr << [index1,index2-1]
					arr << [index1-1,index2-1]
					arr << [index1-1,index2]
					arr << [index1-1,index2+1]
					arr << [index1,index2+1]
					count_neighbors(index1,index2,arr)
				elsif index2 == 0
					arr << [index1-1,index2]
					arr << [index1-1,index2+1]
					arr << [index1,index2+1]
					arr << [index1+1,index2+1]
					arr << [index1+1,index2]
					count_neighbors(index1,index2,arr)
				elsif index2 == @grid.size-1
					arr << [index1+1,index2]
					arr << [index1+1,index2-1]
					arr << [index1,index2-1]
					arr << [index1-1,index2-1]
					arr << [index1-1,index2]
					count_neighbors(index1,index2,arr)
				else
					count_neighbors_mid(index1,index2)
				end
				@grid[index1][index2].set_to_kill if @grid[index1][index2].neighbors < 2 && @grid[index1][index2].alive?
				@grid[index1][index2].set_to_kill if @grid[index1][index2].neighbors > 3 && @grid[index1][index2].alive?
				@grid[index1][index2].set_to_birth if @grid[index1][index2].neighbors == 3 && !@grid[index1][index2].alive?
				@grid[index1][index2].neighbors = 0
			end
		end
	end

	def tick
		@grid.each_index do |index1|
			@grid[index1].each_index do |index2|
				if @grid[index1][index2].set_to_kill?
					@grid[index1][index2].kill
					@grid[index1][index2].set_to_kill_off
				elsif @grid[index1][index2].set_to_birth?
					@grid[index1][index2].birth
					@grid[index1][index2].set_to_birth_off
				end
			end
		end
	end

	def to_s
		@grid.each_index do |index1|
			@grid[index1].each_index do |index2|
				@grid[index1][index2].alive? ? (print 'o '):(print '  ')
			end
			puts
		end
	end

end

life = Life.new(48)
while true
	system 'clear'
	puts life
  # sleep 0.05
	life.check
	life.tick
end