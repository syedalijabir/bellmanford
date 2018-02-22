%
% Owner: Ali Jabir
% Email: syedalijabir@gmail.com
%
% Licensed under the Apache License, Version 2.0 (the "License");
% you may not use this file except in compliance with the License.
% You may obtain a copy of the License at
%
%     http://www.apache.org/licenses/LICENSE-2.0
%
% Unless required by applicable law or agreed to in writing, software
% distributed under the License is distributed on an "AS IS" BASIS,
% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
% See the License for the specific language governing permissions and
% limitations under the License.

close all
clear all
clc

%% Send/Recieve Blocks of an Image to FPGA using Serial Port
%  Syed Ali Jabir
%  Last Modified : 1st June 2013

r  = 128;
c  = 128;
pl = 3;         % Pyramid level
s = 2^pl;       % Number of pixels to be skipped for pyramid formation       
dr = r/s;
dc = c/s;
timg = uint8(randi(255,r,c));
if (0)
    save('img.mat','timg');
else
    load('img.mat');
end
timg = timg(1:r,1:c);
img = timg;

deci = downsample(downsample(downsample(downsample(downsample((downsample(img,2))',2)',2)',2)',2)',2)';
deci(1,:)=0;
deci(dr,:)=0;
lpf = deci;
for i=2:dr-1
    for j=2:dc-1
        lpf(i,j)=uint8(floor(sum(sum(deci(i-1:i+1,j-1:j+1)))/9));
    end
end

tic
delete(instrfind)
% sobj = serial('COM37','BaudRate',9600,'DataBits',8,'Parity','None','OutputBufferSize',r*c,'InputBufferSize',r*c,'TimeOut',100);
global SerialPort
SerialPort = serial('COM39','BaudRate',9600);
SerialPort.InputBufferSize = 10e6;
SerialPort.OutputBufferSize = 10e6;
SerialPort.TimeOut = 20;

display('Serial Object Created...')
fopen(SerialPort);
display('Serial Port Opened...')
display('Sending Pixels...')
toc

% while(5)
    tic
    fwrite(SerialPort,timg(:));
    toc
    
% pause
tic
data = fread(SerialPort, dr*dc,'uint8');
toc

fclose(SerialPort);
delete(SerialPort);

a = reshape(data,dr,dc);

sum(sum((uint8(a)-lpf)))

