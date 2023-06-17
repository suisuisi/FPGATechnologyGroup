% script to plot the rotations of a CORDIC engine in rotation mode
% created: May 08 by Louise Crockett
% modified: July 08 
%--------------------------------------------------------------------------


% first establish the size of the matrices holding the X and Y vectors 
% (both X and Y are the same size)
% there is one row (m) for each pair of random inputs (equal to simulation length)
% there is one column (n) for each of the iterations

[m, n] = size(x_vector);

% if there are more than twenty samples (pairs of random inputs), restrict the
% treatment to the last twenty. 
if m > 20
    k = m - 19;
else
    k = 1;
end


% now find vectors and plot
%--------------------------------------------------------------------------

for i = k:m-1 
    
    % find the largest magnitude, so that the X and Y axes can be scaled appropriately 
    largest_r = sqrt(x_vector(i,n)^2 + y_vector(i,n)^2);

    % set up vectors to draw the x axis... extend to 100% longer than the
    % maximum vector magnitude
    draw_x_axis = (0:0.01:(largest_r*2));
    draw_y_axis = zeros(1,length(draw_x_axis));
    
    % now, for each pair of random inputs, draw a graph of the rotation of the vector 

    figure(i)
    hold off
    
    % first plot the angle to which the iterations should converge
    plot([0 x_vector(i,1)*4], [0 (x_vector(i,1)*4*tand(z_vector(i,1)))], 'm-','LineWidth',0.5);
    
    hold all
        
    % draw the input vector (before any rotations)
    plot([0 x_vector(i,1)], [0 y_vector(i,1)], 'LineWidth',2);%,'m->','MarkerFaceColor','m');
    
    % now draw the vector after each rotation...
    for j = 2:n
        plot([0 x_vector(i,j)], [0 y_vector(i,j)], 'LineWidth',2);%,'k->','MarkerFaceColor','k');
    end
    
    % draw a dotted line to connect the ends of each of the vectors
    plot(x_vector(i,1:end), y_vector(i,1:end),'k:');
    
    % draw the X axis (vectors should be rotated towards this
    plot(draw_x_axis, draw_y_axis,'k-');
    
    % set up axes scaling...
    axis([0 (largest_r*1.1) -largest_r largest_r]);
    axis square
    
    % label axes
    xlabel('X');
    ylabel('Y');
    
    % provide a title...
    title('Rotation Mode Iterations');
    
    % add a legend at the right hand side
    % create a cell array containing the required strings
    legend_matrix = cell(1,n+1); 
    legend_matrix(1,1) = {'Reference'};
    legend_matrix(1,2) = {'Input'};
    for s = 3:n+1
        legend_matrix(1,s) = {['Iteration ', num2str(s-2)]};
    end
    legend(legend_matrix, 'Location', 'EastOutside');

end


% now plot the behaviour of the Z values during the iteration process
%-----------------------------------------------------------------------

marktype = ['s' 'v' '^' 'o' '>'];
markcolour = ['g' 'b' 'k' 'r' 'y' 'm' 'c'];
x_axis = [0:1:n-1];

figure(i+1)
hold off
plot([0 n-1],[0 0],'k:');
hold on
for j = 1:length(z_vector) - 1
   markcolour_index = 1+rem(j,length(markcolour));
   marktype_index = 1+rem(j,length(marktype));
   plot(x_axis,transpose(z_vector(j,1:end)),'k-','Color', markcolour(markcolour_index),'MarkerEdgeColor','k', 'MarkerFaceColor', markcolour(markcolour_index),'Marker', marktype(marktype_index));
end
xlabel('Iteration');
ylabel('Angle (degrees)');
title('Z Register');

% add a legend at the right hand side
% create a cell array containing the required strings
legend_matrix = cell(1,length(z_vector));
legend_matrix(1,1) = {'X axis'};
for t = 2:length(z_vector)
    legend_matrix(1,t) = {['Input Vector ', num2str(t-1)]};
end
legend(legend_matrix, 'Location', 'EastOutside');
