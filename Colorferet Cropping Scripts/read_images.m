function images = read_images(pathFolder,rootPath,filePath,ok)
    % read all images that have coordonate for LeftEye
        % INPUT: pathFolder - folder of images
            % rootPath - folders: dvd1 or dvd2
            % filePath - path of the image
            % ok - flag to verify if an image has Left Eye coordonate
        % OUTPUT images - cell of all read images
        
    global currentPath;
    
    cd = fullfile(pathFolder,rootPath);
    index = 1;
    
    %verify if image has Left Eye coordonate
    for i = 1:length(filePath)
        if ok(i) == 1
            images_path_index = fullfile(cd,filePath{i});
            images{index} = imread(images_path_index);
            index = index+1;
        end
    end
    
    cd = currentPath;
end