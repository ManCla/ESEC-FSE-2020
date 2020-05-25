%main script for running several executions of TAS
clear all
%close all
random_seed=98766867; %store for repeatibility
rng(random_seed)

%% testing parameters
num_tests=500;
num_testset=1;

%% testing conditions (the ones that are the same in all the tests)
num_providers=[60,20,15];
adaptation_gain=50;

%% initialize store variables
total_requests=zeros(num_tests,1);
service_rate=zeros(num_tests,num_testset);
total_num_fails=zeros(num_tests,num_testset);
avg_num_attempts=zeros(num_tests,num_testset);

max_avg_num_attempts=zeros(num_tests+1,num_testset);
max_fails=zeros(num_tests+1,num_testset);

%% run tests
%testset loop
for jj=1:num_testset
%main tests loop
for j=1:num_tests
    %GENERATE RANDOMIZED TESTING CONDITIONS
    %generate request profile
    requests_profile=generate_requests_profile_randomized();
    total_requests(j)=sum(requests_profile);
    %probabilities of a request being respectively all_good, drug or ambulance
    drug_prob=0.20+rand*(0.40-0.20);
    ambulance_prob=0.15+rand*(0.30-0.15);
    type_of_requests=[1-ambulance_prob-drug_prob,drug_prob,ambulance_prob];
    
    %RUN TAS
    res=run_TAS(requests_profile,type_of_requests,num_providers,adaptation_gain);
    
    %STORE TEST OUTCOME
    total_num_fails(j,jj)=res.fail; %number of times a service has failed a request
    avg_num_attempts(j,jj)=(sum(requests_profile)+total_num_fails(j))/sum(requests_profile);
    max_avg_num_attempts(j+1,jj)=max(avg_num_attempts(j,jj),max_avg_num_attempts(j,jj));
    max_fails(j+1,jj)=max(total_num_fails(j,jj),max_fails(j,jj));
end %main test loop
if num_testset>1
    disp(['I have executed test set number:',int2str(jj)])
end
end %testset loop


%% plot for only one test set
if num_testset==1
    disp(['-----------------------------------------------------'])
    disp(['In each of the the tests have been processed in average a total of:',num2str(mean(total_requests))])
    disp(['The worst case average number of attempts is:',num2str(max(avg_num_attempts))])
    disp(['The average average number of attempts is:',num2str(mean(avg_num_attempts))])
    disp(['The std of the sampled mean average number of attempts is:',num2str(sqrt(var(avg_num_attempts)/num_tests))])
    % total number of fails and average number of attempts should say the 
    % same things if the total number of requests is the same
    %disp(['The worst case total number of fails is:',num2str(max(total_num_fails))])
    figure
    histogram(avg_num_attempts,40)
    title('distribution of average number of attempts')
    %figure
    %histogram(total_num_fails,40)
    %title('distribution of total number of fails')
    %figure
    %plot(max_fails)
    %title('growth over the tests of maximum total number of failed requests')
    
    %EXTREME VALUE ANALYSIS
    ordered = sort(avg_num_attempts);
    
    number_datapoints=floor(length(avg_num_attempts)*(90)/100);
    maxima=ordered(number_datapoints:end);
    excedances=maxima-ordered(number_datapoints-1); %compute excedances
    disp(['The threshold for the EVT evaluation is:',num2str(ordered(number_datapoints-1))])
    n_maxima=length(excedances);
    [paramhat,paramci] = gpfit(excedances); % gpd fitting
    disp(['The estimated parameters for the GPD are:',num2str(paramhat)])
    figure
    histogram(excedances,20)
    xgrid = linspace(0,max(excedances),1000);
    line(xgrid,1*gppdf(xgrid,paramhat(1),paramhat(2),excedances(1)));
    grid
    %compute probability of the maximum observed actually being the maximum
    evt_max_prob=(1-cdf('Generalized Pareto',max(excedances),paramhat(1),paramhat(2),excedances(2))) ...
                *(n_maxima/num_tests);
    disp(['EVT: the probability of observing in the future a worst case ', ...
          'worst than what observed so far is:',num2str(evt_max_prob)])

end


%% plot for many testset
if num_testset>1
    figure
    title('growth over the tests of maximum total number of failed requests')
    hold on
    for jj=1:num_testset
        plot(max_fails(:,jj))
    end
end
if num_testset>1
    figure
    title('growth over the tests of maximum total number of failed requests')
    hold on
    for jj=1:num_testset
        plot(max_avg_num_attempts(:,jj))
    end
end