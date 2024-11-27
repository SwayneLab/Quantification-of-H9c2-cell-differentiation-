
image = imread('filepath');
if size(image, 3) == 3
    image = rgb2gray(image);
end
figure;
imshow(image);
title('Draw a rough polygon around each cell. Double-click to complete.');
allMasks = false(size(image));  
cellAreas = [];
cellPerimeters = [];
cellLengths = [];
cellEccentricities = [];
cellCount = 0;
keepSelecting = true;
while keepSelecting
    cellCount = cellCount + 1;
    h = drawpolygon('LineWidth', 2, 'Color', 'cyan');
    wait(h);
    polygonPosition = h.Position;
    roughMask = createMask(h, image);
    maskedImage = immultiply(image, uint8(roughMask));
    level = graythresh(maskedImage)*1.5;
    bw = imbinarize(maskedImage, level);
imshow(bw);
title('Binarized Image');
bw = imfill(bw, 'holes');
figure; 
imshow(bw);
title('Image after Filling Holes');
    bw = bwareaopen(bw, 100);  
figure; 
imshow(bw);
title('Image after Removing Small Objects');
    cellArea = sum(bw(:));
    cellAreas(end+1) = cellArea;
    cellPerimeter = calculatePerimeter(bw);
    cellPerimeters(end+1) = cellPerimeter;
    [cellEccentricity, cellLength] = calculateShapeMetrics(bw);
    cellEccentricities(end+1) = cellEccentricity;
    cellLengths(end+1) = cellLength;
    allMasks = allMasks | bw;
    hold on;
    centroid = mean(polygonPosition, 1);
    text(centroid(1), centroid(2), sprintf('%d: Area=%d, Perim=%d, Ecc=%.2f, Length=%.2f', cellCount, cellArea, cellPerimeter, cellEccentricity, cellLength), 'Color', 'yellow', 'FontSize', 12, 'FontWeight', 'bold');
    choice = questdlg('Do you want to select another cell?', 'Continue Selection', 'Yes', 'No', 'Yes');
    keepSelecting = strcmp(choice, 'Yes');
end
figure;
imshow(image); 
hold on;
visboundaries(allMasks, 'Color', 'r'); 
title('All Segmented Cells with Numbers');
hold off;
function perimeter = calculatePerimeter(bw)
    [rows, cols] = size(bw);
    bw_padded = padarray(bw, [1, 1], 0);
    perimeter = 0;
    for r = 2:(rows+1)
        for c = 2:(cols+1)
            if bw_padded(r, c) == 1
                neighbors = bw_padded(r-1:r+1, c-1:c+1);
                if any(neighbors(:) == 0)
                    perimeter = perimeter + 1;
                end
            end
        end
    end
end
function [eccentricity, length] = calculateShapeMetrics(bw)
    [rows, cols] = find(bw);
    centroid = mean([cols, rows]);
    cols = cols - centroid(1);
    rows = rows - centroid(2);
    covMatrix = cov(cols, rows);
    eigenvalues = eig(covMatrix);
    a = sqrt(max(eigenvalues));
    b = sqrt(min(eigenvalues));
    eccentricity = sqrt(1 - (b^2 / a^2));
    length = a;
end
