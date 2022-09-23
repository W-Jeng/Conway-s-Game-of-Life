%% once running, can press CTRL+C or shift+F5 to stop
numRows = input("Enter the number of rows : ");
numColumns = input("Enter the number of columns : ");
aliveStart = floor(numRows*numColumns / 3);
% building a board that has empty borders
Board = sparse(numRows+2, numColumns+2);
Board(randperm(numel(Board),aliveStart)) = 1;

%make sure left, right, top, bottom most column are all zero
Board(:,1) = 0; 
Board(:,size(Board,2)) = 0; 
Board(1,:) = 0; 
Board(size(Board,1),:) = 0; 

[offset_to_right, offset_to_left,...
    offset_to_up, offset_to_btm] = generate_offset_matrices(Board);

if (max(numRows, numColumns) < 10)
    MarkerSize = 10;
elseif (max(numRows, numColumns) < 50)
    MarkerSize = 8;
elseif (max(numRows, numColumns) < 100)
    MarkerSize = 6;
elseif (max(numRows, numColumns) < 200)
    MarkerSize = 4;
else
    MarkerSize = 2;
end
first_run = true;
spy(Board, "r*", MarkerSize)
pause(1);

while true
    Board = GOL_next_iter(Board,offset_to_left, offset_to_right,...
                                    offset_to_up, offset_to_btm);
    pause(0.05);
    if (~first_run && isequal(PrevBoard, Board))
        disp("Steady state is reached. The program is terminated")
        break
    end
%     disp(Board)
    spy(Board, "r*", MarkerSize)
    PrevBoard = Board;
    first_run = false;
end