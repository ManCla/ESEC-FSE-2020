# ESEC-FSE-2020
This repository complements the paper: 

  "*Testing Self-Adaptive Software with Probabilistic Guarantees on Performance Metrics*"
  
  Claudio Mandrioli, Martina Maggio
  
  European Software Engineering Conference and Symposium on the Foundations of Software Engineering (ESEC/FSE) 2020

## Short paper sumary
In the paper, we formulate the problem of testing a software that adapts itself as a chance-contrained optimization problem. Normally we test software systems to provide guarantees on their behavior. However, adaptive software changes its behavior, so we cannot say that we tested it in all the possible configurations (the configuration space may be infinite or anyway very very large). Generally speaking, because we adapt, we cannot give formal guarantees that the software will always do the right thing (e.g., it still has to explore alternatives to learn what to do properly). So we need to move into the space of probabilistic guarantees (the probability that we will not see a response time higher than the highest that we have seen in all our tests is X). The paper explores the theories that can be used to formulate the described problem and what results can be obtained. Techniques from traditional statistics are presented and their limitations are discussed. The paper proposes the use of the novel Scenario Theory [1] to overcome said limitations. Two case study are presented backing up the proposed methodology.

## Repository structure

The repository has two sub-directories for the two case study presented in the paper: Tele Assistance Servic (TAS) [2] and Self-Adaptive Video Encoder (SAVE) [3]. Note that this repo is self-contained and there is no need to import material from the references below. Also the datasets used in the paper are included.

## Using

To reproduce the results clone this repository and follow the steps presented in the README files in each of the artifact directories. Both instructions to reproduce the paper results and to re-use the software are included.

[1] https://en.wikipedia.org/wiki/Scenario_optimization

[2] http://homepage.lnu.se/staff/daweaa/TAS/tas.htm

[3] http://www.martinamaggio.com/main/publications/seams17/
