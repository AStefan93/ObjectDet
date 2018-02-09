function write_XmlCutImages(relPath,xmlpaths,commonPath,rootPath,ok)
    % save cut images
        % INPUT: xmlpaths - cell of all files .xml
            % commonPath - common path of the files .xml and .ppm
            % rootPath - folders: dvd1 or dvd2
            % relPath - relative path of the image
            % ok - flag to verify if an image has Left Eye coordonate
        % OUTPUT 


nr = 1;
for i = 1:length(relPath)
    if ok(i) == 1
        [newXml, relXmlPath] = get_info_xml(xmlpaths{i},relPath{i});
        Cell_newXml{nr} = newXml;
        Cell_newXmlPath{nr} = relXmlPath;
        nr = nr + 1;
    end
end

xmlPath = create_xmlPath(Cell_newXmlPath, commonPath, rootPath, Cell_newXml);

for i = 1:length(xmlPath)
    xmlwrite(xmlPath{i},Cell_newXml{i});
end

end