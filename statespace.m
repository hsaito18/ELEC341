function M = statespace(A,B,C,D)  
    s = tf('s');
    a_size = size(A);
    dimension = a_size(1);
    phi = inv(s*eye(dimension) - A);
    M = C*phi*B + D;
