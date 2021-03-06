function integrImg = PixelsSum_integrImMethod(Image)
%   The function calculate the integral image of the input image

if size(Image,3) == 3
    warndlg('Image must be in grayscale!');
else
    Image2 = double(Image);
    [Image_height,Image_width] = size(Image2);
    
    row = 1;
    col = 1;
    
    % first column of integrImg
    integrImg(row,col) = Image2(1,1);
    for row = 2:1:Image_height
        integrImg(row,1) = integrImg(row-1,1) + Image2(row,1);
    end
    
    % calculation of integral image
    for col = 2:1:Image_width
        sum = Image2(1,col);
        integrImg(1,col) = integrImg(1,col-1) + sum;
        for row = 2:1:Image_height;
            sum = sum + Image2(row,col);
            integrImg(row,col) = integrImg(row,col-1) + sum;
        end
        
    end
end

end

