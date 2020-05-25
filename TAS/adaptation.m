% function that implements the adaptation algorithm for the choice of the
% providers for the different services

function new_controller_state=adaptation(success ,fail ,controller_state, gain)

% for iii=1:length(success)     
%     if success(iii)==0 && fail(iii)>0 %attempt to recognize very weak providers and down providers
%         new_controller_state(iii)=1;
% %    elseif success(iii)==0 && fail(iii)==0 % to not completely forget about providers
% %        new_controller_state(iii)=controller_state(iii);
%     else
%         new_controller_state(iii)=controller_state(iii)+gain*success(iii)-gain*fail(iii);
%     end
% end    


%%    Carota e bastone with gain ±1 and some saturation
new_controller_state=controller_state+gain*success-gain*fail;

%% uniform control strategy (equivalent to setting gain=0)
%new_controller_state = controller_state;

%% saturation
new_controller_state=min(max(new_controller_state,1),1000); 

end
