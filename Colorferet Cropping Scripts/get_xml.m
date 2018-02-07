function [xmlFa,commonPath] = get_xml
    % Start with a folder and get a list of all subfolders.
    % Finds and prints names of all .xml files in
    % that folder and all of its subfolders.
        % INPUT: 
        % OUTPUT xmlFa - cell of all files .xml
             % commonPath - common path of the files .xml and .ppm
        
% Define a starting folder.
start_path = fullfile(matlabroot,'toolbox','matlab','general');
% Ask user to confirm or change.
topLevelFolder = uigetdir(start_path);
if topLevelFolder == 0
    return;
end
% Get list of all subfolders.
allSubFolders = genpath(topLevelFolder);
% Parse into a cell array.
remain = allSubFolders;
listOfFolderNames = {};
while true
    [singleSubFolder, remain] = strtok(remain, ';');
    if isempty(singleSubFolder)
        break;
    end
    listOfFolderNames = [listOfFolderNames singleSubFolder];
end
numberOfFolders = length(listOfFolderNames)
Path = listOfFolderNames{1};

if strfind(char(Path),'\dvd1')
        flag = strfind(char(Path),'\dvd1');
        commonPath = char(Path(1:flag-1));
else
    if strfind(char(Path),'\dvd2')
        flag = strfind(char(Path),'\dvd2');
        commonPath = char(Path(1:flag-1));
    end

index = 1;
index_fa = 1;
% Process all image files in those folders.
for k = 1 : numberOfFolders
    % Get this folder and print it out.
    thisFolder = listOfFolderNames{k};
    
    % Get XML files.
    filePattern = sprintf('%s/*.xml', thisFolder);
    baseFileNames = dir(filePattern);
    numberOfImageFiles = length(baseFileNames);
    % Now we have a list of all files in this folder.
    
    if numberOfImageFiles >= 1
        % Go through all those image files.
        for f = 1 : numberOfImageFiles
            xml{index} = fullfile(thisFolder, baseFileNames(f).name);
            
            if strfind(baseFileNames(f).name,'fa')
                xmlFa{index_fa} = xml{index};
                index_fa = index_fa + 1;
            end
            index = index + 1;
            
        end
    else
        fprintf('     Folder %s has no xml files in it.\n', thisFolder);
    end
end

end
