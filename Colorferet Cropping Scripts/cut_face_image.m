function outImage = cut_face_image(eyeDate, image)
    % crop the face of the image
        % INPUT: % eyeDate - cell of coordonate of Left Eye
            % image - cell of all read images
        % OUTPUT outImage - cell of images that have only the face
        global leftMar;
        global rightMar;
        global upMar;
        global downMar;
    
    for index = 1:length(eyeDate)
        if size(image{index},3) == 3
            grayImage{index} = rgb2gray(image{index});
        else
            grayImage{index} = image{index};
        end;
            outImage{index} = grayImage{index}((eyeDate{index}.y-upMar):(eyeDate{index}.y+downMar),(eyeDate{index}.x-leftMar):(eyeDate{index}.x+rightMar));
    end
end