function total = totalSum(n,x,y,z)

  % n : num of dip
  % xi : [-x,x]
  % yi : [-y,y]
  % zi : [0,z]

  X = linspace(-x,x,n);
  Y = linspace(-y,y,n);
  Z = linspace(0,z*pi*4/3,n);
  for i=1:n
      pos(i,1) = X(i);
      pos(i,2) = Y(i);
      pos(i,3) = Z(i);
  end

  for i=1:n
       for j = 1:n
           distance(i,j) = sqrt((pos(i,1)-pos(j,1))^2+(pos(i,2)-pos(j,2))^2+(pos(i,3)-pos(j,3))^2);
       end
  end

  total = sum(sum(distance));
end

