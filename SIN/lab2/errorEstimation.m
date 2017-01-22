function errorEstimation(name = 'OCR_14x14')
    load(strcat('data/', name));
    [N, L] = size(data);
    D = L - 1;
    ll = unique(data(:, L));
    C = numel(ll);
    rand('seed', 23);
    data = data(randperm(N), :);
    M = N - round(.7 * N);
    te = data(N - M + 1 : N, :);
    load(strcat('res/', name, '_w'));
    rl = zeros(M, 1);
    for m = 1:M
        tem = [1 te(m,1:D)]';
        rl(m) = ll(linmach(w,tem));
    end;
    [nerr m] = confus(te(:, L), rl);

    m = nerr / M
    s = sqrt(m * (1 - m) / M);
    r = 1.96 * s
    printf('I = [%.3f, %.3f]\n', m - r, m + r);
endfunction

