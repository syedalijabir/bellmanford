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
% --------------------------------------------------------------------------
% load corrected image
%

% load('test.mat');
for k=22
    img1 = imread(['Corrected Images\',num2str(k),'L.png']);
    img2 = imread(['Corrected Images\',num2str(k),'R.png']);
    % img2 = imread('Corrected Images\8R.png');
    img1g = double(rgb2gray(img1));
    img2g = double(rgb2gray(img2));
    testimage  = abs(img1g - img2g);
    % imshow(img,[])
    % testimage = imresize(testimage,0.2);

    testimage(1 , :)=0;
    testimage(end,:)=0;
    testimage=double(testimage);
    [r c] = size(testimage);
    sz=size(testimage);
    % figure(1)
    % imshow(testimage)

    dist =   1048576*ones(sz);
    pred = 6 *ones(sz);
    %initialize
    dist(1,1)=0;


    testimage;
    prevdist = dist;        % logic used for termination
    nextdist = dist;        % this image will be updated during the iterations
    for i=1:(sz(1)*sz(2));
     %-------------------------------------------------------------------------   
     i
        if (i==20)
            break;
        end
        for j=1:sz(2)-1
            temp = columnpair( testimage(:,j), testimage(:,j+1),  nextdist(:,j) , nextdist(:,j+1), pred(:,j),pred(:,j+1) );
            nextdist(:,  j) = temp(:,1);
            nextdist(:,j+1) = temp(:,2);
            pred(:,  j ) = temp(:,3);
            pred(:,j+1 ) = temp(:,4);
        end
     %-------------------------------------------------------------------------
        if(nextdist == prevdist)  % the loop will be broken if none of the value changes
            break;
        end
        prevdist=nextdist;        % assign the updated to the prev, and go for next iteration.
    %     figure(1)
    %     imshow(uint8(prevdist/5));
    %     iteration_result_dist(:,:,i) = nextdist;
    %     iteration_result_pred(:,:,i) = pred;

        %     figure(2)
    %     imshow(32*uint8(pred))
    % pause(0.0001)

    end
    figure(1)
    imshow(uint8(prevdist/5));

    % path calculation
    %%
    last=sz(1)*sz(2);
    path=[];
    f=1;
    while(f)
       path=[last path];
       if(last==1)
            f=0;
       end
       switch pred(last)
            case 0
                last = last + sz(1) + 0;
            case 1
                last = last + sz(1) - 1;
            case 2
                last = last +  0    - 1;
            case 3
                last = last - sz(1) - 1; 
            case 4
                last = last - sz(1) - 0;
            case 5
                last = last - sz(1) + 1;
            case 6
                last = last -  0    + 1;
            case 7
                last = last + sz(1) + 1;
            case -1
                f=0;
        end


    end

    path;
    path_xy=[];
    for i=1:length(path)
        x = mod(path(i),r);
        y = ceil(path(i)/r);
        path_xy = [x y; path_xy];
    end

    temp=testimage;
    temp(path)=255;

    show=cat(3,temp,testimage,testimage);
    figure
    imwrite(uint8(show),['Optimal Path\Path',num2str(i),'.png'],'png');
    % imshow(uint8(show))


    %% Stitching


    img_out = zeros(size(img1));
    i = 1;
    while i<=size(path_xy,1)-1
        i
        row   = path_xy(i,1);
        if (row ~= 0)
            count = path_xy(i,2);
            while (row == path_xy(i+1,1))
                i = i + 1;
                count  = path_xy(i,2);
                if (i == size(path_xy,1))
                    break;
                end
            end
            img_out(row,1:count,:) = img1(row,1:count,:);
            img_out(row,count+1:end,:) = img2(row,count+1:end,:);
        end
        i = i + 1;
    end

    % imshow(uint8(img_out))
    imwrite(uint8(img_out),['Stitched Images\Stitched',num2str(i),'.png'],'png');
end

display('Code Done...');

