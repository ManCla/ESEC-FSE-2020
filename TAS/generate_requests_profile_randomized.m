%function to generate a request profile

function requests_profile=generate_requests_profile_randmized()


primi_cinquanta=40*ones(50,1)+floor((rand(50,1)-0.5)*30); %constant request arrival rate
secondi_undici=linspace(50,200,11)'+floor((rand(11,1)-0.5)*40); %ramp input
terzi_trentanove=3*ones(39,1)+floor((rand(39,1))*70);

requests_profile=[primi_cinquanta;
                  secondi_undici;
                  terzi_trentanove;
                  ];

%requests_profile=randi([1,10],400,1);
requests_profile=[requests_profile;zeros(50,1)];
end
