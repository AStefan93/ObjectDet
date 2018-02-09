 function [newXml, relXmlPath] = get_info_xml(xmlFile,relFilePath)
    % save characteristics from xml
        % INPUT: % relFilePath - relative path of the image
            % xmlFile - file .xml
        % OUTPUT newXml - new xml
            % relXmlPath - relative path of the xml file          
builder = javax.xml.parsers.DocumentBuilderFactory.newInstance;

% Disable validation
builder.setFeature('http://apache.org/xml/features/nonvalidating/load-external-dtd', false);

global leftMar;
global upMar;

    
    % Read your file
    xDoc = xmlread(xmlFile,builder);
    allListItems = xDoc.getElementsByTagName('Recording');
    thisListitem = allListItems.item(0);
    
    %get relative path of the image
    thisItem_path = thisListitem.getElementsByTagName('URL');
    pathElement = thisItem_path.item(0);
    
    path = pathElement.getAttribute('relative');
    if strfind(char(path),'.ppm.bz2')
        relFilePath = strrep(char(path),'.ppm.bz2','.png');
        relFilePath = strrep(relFilePath,'images','cut_images');
    end
    
    relXmlPath = relFilePath;
    
    thisList = thisListitem.getElementsByTagName('LeftEye');
    thisElement = thisList.item(0);
    
    %verify if xml file has node: LeftEye
    if isempty(thisElement) == 0
        valLeftEye_x = thisElement.getAttribute('x');
        valLeftEye_y = thisElement.getAttribute('y');
        
        fieldx_l = 'x';
        fieldy_l = 'y';
        
        LeftEye = struct(fieldx_l, str2num(valLeftEye_x), fieldy_l, str2num(valLeftEye_y));
    end
    
    thisList = thisListitem.getElementsByTagName('RightEye');
    thisElement = thisList.item(0);
    
    %verify if xml file has node: RightEye
    if isempty(thisElement) == 0
        valRightEye_x = thisElement.getAttribute('x');
        valRightEye_y = thisElement.getAttribute('y');
        
        fieldx_r = 'x';
        fieldy_r = 'y';
        
        RightEye = struct(fieldx_r, str2num(valRightEye_x), fieldy_r, str2num(valRightEye_y));
    end
    
    thisList = thisListitem.getElementsByTagName('Mouth');
    thisElement = thisList.item(0);
    
    %verify if xml file has node: Mouth
    if isempty(thisElement) == 0
        valMouth_x = thisElement.getAttribute('x');
        valMouth_y = thisElement.getAttribute('y');
        
        fieldx_m = 'x';
        fieldy_m = 'y';
        
        Mouth = struct(fieldx_m, str2num(valMouth_x), fieldy_m, str2num(valMouth_y));
    end
    
    thisList = thisListitem.getElementsByTagName('Nose');
    thisElement = thisList.item(0);
    
    %verify if xml file has node: Nose
    if isempty(thisElement) == 0
        valNose_x = thisElement.getAttribute('x');
        valNose_y = thisElement.getAttribute('y');
        
        fieldx_n = 'x';
        fieldy_n = 'y';
        
        Nose = struct(fieldx_n, str2num(valNose_x), fieldy_n, str2num(valNose_y));
    end
    
    thisList = thisListitem.getElementsByTagName('Expression');
    thisElement = thisList.item(0);
    
    %verify if xml file has node: Expression
    if isempty(thisElement) == 0
        valName = thisElement.getAttribute('name');
        
        field_ex = 'name';
        
        Expression = struct(field_ex, valName);
    end
    
    thisList = thisListitem.getElementsByTagName('Hair');
    thisElement = thisList.item(0);
    
    %verify if xml file has node: Hair
    if isempty(thisElement) == 0
        valBeard = thisElement.getAttribute('beard');
        valMustache = thisElement.getAttribute('mustache');
        valSource = thisElement.getAttribute('source');
        
        field_bd = 'beard';
        field_mus = 'mustache';
        field_s = 'source';
        
        Hair = struct(field_bd, valBeard, field_mus, valMustache, field_s, valSource);
    end
    
    thisList = thisListitem.getElementsByTagName('Wearing');
    thisElement = thisList.item(0);
    
    %verify if xml file has node: Wearing
    if isempty(thisElement) == 0
        valGlasses = thisElement.getAttribute('glasses');
        
        field_gl = 'glasses';
        
        Wearing = struct(field_gl, valGlasses);
    end
    
    thisList = thisListitem.getElementsByTagName('Pose');
    thisElement = thisList.item(0);
    
    %verify if xml file has node: Pose
    if isempty(thisElement) == 0
        valName = thisElement.getAttribute('name');
        valYaw = thisElement.getAttribute('yaw');
        valPitch = thisElement.getAttribute('pitch');
        valRoll = thisElement.getAttribute('roll');
        
        field_name = 'name';
        field_yaw = 'yaw';
        field_pitch = 'pitch';
        field_roll = 'roll';
        
        Pose = struct(field_name, valName, field_yaw, str2num(valYaw), field_pitch, str2num(valPitch), field_roll, str2num(valRoll));
    end
    
    newLeftEye = struct('x',[],'y',[]);
    
    % new coordonate
    newLeftEye.x = LeftEye.x - leftMar;
    newLeftEye.y = LeftEye.y - upMar;
    
    newRightEye.x = RightEye.x - newLeftEye.x;
    newRightEye.y = RightEye.y - newLeftEye.y;
    
    newNose.x = Nose.x - newLeftEye.x;
    newNose.y = Nose.y - newLeftEye.y;
    
    newMouth.x = Mouth.x - newLeftEye.x;
    newMouth.y = Mouth.y - newLeftEye.y;
    
    % create xml
    
    newXml = com.mathworks.xml.XMLUtils.createDocument('Recordings');
    Recordings = newXml.getDocumentElement;
    product = newXml.createElement('URL');
    product.setAttribute('relative',relFilePath);
    face = newXml.createElement('Face');
    
    pose = newXml.createElement('Pose');
    pose.setAttribute('name',Pose.name);
    pose.setAttribute('yaw',num2str(Pose.yaw));
    pose.setAttribute('pitch',num2str(Pose.pitch));
    pose.setAttribute('roll',num2str(Pose.roll));
    
    wearing = newXml.createElement('Wearing');
    wearing.setAttribute('glasses',Wearing.glasses);
    
    hair = newXml.createElement('Hair');
    hair.setAttribute('beard',Hair.beard);
    hair.setAttribute('mustache',Hair.mustache);
    hair.setAttribute('source',Hair.source);
    
    expression = newXml.createElement('Expression');
    expression.setAttribute('name',Expression.name);
    
    lefteye = newXml.createElement('LeftEye');
    lefteye.setAttribute('x',num2str(newLeftEye.x));
    lefteye.setAttribute('y',num2str(newLeftEye.y));
    
    righteye = newXml.createElement('RightEye');
    righteye.setAttribute('x', num2str(newRightEye.x));
    righteye.setAttribute('y', num2str(newRightEye.y));
    
    nose = newXml.createElement('Nose');
    nose.setAttribute('x',  num2str(newNose.x));
    nose.setAttribute('y',  num2str(newNose.y));
    
    mouth = newXml.createElement('Mouth');
    mouth.setAttribute('x', num2str(newMouth.x));
    mouth.setAttribute('y', num2str(newMouth.y));
    
    Recordings.appendChild(product);
    product.appendChild(face);
    face.appendChild(pose);
    face.appendChild(wearing);
    face.appendChild(hair);
    face.appendChild(expression);
    face.appendChild(lefteye);
    face.appendChild(righteye);
    face.appendChild(nose);
    face.appendChild(mouth);
    
    xmlwrite('abcd.xml',newXml);

 end



