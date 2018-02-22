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

for k= 1:sz(1)
    directory = 'D:\Research_Paper_Work\ShortestPath_Fpga\Verilog_Synthesis\Shortest_path\Outputfile_';
    file = ['000',num2str(k-1),'.txt']; 
    
    while(length(file)>8)
        file(1)=[];
    end
    
    fID = fopen([directory, file],'r');
    a = fscanf(fID,'%s');
    haha=a;
    a = reshape(a',32,sz(2))';
    predlist(k,:)   = bin2dec(a(:,1:3))';
    weightlist(k,:) = bin2dec(a(:,4:11))';
    distlist (k,:)  = bin2dec(a(:,12:32))';
    
end
weightlist = weightlist
distlist   = distlist 
nextdist = nextdist
pred = pred 
predlist = predlist
testimage = testimage

p = sum(sum(~(predlist  == pred)))
w = sum(sum(~(weightlist == testimage)))
d=  sum(sum(~(distlist  == nextdist)))


if(sum(w+d+p) == 0)
    ' Awesome'
else
    ' Die '
end
