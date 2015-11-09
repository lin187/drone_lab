function plot_bots(fig, LINE_LEN, X_MAX, Y_MAX, Z_MAX, bots, waypoints, walls, disp_waypoints, disp_waypoint_names)
sfigure(fig);
n_wpt = length(waypoints);
n_wal = length(walls);
robot_count = size(bots,2);

%Calculate history
hist = [bots.drawhistory];
histX = reshape(hist(:,1:2:end),[],1);
histY = reshape(hist(:,2:2:end),[],1);
histZ = reshape(hist(:,3:2:end),[],1);

%Plot the waypoints and robot centers
clf(fig);
hold on;

%Plot history
plot3(histX, histY,histZ, 'ko', 'MarkerSize', 2);

plot3([bots.X], [bots.Y],[bots.Z],'ro','MarkerFaceColor','r');
if n_wpt > 0 && disp_waypoints == 1
    plot([waypoints.X], [waypoints.Y],[waypoints.Z], 'bo');
end
hold off;



%Print waypoint names 
if n_wpt > 0 && disp_waypoint_names == 1
    for i = 1:n_wpt
        text(double(waypoints(i).X-120),double(waypoints(i).Y-80),waypoints(i).name,'Color','b');
%______________________how to change to 3d
    end
end


%Plot the walls
for i = 1:n_wal
   line3([walls(i).X1 walls(i).X2],[walls(i).Y1 walls(i).Y2],[walls(i).Z1 walls(i).Z2], 'LineWidth',2,'Color','k');
end

%Plot the line, circle, and name
for i = 1:robot_count
    line([bots(i).X cosd(bots(i).yaw)*LINE_LEN+bots(i).X],[bots(i).Y sind(bots(i).yaw)*LINE_LEN+bots(i).Y],'Color','k');
    rectangle('position',[bots(i).X-LINE_LEN, bots(i).Y-LINE_LEN, 2*LINE_LEN, 2*LINE_LEN],'curvature',[1 1],'LineWidth',1);
    text(double(bots(i).X-LINE_LEN),double(bots(i).Y-LINE_LEN/.65),bots(i).name)
    %If the robot is not currently visible, mark it
    if bots(i).visible == 0
       rectangle('position',[bots(i).X-LINE_LEN, bots(i).Y-LINE_LEN, 2*LINE_LEN, 2*LINE_LEN],'LineWidth',1,'EdgeColor','r');
    end
end
axis([0 X_MAX 0 Y_MAX 0 Z_MAX]);
drawnow

    