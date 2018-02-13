function [] = print_result_array_target(vvvv)

 [M,I] = max(vvvv);

msg=['Rakam Tesbit edildi :',num2str(I)];
msg2=['birseyler bozulu eroor errooooor'];

disp(msg);

 
%  
%  switch I
%     case 0
%         disp(msg);
%     case 1
%         disp(msg);
%     case 2
%         disp(msg);
%     case 3
%         disp(msg);
%     case 4
%         disp(msg);
%     case 5
%         disp(msg);
%     case 6
%         disp(msg);
%     case 7
%         disp(msg);
%     case 8
%         disp(msg);
%     case 9
%         disp(msg);
%     otherwise
%         disp(msg2);
%   end
 
%  
% if(vvvv>0.7000)
%   
% msg=['test sonucu : 2 ; hesaplanan deger :',num2str(vvvv)];
% else
%     
%  msg=['test sonucu : 1 ;hesaplanan deger :',num2str(vvvv)];
% end
% 
% disp(msg)

end