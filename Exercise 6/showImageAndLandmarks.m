function varargout = showImageAndLandmarks(I,pixelSpacing,landmarksXY)

    % plot the image with physical coordinates
    imagescPhysical(I,pixelSpacing); % h is a handle to the image object, not the figure
    
    % plot the landmarks
    nrVertices = size(landmarksXY,1);
    lines = [1:nrVertices 1];
    hold on;

    plot(landmarksXY(lines,1),landmarksXY(lines,2),'r-');
    plot(landmarksXY(lines,1),landmarksXY(lines,2),'r*');
    hold off;
    
end

