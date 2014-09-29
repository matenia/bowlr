# Bowlr

Calculate your bowling game on a turn by turn basis!

## Installation

    $ cd bowlr
    $ bundle

And then execute:

    $ bowlr

**Note:** This was developed on `Ruby 2.1.2` although earlier versions
may also work.

## Usage

Enter how many pins you hit on a given turn. We'll know if you're cheating
and your score won't get added correctly until you play a valid turn.

Note: Enter `10` for a strike not `X`

### Example of perfect game

where `>` is your input.

```
$ bowlr
Enter number of pins knocked down, turn by turn
> 10
10
10
> 10
10 | 10
20 | 30
> 10
10 | 10 | 10
30 | 50 | 60
> 10
10 | 10 | 10 | 10
30 | 60 | 80 | 90
> 10
10 | 10 | 10 | 10 | 10
30 | 60 | 90 | 110 | 120
> 10
10 | 10 | 10 | 10 | 10 | 10
30 | 60 | 90 | 120 | 140 | 150
> 10
10 | 10 | 10 | 10 | 10 | 10 | 10
30 | 60 | 90 | 120 | 150 | 170 | 180
> 10
10 | 10 | 10 | 10 | 10 | 10 | 10 | 10
30 | 60 | 90 | 120 | 150 | 180 | 200 | 210
> 10
10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10
30 | 60 | 90 | 120 | 150 | 180 | 210 | 230 | 240
> 10

> 10

> 10
10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 10 10
30 | 60 | 90 | 120 | 150 | 180 | 210 | 240 | 270 | 300
 Game Total:
10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 10 10
30 | 60 | 90 | 120 | 150 | 180 | 210 | 240 | 270 | 300
Game Over, Type Exit and run again
> exit
$
```

## Specs?

Of course!

Just run `bundle exec rspec spec`

This also generates the `simplecov` output which will
be located at `coverage/index.html`.
