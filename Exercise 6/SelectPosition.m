% Copyright Dirk-Jan Kroon
% Code covered by the BSD License 
% Downloaded as part of package ActiveModels_version7
% Download from Mathworks:
% http://www.mathworks.com/matlabcentral/fileexchange/26706

function varargout = SelectPosition(varargin)

% Detect callback and execute callback function
if nargin && ischar(varargin{1})
    gui_Callback = str2func(varargin{1});
    feval(gui_Callback,varargin{2:end});
    return
end

% Input arguments
data.Image=varargin{1};
data.shapex=varargin{2};
data.shapey=varargin{3};

% Start the figure/gui
handles.figure1=figure;
handles.axes1=axes;

% Show the image
hImg = imshow(data.Image,[]); hold on;
set(hImg,'HitTest','off');
title('Select the contour position');

% Make data structure
data.handles=handles;
data.mouse_position=[0 0];
data.mouse_position_last=[0 0];
data.image_position=[0 0];
data.handle_shape=[];

% Set mouse callbackes
set(data.handles.figure1,'WindowButtonMotionFcn','SelectPosition(''figure1_WindowButtonMotionFcn'')');
set(gcf,'WindowButtonDownFcn','SelectPosition(''axes1_ButtonDownFcn'')');
set(get(data.handles.axes1,'Children'),'ButtonDownFcn','SelectPosition(''axes1_ButtonDownFcn'')');
data.axes_size=get(data.handles.axes1,'PlotBoxAspectRatio');
data.done=false;
setMyData(data);

% Show contour on initial position
showcontour();

while(~data.done), pause(0.1); data=getMyData();  end

% Output arguments
varargout{1}=data.image_position(1);
varargout{2}=data.image_position(2);    

% Close the gui/figure
close(handles.figure1);


function figure1_WindowButtonMotionFcn()
cursor_position_in_axes();
data=getMyData(); if(isempty(data)), return, end
data.image_position=data.mouse_position([2 1]).*[size(data.Image,1) size(data.Image,2)];
setMyData(data); 
showcontour();

function axes1_ButtonDownFcn()
data=getMyData(); 
data.done=true;
setMyData(data);
        


function cursor_position_in_axes()
data=getMyData(); if(isempty(data)), return, end;
data.mouse_position_last=data.mouse_position;
p = get(data.handles.axes1, 'CurrentPoint');
data.mouse_position=[p(1, 1) p(1, 2)]./data.axes_size(1:2);
setMyData(data);

function showcontour()
data=getMyData(); if(isempty(data)), return, end;

if(ishandle(data.handle_shape)), delete(data.handle_shape); end
data.handle_shape=plot(data.shapey+data.image_position(2),data.shapex+data.image_position(1),'b.');
set(data.handle_shape,'HitTest','off');
setMyData(data);


function setMyData(data)
% Store data struct in figure
setappdata(gcf,'data2d',data);

function data=getMyData()
% Get data struct stored in figure
data=getappdata(gcf,'data2d');
