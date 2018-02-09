clc;
clear all;
close all;

global currentPath
global leftMar;
global rightMar;
global upMar;
global downMar;
currentPath = cd;
leftMar = 200;
rightMar = 65;
upMar = 140;
downMar = 205;
    
    % take all .xml files with 'fa'
    [xmlpaths,folderPath] = get_xml;
    % save image path and coordonate for Left Eye
    [LeftEyeCell,relPath,rootPath,ok] = get_atrPosition(xmlpaths);
    % read all images
    images = read_images(folderPath,rootPath,relPath,ok);
    % crop images
    cutIm = cut_face_image(LeftEyeCell,images);
    % save cut images in folders
    write_CutImages(cutIm, folderPath,rootPath,relPath);
    % write new files .xml 
    write_XmlCutImages(relPath,xmlpaths,folderPath,rootPath,ok);










