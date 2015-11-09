function [walls waypoints] = load_wpt(fname, load)
    if load == 0
        walls = [];
        waypoints = [];
    else
        walls = struct('X1',{},'Y1',{},'X2',{},'Y2',{},'Z1',{},'Z2',{});
        wall_count = 0;

        waypoints = struct('X',{},'Y',{},'Z',{},'angle',{},'name',{});
        way_count = 0;

        % Open the .wpt file
        f = fopen(fname,'r');

        % Read one line at a time
        nextline = fgets(f);
        while ischar(nextline)
            if numel(nextline) > 3
                if nextline(1:3) == 'WAY'
                    C = textscan(nextline,'%s%d%d%d%s%s','delimiter',',');
                    way_count = way_count + 1;
                    waypoints(way_count).X = C{2};waypoints(way_count).Y = C{3};waypoints(way_count).Z = C{4};
                    waypoints(way_count).angle = C{5};waypoints(way_count).name = C{6}{1};
                elseif nextline(1:3) == 'WAL'
                    C = textscan(nextline,'%s%d%d%d%d','delimiter',',');
                    wall_count = wall_count + 1;
                    walls(wall_count).X1 = C{2};walls(wall_count).X2 = C{4};
                    walls(wall_count).Y1 = C{3};walls(wall_count).Y2 = C{5};
                    walls(wall_count).Z1 = C{6};walls(wall_count).Z2 = C{7};
                end
            end
            nextline = fgets(f);
        end

        fclose(f);
    end