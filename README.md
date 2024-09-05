# Sport game challenge

## Instructions
- The script can handle via arguments or stdin, see below samples. Output provided per the first option.

```shell
$ruby sport_game.rb -f input.txt # arguments
1. Tarantulas, 6 pts
2. Lions, 5 pts
3. Snakes, 1 pt
4. FC Awesome, 1 pt
5. Grouches, 0 pt

$cat input.txt | ruby sport_game.rb

$ruby sport_game.rb < input.txt
```

- Tests are ready via minitest and rake

```shell
$rake
Run options: --seed 35759

# Running:

........

Finished in 0.000496s, 16129.0322 runs/s, 16129.0322 assertions/s.

8 runs, 8 assertions, 0 failures, 0 errors, 0 skips
```

## Gist
- [The problem](https://gist.github.com/longthanhtran/a6476eb90fe02d0166c9933cb5526914)
