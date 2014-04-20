require_relative "spec_helper"
require_relative "../lib/life"

describe Cell do
	let( :cell ){ Cell.new }
	it "should be a cell" do
		expect(cell).to be_a(Cell)
	end
	it "should be alive" do
		expect(cell).to be_alive
	end
	it "can be killed" do
		cell.kill
		expect(cell).not_to be_alive
	end
end

describe Life do
	let( :life ){ Life.new(8) }
	it "should be an 8x8 grid" do
		expect(life.grid.size).to eq(8)
		expect(life.grid.first.size).to eq(8)
	end
	it "should hold cells" do
		expect(life.grid.first.first).to be_a(Cell)
		expect(life.grid.last.last).to be_a(Cell)
	end
	it "middle cell should count 8 neighbors" do
		life.count_neighbors_mid(3,3)
		expect(life.grid[3][3].neighbors).to eq(8)
	end
end