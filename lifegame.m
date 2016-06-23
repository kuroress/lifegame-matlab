classdef lifegame < handle
   properties
      Map
      BoundaryCondition
   end
   methods
       function obj = lifegame(win_size, boundary)
           if nargin < 2
               boundary = 'open';
           end
           obj.BoundaryCondition = boundary;
           obj.Map = zeros(win_size);
       end
       function randamize(obj)
           obj.Map = randi(2, size(obj.Map)) - 1;
       end
       function update(obj)
           next = zeros(size(obj.Map));
           neighbors = lifegame.neighbors(obj.Map,obj.BoundaryCondition);
           next = next | (neighbors==3);
           next = next | (obj.Map & (neighbors==2));
           obj.Map = double(next);
       end
   end
   methods(Static)
       function Y = neighbors(X, boundary)
           expanded = zeros(size(X)+2);
           if strcmp(boundary, 'loop')
               expanded = repmat(X,3);
               expanded = expanded(size(X,1):2*size(X,1)+1,... 
                                   size(X,2):2*size(X,2)+1);
           end
           expanded(2:size(X,1)+1, 2:size(X,2)+1) = X;
           
           h = [1 1 1;
                1 0 1;
                1 1 1];
           Y = filter2(h, expanded,'valid');
       end
   end
end