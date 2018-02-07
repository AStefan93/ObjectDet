function [LeftEye,relativePath,rootPath,ok] = get_atrPosition(filePath)
    % save path of images and coordonate for Left Eye
        % INPUT: % filePath - cell with paths of images
        % OUTPUT LeftEye - cell of coordonate of Left Eye
            % relativePath - relative path of the image
            % rootPath - folders: dvd1 or dvd2 
            % ok - flag to verify if an image has Left Eye coordonate
            
builder = javax.xml.parsers.DocumentBuilderFactory.newInstance;

% Disable validation
builder.setFeature('http://apache.org/xml/features/nonvalidating/load-external-dtd', false);

index_le = 1;
ok = zeros(1,length(filePath));
for index = 1:length(filePath)
    % Read your file
    xDoc = xmlread(filePath{index},builder);
    allListItems = xDoc.getElementsByTagName('Recording');
    thisListitem = allListItems.item(0);
    
    %get relative path of the image
    thisItem_path = thisListitem.getElementsByTagName('URL');
    pathElement = thisItem_path.item(0);
    
    path_root = pathElement.getAttribute('root');
    if strfind(char(path_root),'Disc1') | strfind(char(path_root),'Disc2')
        rootPath = 'dvd2';
    end
    
    path = pathElement.getAttribute('relative');
    if strfind(char(path),'.bz2')
        relativePath{index} = strrep(char(path),'.bz2','');
    end
    
    thisList = thisListitem.getElementsByTagName('LeftEye');
    thisElement = thisList.item(0);
    
    %verify if xml file has node: LeftEye
    if isempty(thisElement) == 0
        valLeftEye_x = thisElement.getAttribute('x');
        valLeftEye_y = thisElement.getAttribute('y');
        
        fieldx = 'valLeftEye_x';
        fieldy = 'valLeftEye_y';
        
        LeftEye{index_le} = struct(fieldx, str2num(valLeftEye_x), fieldy, str2num(valLeftEye_y));
        index_le = index_le + 1;
        ok(index) = 1;
    else
        ok(index) = 0;
    end
end

end



