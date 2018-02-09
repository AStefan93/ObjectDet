function write_CutImages( cellImages, commonPath, rootPath, relativePath)
    % save cut images
        % INPUT: cellImages - cell of all cut images
            % commonPath - common path of the files .xml and .ppm
            % rootPath - folders: dvd1 or dvd2
            % relativePath - relative path of the image
            % ok - flag to verify if an image has Left Eye coordonate
        % OUTPUT 

contor = 0;
for index = 1:length(cellImages)
        % create path up to ..\data
        path_index = strfind(relativePath{index},'images');
        parentFolder = relativePath{index}(1:path_index - 1);
        parentPath = fullfile(commonPath, rootPath, parentFolder);
        
        % replace in path 'images' with 'cut_images'
        if  path_index > 0
            newRelPath = fullfile(parentPath,'cut_images');
            contor = contor + 1;
        end
        % create only one folder 'cut_images'
        if contor == 1
           mkdir(parentPath,'cut_images');
        end
        
        % take name of the folder
        newImFolder = strrep(relativePath{index},'data/images/','');

        folderName{index} = strtok(newImFolder,'/');
        
        %create folders for every cut image
        if index >=2
            if length(strfind(folderName{index},folderName{index-1})) < 1 
                mkdir(newRelPath,folderName{index});
            end
        else
            mkdir(newRelPath,folderName{index});
        end
        % take name of the cut image and convert to .png

        cutImName = newImFolder(length(folderName{index})+1:length(newImFolder));
        cutImName = strrep(cutImName,'.ppm','.png');
        
        cutImPath{index} = fullfile(newRelPath,folderName{index},cutImName);
        
        imwrite(cellImages{index},cutImPath{index});      
end

end