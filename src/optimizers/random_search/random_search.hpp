#ifndef RANDOMSEARCH_H
#define RANDOMSEARCH_H

#include <math.h>
#include "../../random/uniform.h"
#include "../../model/model.h"

enum EXIT_COND {TIMEOUT, MAX_ITERS, STAGNATION};

std::string getExitCond(EXIT_COND code) {
    switch (code) {
        case TIMEOUT:
            return "Optimization timed out.";
        case MAX_ITERS:
            return "Max iterations reached.";
        case STAGNATION:
            return "Algorithm stagnation";
        default:
            return "Unknown exit conditino.";
    }
}

struct OptimizationResults {
    uint execTime;
    EXIT_COND exitCond;
    std::vector<Solution> dominatedSolutions;
    std::vector<Solution> nonDominatedSolutions;

    void print() {
        std::cout << "Optimization performance:" << std::endl;
        std::cout << "  Execution time: " << execTime << " ms" << std::endl;
        std::cout << "  Exit condition: " << getExitCond(exitCond) << std::endl;
        std::cout << "  Dominated solutions: " << dominatedSolutions.size() << std::endl;
        std::cout << "  Pareto solutions: " << nonDominatedSolutions.size() << std::endl;
    }

    void exportSolutions(std::string filename) {
        std::ofstream csvFile(filename, std::ios::out); // Open file in write mode

        if (!csvFile) {
            std::cerr << "Error: Unable to open CSV file." << std::endl;
            return;
        }

        // Header
        csvFile << "Production loss (m³/day), Travel cost, Dominated" << std::endl;
        
        for(uint i = 0; i < dominatedSolutions.size(); i++)
            csvFile << dominatedSolutions[i].productionLoss << "," << dominatedSolutions[i].travelCost << ",yes" << std::endl;
        for(uint i = 0; i < nonDominatedSolutions.size(); i++)
            csvFile << nonDominatedSolutions[i].productionLoss << "," << nonDominatedSolutions[i].travelCost << ",no" << std::endl;

        csvFile.flush();
        csvFile.close();
    }
};

void mutate(std::vector<double> &rates, Uniform &generator, double uP, double step){
    for(uint w = 0; w < rates.size(); w++)
        if(generator.random() < uP) // With probability uP
            rates[w] = clamp(rates[w]+step, 0.0, 1.0);
}

double getStep(double target, double current){
    const double step = (target-current)/target;
    return clamp(step, -1.0, 1.0);
}

OptimizationResults randomSearch(Model model, OptimizationConfig config) {

    #ifdef VERBOSE
        std::cout << "Starting optimizer method: Random Search... ";
    #endif

    auto start = std::chrono::high_resolution_clock::now();

    // Optimization variable array
    std::vector<double> rates = model.getInitialRates();
    
    // Optimization parameters
    
    double mutProb = 0.05; // Probability of updating rate of a certain well
    double mutProbIncrementer = 0.05; // mutProb incrementer to apply after stagnation
    double step = getStep(model.getConfig().targetGross, model.getInitialGross());
    uint failCount = 0; // Non feasible solutions counter (resets after stargantion)
    const uint stagnationCount = 20; // Number of consecutive unfeasible iterations before increase/decrease mutProb
    Uniform uniform(0.0, 1.0); // Random generator (uniform)
    
    // Array of optimal solutions
    std::vector<Solution> nonDominatedSolutions;
    std::vector<Solution> dominatedSolutions;
    
    #ifdef VERBOSE
        std::cout << "Iterations started." << std::endl << std::endl;
    #endif

    EXIT_COND exitCond = MAX_ITERS;
    for(uint iter = 0; iter < config.maxIters; iter++) {

        // Generate a new random candidate
        mutate(rates, uniform, mutProb, step);
        Solution candidate = model.eval(rates);
        
        // Set next candidate's step direction
        step = getStep(model.getConfig().targetGross, candidate.productionGross);
        
        if(candidate.feasibility == FEAS_CODE::FEASIBLE) {

            /*
            std::cout << "Testing solution at " << iter << ": " << std::endl 
                                << "  production loss = " << candidate.productionLoss << " m³/day" << std::endl
                                << "  travel cost = " << candidate.travelCost << std::endl;
            */

            // Check if solution is dominated by any other solution
            bool isDominated = false;
            auto it = nonDominatedSolutions.begin(); 
            while (it != nonDominatedSolutions.end()) {
                if (dominates(*it, candidate)) { // *it > candidate --> dominated
                    isDominated = true;
                    break;
                } // it ?? candidate
                if(dominates(candidate, *it)){ // *it < candidate --> remove *it
                    it = nonDominatedSolutions.erase(it);
                }else{
                    ++it;
                }
            }
            if (isDominated){ // If dominated, add to dominated array
                if(!findSolution(candidate, dominatedSolutions))
                    dominatedSolutions.push_back(candidate);
                
            }else{ // If non dominated, add to nondominated array

                // Check if the same candidate is already in the pareto front
                if(!findSolution(candidate, nonDominatedSolutions)) { // If not found, add to list
                    #ifdef VERBOSE
                        std::cout << "New non-dominated solution at iteration " << iter << ": " << std::endl 
                                    << "  production loss = " << candidate.productionLoss << " m³/day" << std::endl
                                    << "  travel cost = " << candidate.travelCost << std::endl;
                    #endif
                    nonDominatedSolutions.push_back(candidate);
                }
            }
        }else{
            failCount++;
            if(failCount > stagnationCount){ // Stagnation
                mutProb += mutProbIncrementer;
                if(mutProb > 1 || mutProb < 0) // Upper or lower limit reached
                    mutProbIncrementer *= -1; // Invert search direction
                failCount = 0; // Reset counter
            }
        }

        if(isTimeout(start, config.timeout)){
            std::cout << "Timeout" << std::endl;
            exitCond = TIMEOUT;
            break;
        }
    }

    OptimizationResults res = {
        (uint) getElapsed(start), // execTime
        exitCond,
        dominatedSolutions,
        nonDominatedSolutions
    };

    return res;
}


#endif // RANDOMSEARCH_H