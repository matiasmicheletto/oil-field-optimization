#include "model.h" 

bool dominates(const Solution& A, const Solution& B) {
    return (A.productionLoss <= B.productionLoss && A.travelCost <= B.travelCost) && 
            (A.productionLoss < B.productionLoss || A.travelCost < B.travelCost);
}

bool equivalent(const Solution& A, const Solution& B) {
    const bool equalLoss = areEqual(A.productionLoss, B.productionLoss);
    const bool equalCost = areEqual(A.travelCost, B.travelCost);
    return equalLoss && equalCost;
}

bool findSolution(const Solution& key, const std::vector<Solution>& list) {
    auto it = find_if(
        list.begin(), 
        list.end(), 
        [&key](const Solution& current) {
            return equivalent(key, current);
        }
    );
    return it != list.end();
}

Model::Model(ModelRawData rawData, ModelConfig config) {
    #ifdef VERBOSE
        std::cout << "Building system model... ";
    #endif

    // Set model configuration
    this->distanceMatrix = rawData.distanceMatrix;
    this->config = config;

    // Set list of wells and compute initial total gross production
    this->initialGross = 0.0;
    this->initialNet = 0.0;
    for(uint w = 0; w < rawData.wellParams.size(); w++){
        const double gross = rawData.wellParams[w][0];
        const double net = rawData.wellParams[w][1];
        const double rate = rawData.wellParams[w][2]; // Well rates are expressed in %
        Well well = {gross, net, rate/100.0};
        if(rate < 0.0 || rate > 100.0){
            std::cerr << std::endl << "Error in model configuration. A well cannot have a rate below the minimum configured." << std::endl;
            std::cerr << "In line " << w << ", rate value is " << rate << std::endl;
            exit(1);
        }
        if(gross < net){
            std::cerr << std::endl << "Error in model configuration. Net value cannot be grater than gross." << std::endl;
            std::cerr << "In line " << w << ", gross value is" << gross << " and net is " << net << std::endl;
            exit(1);
        }
        this->wells.push_back(well);
        this->initialGross += well.maxGross * well.initialRate;
        this->initialNet += well.maxNet * well.initialRate;
    }

    this->wellCount = this->wells.size();
    this->initialLoss = this->initialGross - this->initialNet;

    #ifdef VERBOSE
        std::cout << "done." << std::endl;
    #endif
}

Model::~Model() {
    
}

void Model::setConfig(ModelConfig config) {
    // Validate limits values
    for(uint w = 0; w < this->wellCount; w++) {
        if(this->wells[w].initialRate < 0 || this->wells[w].initialRate > 1.0) {
            std::cerr << "Wrong rates set." << std::endl;
            std::cerr << "Well number " << w 
                        << " has a rate of " << this->wells[w].initialRate 
                        << " wich is not in range [0, 100]" << std::endl;
            exit(1);
        }
    }
    this->config = config;
}

void Model::printConfig() {
    std::cout << "Model configuration parameters:" << std::endl;
    std::cout << "  Well count: " << this->wellCount << std::endl;
    std::cout << "  Initial production loss: " << this->initialLoss << " m³/day" << std::endl;
    std::cout << "  Initial production gross: " << this->initialGross << " m³/day" << std::endl;
    std::cout << "  Target gross: " << this->config.targetGross << " m³/day" << std::endl;
    std::cout << "  Tolerance: " << this->config.tolerance << " m³/day" << std::endl;
}

void Model::printInitialRates() {
    std::cout << "Initial rates:" << std::endl;
    for(uint i = 0; i < this->wellCount; i++)
        std::cout << this->wells[i].initialRate << ", ";
    std::cout << std::endl;
}

std::vector<double> Model::getInitialRates() {
    std::vector<double> result;
    std::transform( // Map wells array to initialRates
        this->wells.begin(), 
        this->wells.end(), 
        std::back_inserter(result), 
        [](const Well& el) { return el.initialRate; }
    );
    return result;
}

Solution Model::eval(std::vector<double> rates) {
    
    Solution sol;

    sol.feasibility = FEAS_CODE::FEASIBLE;

    if(rates.size() != this->wellCount){
        sol.feasibility = FEAS_CODE::RATE_LEN;
        return sol;
    }

    double productionNet = 0.0;

    for(uint w = 0; w < this->wellCount; w++) {
        
        if(rates[w] < 0 || rates[w] > 1){
            sol.feasibility = FEAS_CODE::RATE_VAL;
            return sol;
        }

        // Compute travel cost
        for(uint y = 0; y < this->wellCount - w; y++){
            // If "w" and "y" did update their rates
            if(!areEqual(this->wells[w].initialRate, rates[w]) &&
                !areEqual(this->wells[y].initialRate, rates[y])) {
                sol.travelCost += this->distanceMatrix[w][y];
                sol.travelCount++;
            }
        }

        // Compute total net and gross 
        productionNet += this->wells[w].maxNet * rates[w];
        sol.productionGross += this->wells[w].maxGross  * rates[w];
    }

    sol.productionLoss = sol.productionGross - productionNet;

    sol.grossError = sol.productionGross - this->config.targetGross;
    if(std::abs(sol.grossError) > this->config.tolerance)
        sol.feasibility = FEAS_CODE::GROSS_TOL;

    //std::cout << std::endl << "Rates: ";
    //for(uint i = 0; i < this->wellCount; i++) std::cout << rates[i] << ", ";
    //std::cout << "gross: " << sol.productionGross << " -- target: " << this->config.targetGross << " -- error: " <<  sol.grossError << " -- travel count: " << sol.travelCount << " -- feas code: " << sol.feasibility << std::endl;
    //std::cout << std::endl;

    return sol;
}

std::string getFeasibilityDefinition(FEAS_CODE code) {
    switch (code) {
        case FEASIBLE:
            return "Feasible solution.";
        case RATE_VAL:
            return "Invalid rate value, values must fall in (0,100) range.";
        case RATE_LEN:
            return "Invalid rate vector length, rates vector size should match number of wells.";
        case GROSS_TOL:
            return "The resulting production gross is greater than desired production gross +/- tolerance.";
        default:
            return "Unknown feasibility code.";
    }
}