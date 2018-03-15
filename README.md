[![Build Status](https://travis-ci.org/czuger/square-dungeon-gen.svg?branch=master)](https://travis-ci.org/czuger/square-dungeon-gen)
[![Maintainability](https://api.codeclimate.com/v1/badges/a72af1658fd0931463a5/maintainability)](https://codeclimate.com/github/czuger/square-dungeon-gen/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/a72af1658fd0931463a5/test_coverage)](https://codeclimate.com/github/czuger/square-dungeon-gen/test_coverage)

# Square dungeon gen
This repository contain a library for generating square simple dungeons

## Compatibility

This gem has been tested with ruby 2.0 -> 2.5

## Usage

### Basics
------
 
```ruby
# Create a dungeon
d=Dungeon.new( dungeon_size )

# Exemple :
d=Dungeon.new( 4 )
# This will not create a dungeon of 4 rooms size, but a dungeon of 4**2*0.3 rooms (rounded up)
# The dungeon constructor accept another parameter wich is the amount of rooms to remove from the dungeon
# This parameter is a number between 0 and 1. By default it is set to 0.3 which mean that it will remove 30% of the rooms.

d=Dungeon.new( 4, 0.5 )
# Will remove 50% of the rooms

# Draw your dungeon
d.draw( 'out/dungeon.jpg' )
# Or only the curren room
d.draw_current_room( 'out/current_room.jpg' )

# You can get the directions available from the current room
d.available_directions
# => [ :left, :right ] # according to your dungeon which is random

# Then you can move the current room by moving in a direction
d.set_next_room( :left )
# Will move the current_room to the left.
```

### Examples
------

This is an example of the current room : 

![test picture](/images/entry-room.jpg)

This is an example of the full dungeon room : 

![test picture](/images/dungeon.jpg)
