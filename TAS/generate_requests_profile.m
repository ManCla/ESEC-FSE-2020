%function to generate a request profile

function requests_profile=generate_requests_profile()

primi_cinquanta=6*ones(50,1); %constant request arrival rate
secondi_undici=linspace(10,20,11)'; %ramp input
terzi_trentanove=3*ones(39,1);

requests_profile=[primi_cinquanta;
                  secondi_undici;
                  terzi_trentanove;
                  ];

%requests_profile=randi([1,10],400,1);
requests_profile=[requests_profile;zeros(30,1)];
end
