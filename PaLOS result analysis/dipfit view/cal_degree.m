function degree = cal_degree(pos)

% degree : The degree of dispersion of the source distribution
   for i=1:length(pos)
       for j = 1:length(pos)
           distance(i,j) = sqrt((pos(i,1)-pos(j,1))^2+(pos(i,2)-pos(j,2))^2+(pos(i,3)-pos(j,3))^2);
       end
   end

%    sub_total = sum(sum(distance));
%    total = totalSum(length(pos),85,85,85);
   degree = sum(sum(distance))/totalSum(length(pos),85,85,85);
end