function [newBoard] = GOL_next_iter(Board, offset_to_left, offset_to_right,...
                                    offset_to_up, offset_to_btm)    
    %left, right
    %top, bottom
    %top left, top right
    %bottom left, bottom right
    neighbourCellsCounts = Board(:, offset_to_left) + Board(:, offset_to_right) + ... 
                           Board(offset_to_up, :) + Board(offset_to_btm, :) + ...
                           Board(offset_to_up, offset_to_left) + Board(offset_to_up, offset_to_right) + ...
                           Board(offset_to_btm, offset_to_left) + Board(offset_to_btm, offset_to_right);
    
    %make sure left, right, top, bottom most column of the neighbourCells are all zero
    neighbourCellsCounts(:,1) = 0; 
    neighbourCellsCounts(:,size(neighbourCellsCounts,2)) = 0; 
    neighbourCellsCounts(1,:) = 0; 
    neighbourCellsCounts(size(neighbourCellsCounts,1),:) = 0; 

    newBoard = (Board & (neighbourCellsCounts == 2)) | (neighbourCellsCounts == 3);
    
end 