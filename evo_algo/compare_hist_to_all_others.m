function [ losses ] = compare_hist_to_all_others( k, hists, pos, ...
    use_expected, tolerated_error)
%COMPARE_HIST_TO_ALL_OTHERS k is the position of the histogram you want to
%compare

losses = zeros(size(hists, 1), 1);
h_k = hists(k, :);


% Determine distances (or rather similarity)
% Could also use cosine similarity here
for i = 1:size(hists, 1)
    
    actual_sim = dot(h_k, hists(i, :)) / (norm(h_k) * norm(hists(i, :)));
    
    if (use_expected)
        % Calculate and normalize expected similarities
        expected_sim_x = normpdf(pos(i, 1), pos(k, 1), tolerated_error) *  ...
            tolerated_error * sqrt(2 * pi);
        expected_sim_y = normpdf(pos(i, 2), pos(k, 2), tolerated_error) * ...
            tolerated_error * sqrt(2 * pi);
        expected_sim = expected_sim_x * expected_sim_y;
        
    else
        % Just keep track of the similarities and not of the differences
        % between the expected and actual similarity
        expected_sim = 0;
    end
    
    % Assign loss
    losses(i) = actual_sim - expected_sim;
    
end

end

