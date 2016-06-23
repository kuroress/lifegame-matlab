function demo_lifegame(win_size)
game = lifegame(win_size, 'loop');
game.randamize();
while true
    game.update();
    image(game.Map, 'CDataMapping', 'scaled');
    drawnow
end
end