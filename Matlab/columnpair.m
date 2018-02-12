% Copyright (c) 2018, Xgrid Inc, http://xgrid.co
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

function res = columnpair(wa,wb, da,db,pa,pb)
   for k=1:2:length(wa)-1
           
            
            %=============================================================
            % for vertical edges
            t1 = da(k);
            if(   da(k)> da(k+1)+wa(k))
                pa(k) = 6; % down
                da(k)   = da(k+1)+wa(k);  
            end
            if( da(k+1)> t1 +  wa(k+1))
                pa(k+1) = 2; % up
                da(k+1) = t1 +  wa(k+1);
            end
            %----------
            t2 = db(k);
            if(   db(k)> db(k+1)+wb(k))
                pb(k) =6; % down
                db(k)   =  db(k+1)+wb(k);
            end
            if( db(k+1)> t2 +  wb(k+1))
                pb(k+1)=2; % up
                db(k+1) = t2 +  wb(k+1);
            end
            
            % for horizontal edges                             a(1) b(1)   
            %                                                  a(2) b(2)         
            %=============================================================
            t1= da(k);
            if(da(k)  >  db(k)+wa(k))
                pa(k) = 0; % right
                da(k) = db(k)+wa(k);
            end
            if(db(k)  >  t1   +wb(k))
                pb(k) = 4; % left
                db(k) = t1   +wb(k);
            end
            %-------
            t2= da(k+1);
            if( da(k+1)>  db(k+1)+wa(k+1) ) 
                pa(k+1)= 0; % right
                da(k+1) = db(k+1)+wa(k+1) ;      
            end
            if( db(k+1)>  t2     +wb(k+1) ) 
                pb(k+1)= 4; % left
                db(k+1) = t2     +wb(k+1);
            end
   
            
            %=============================================================
            % for diagonal edges
            
            t1 = da(k);
            if(da(k)>  wa(k) + db(k+1) )
                pa(k) = 7; % right down
                da(k)   = wa(k) + db(k+1);
            end
            if(db(k+1)>wb(k+1)+ t1)
                pb(k+1) = 3; %left up
                db(k+1) = wb(k+1)+ t1;
            end
            %----------
            t2 = db(k);
            if(db(k)>  wb(k) + da(k+1) )
                pb(k) = 5 ; %left down
                db(k)   = wb(k) + da(k+1);
            end
            if(da(k+1)> wa(k+1) + t2 )
                pa(k+1) = 1 ; % right up
                da(k+1) = wa(k+1) + t2 ;
            end
           
            
   end
   
   for k=2:2:length(wa)-1
            
            %=============================================================
            % for vertical edges
            t1 = da(k);
            if(   da(k)> da(k+1)+wa(k))
                pa(k) = 6; % down
                da(k)   = da(k+1)+wa(k);  
            end
            if( da(k+1)> t1 +  wa(k+1))
                pa(k+1) = 2; % up
                da(k+1) = t1 +  wa(k+1);
            end
            %----------
            t2 = db(k);
            if(   db(k)> db(k+1)+wb(k))
                pb(k) =6; % down
                db(k)   =  db(k+1)+wb(k);
            end
            if( db(k+1)> t2 +  wb(k+1))
                pb(k+1)=2; % up
                db(k+1) = t2 +  wb(k+1);
            end
            
            % for horizontal edges                             a(1) b(1)   
            %                                                  a(2) b(2)         
            %=============================================================
            t1= da(k);
            if(da(k)  >  db(k)+wa(k))
                pa(k) = 0; % right
                da(k) = db(k)+wa(k);
            end
            if(db(k)  >  t1   +wb(k))
                pb(k) = 4; % left
                db(k) = t1   +wb(k);
            end
            %-------
            t2= da(k+1);
            if( da(k+1)>  db(k+1)+wa(k+1) ) 
                pa(k+1)= 0; % right
                da(k+1) = db(k+1)+wa(k+1) ;      
            end
            if( db(k+1)>  t2     +wb(k+1) ) 
                pb(k+1)= 4; % left
                db(k+1) = t2     +wb(k+1);
            end
    
            
            %=============================================================
            % for diagonal edges
            
            t1 = da(k);
            if(da(k)>  wa(k) + db(k+1) )
                pa(k) = 7; % right down
                da(k)   = wa(k) + db(k+1);
            end
            if(db(k+1)>wb(k+1)+ t1)
                pb(k+1) = 3; %left up
                db(k+1) = wb(k+1)+ t1;
            end
            %----------
            t2 = db(k);
            if(db(k)>  wb(k) + da(k+1) )
                pb(k) = 5 ; %right up
                db(k)   = wb(k) + da(k+1);
            end
            if(da(k+1)> wa(k+1) + t2 )
                pa(k+1) = 1 ; % left down
                da(k+1) = wa(k+1) + t2 ;
            end

   end

res=[da,db,pa,pb];
end

