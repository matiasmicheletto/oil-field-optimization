#include <iomanip>
#include "../../util/util.h"
#include "../../random/uniform.h"
#include "../../model/model.h"
#include "openGA.hpp"

EA::Chronometer timer;
uint gaTimeout;
Model* gModel;

struct Chromosome {
	std::vector<double> rates;
    Chromosome() {}
};

struct MyMiddleCost {
	double grossDiff;
};

typedef EA::Genetic<Chromosome,MyMiddleCost> GA_Type;
GA_Type ga_obj;

void init_genes(Chromosome& p,const std::function<double(void)> &rnd01) {
    Uniform uniform(0.0, 1.0);
	
    for(uint w = 0; w < gModel->getWellCount(); w++){
        p.rates.push_back(uniform.random());
    }
}

bool eval_solution(const Chromosome& p, MyMiddleCost &c) {
	return true;
}

Chromosome mutate(const Chromosome& X_base,const std::function<double(void)> &rnd01,double shrink_scale) {
	//Chromosome X_new;
	return X_base;
}

Chromosome crossover(const Chromosome& X1, const Chromosome& X2, const std::function<double(void)> &rnd01) {
	//Chromosome X_new;
	return X1;
}

double calculate_SO_total_fitness(const GA_Type::thisChromosomeType &X) {
	return X.middle_costs.grossDiff;
}

std::ofstream output_file;

void SO_report_generation(int generation_number, const EA::GenerationType<Chromosome,MyMiddleCost> &last_generation, const Chromosome& best_genes) {
    ga_obj.user_request_stop = (uint)timer.toc()*1000 > gaTimeout;
}

OptimizationResults gaOptimization(Model* model, uint timeout) {
	gModel = model;
    gaTimeout = timeout;

	timer.tic();

	ga_obj.problem_mode = EA::GA_MODE::SOGA;
	ga_obj.multi_threading = false;
	ga_obj.dynamic_threading = false;
	ga_obj.idle_delay_us = 0;
	ga_obj.verbose = false;
	ga_obj.population = 20;
	ga_obj.generation_max = 100;
	ga_obj.calculate_SO_total_fitness = calculate_SO_total_fitness;
	ga_obj.init_genes = init_genes;
	ga_obj.eval_solution = eval_solution;
	ga_obj.mutate = mutate;
	ga_obj.crossover = crossover;
	ga_obj.SO_report_generation = SO_report_generation;
	ga_obj.best_stall_max = 20;
	ga_obj.average_stall_max = 20;
	ga_obj.tol_stall_best = 1e-6;
	ga_obj.tol_stall_average = 1e-6;
	ga_obj.elite_count = 10;
	ga_obj.crossover_fraction = 0.7;
	ga_obj.mutation_rate = 0.1;
    ga_obj.user_request_stop = false;

	//EA::StopReason exitCond = ga_obj.solve();
    ga_obj.solve();

    #ifdef VERBOSE
        std::cout << "Exit condition: ";
        switch (exitCond) {
            case EA::StopReason::Undefined:
                std::cout << "Undefined" << std::endl;
            case EA::StopReason::MaxGenerations:
                std::cout << " Max. generations" << std::endl;
                break;
            case EA::StopReason::StallAverage:
                std::cout << " Average stall" << std::endl;
                break;
            case EA::StopReason::StallBest:
                std::cout << " Best stall" << std::endl;
                break;
            case EA::StopReason::UserRequest:
                std::cout << "User request (timeout)" << std::endl;
            default:
                break;
        }
    #endif

	OptimizationResults res = {
        0.0, // Loss
        0.0, // Gross
        0.0, // Travel cost
        (uint) timer.toc()*1000,
        FEAS_CODE::FEASIBLE
    };

    return res;
}