clc;
clear all;
close all;

global currentPath
currentPath = cd;

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










