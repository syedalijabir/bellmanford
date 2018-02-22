close all
clear all
clc
% --------------------------------------------------------------------------
% load image
r=8;
c=8;
if (0)
   testimage = uint8(randi(255,r,c)-1);
   save img.mat
else
   load img.mat 
end
testimage = timg(1:r,1:c);
testimage(1 , :)=0;
testimage(end,:)=0;
testimage=double(testimage);

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
    iteration_result_dist(:,:,i) = nextdist;
    iteration_result_pred(:,:,i) = pred;

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

temp=testimage;
temp(path)=255;

show=cat(3,temp,testimage,testimage);
figure
imshow(uint8(show))


%%
%---------------------------- testing  ------------------------------------





