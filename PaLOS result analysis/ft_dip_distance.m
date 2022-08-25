function distance_matrix = ft_dip_distance(pos)

     D = pdist(pos);
     distance_matrix = squareform(D);
end

