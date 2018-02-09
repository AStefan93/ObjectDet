function xmlPaths = create_xmlPath(relativePath_xml, commonPath, rootPath, newXml)
    % save cut images
        % INPUT: commonPath - common path of the files .xml and .ppm
            % rootPath - folders: dvd1 or dvd2
            % relativePath_xml - relative path of the xml file
            % xmlFile - new xml file
        % OUTPUT xmlPaths - new xml path
            
    contor = 0;
for index = 1:length(newXml)
        % create path up to ..\data
        path_index = strfind(relativePath_xml{index},'cut_images');
        parentFolder = relativePath_xml{index}(1:path_index - 1);
        parentPath = fullfile(commonPath, rootPath, parentFolder);
        
        % replace in path 'cut_images' with 'cut_images_xml'
        if  path_index > 0
            newRelPath = fullfile(parentPath,'cut_images_xml');
            contor = contor + 1;
        end
        % create only one folder 'cut_images_xml'
        if contor == 1
           mkdir(parentPath,'cut_images_xml');
        end
        
        % take name of the folder
        newImFolder = strrep(relativePath_xml{index},'data/cut_images/','');
%         folderPath = fullfile(parentPath,'cut_images',newImFolder);
        folderName{index} = strtok(newImFolder,'/');
        
        %create folders for every cut image
        if index >=2
            if length(strfind(folderName{index},folderName{index-1})) < 1 
                mkdir(newRelPath,folderName{index});
            end
        else
            mkdir(newRelPath,folderName{index});
        end
        
        cutImName = newImFolder(length(folderName{index})+1:length(newImFolder));
        cutImName = strrep(cutImName,'.png','.xml');
        
        xmlPaths{index} = fullfile(newRelPath,folderName{index},cutImName);
        
end
end